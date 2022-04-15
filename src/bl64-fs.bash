#######################################
# BashLib64 / Manage local filesystem
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
#######################################

#######################################
# Create one ore more directories, then set owner and permissions
#
# Requirements:
#   * root privilege (sudo) if paths are restricted or change owner is requested
# Limitations:
#   * Parent directories are not created
#   * No rollback in case of errors. The process will not remove already created paths
# Arguments:
#   $1: permissions. Regular chown format accepted. Default: umask defined
#   $2: user name. Default: root
#   $3: group name. Default: root (or equivalent)
#   $@: full directory paths
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_create_dir() {
  local mode="${1:-"$BL64_LIB_VAR_TBD"}"
  local user="${2:-"$BL64_LIB_VAR_TBD"}"
  local group="${3:-"$BL64_LIB_VAR_TBD"}"
  local path=''
  local -i status=0

  # Remove consumed parameters
  bl64_dbg_lib_show_info "parameters:[${*}]"
  shift
  shift
  shift

  # shellcheck disable=SC2086
  (($# == 0)) && return $BL64_FS_ERROR_MISSING_PARAMETER
  bl64_dbg_lib_show_info "parameters:[${*}]"

  for path in "$@"; do

    bl64_check_path_absolute "$path" &&
      bl64_fs_mkdir "$path"
    status=$?
    ((status != 0)) && break

    # Determine if mode needs to be set
    if [[ "$mode" != "$BL64_LIB_VAR_TBD" ]]; then
      bl64_fs_chmod "$mode" "$path"
      status=$?
      ((status != 0)) && break
    fi

    # Determine if owner needs to be set
    if [[ "$user" != "$BL64_LIB_VAR_TBD" && "$group" != "$BL64_LIB_VAR_TBD" ]]; then
      bl64_fs_chown "${user}:${group}" "$path"
      status=$?
      ((status != 0)) && break
    fi

  done

  return $status
}

#######################################
# Copy one ore more files to a single destination, then set owner and permissions
#
# Requirements:
#   * Destination path should be present
#   * root privilege (sudo) if paths are restricted or change owner is requested
# Limitations:
#   * No rollback in case of errors. The process will not remove already copied files
# Arguments:
#   $1: permissions. Regular chown format accepted. Default: umask defined
#   $2: user name. Default: root
#   $3: group name. Default: root (or equivalent)
#   $4: destination path
#   $@: full file paths
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_copy_files() {
  local mode="${1:-"$BL64_LIB_VAR_TBD"}"
  local user="${2:-"$BL64_LIB_VAR_TBD"}"
  local group="${3:-"$BL64_LIB_VAR_TBD"}"
  local destination="${4:-"$BL64_LIB_VAR_TBD"}"
  local path=''
  local target=''
  local -i status=0

  bl64_check_directory "$destination" || return $?

  # Remove consumed parameters
  bl64_dbg_lib_show_info "parameters:[${*}]"
  shift
  shift
  shift
  shift

  # shellcheck disable=SC2086
  (($# == 0)) && return $BL64_FS_ERROR_MISSING_PARAMETER
  bl64_dbg_lib_show_info "parameters:[${*}]"

  for path in "$@"; do

    target=''
    bl64_check_path_absolute "$path" &&
      target="${destination}/$(bl64_fmt_basename "$path")" &&
      bl64_fs_cp_file "$path" "$target" || return $?

    # Determine if mode needs to be set
    if [[ "$mode" != "$BL64_LIB_VAR_TBD" ]]; then
      bl64_fs_chmod "$mode" "$target" || return $?
    fi

    # Determine if owner needs to be set
    if [[ "$user" != "$BL64_LIB_VAR_TBD" && "$group" != "$BL64_LIB_VAR_TBD" ]]; then
      bl64_fs_chown "${user}:${group}" "$target" || return $?
    fi

  done

  return $status
}

#######################################
# Merge contents from source directory to target
#
# Requirements:
#   * root privilege (sudo) if the files are restricted
# Arguments:
#   $1: source path
#   $2: target path
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   bl64_check_parameter
#   bl64_check_directory
#   command exit status
#######################################
function bl64_fs_merge_dir() {
  local source="${1:-${BL64_LIB_VAR_TBD}}"
  local target="${2:-${BL64_LIB_VAR_TBD}}"
  local -i status=0

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' &&
    bl64_check_directory "$source" &&
    bl64_check_directory "$target" ||
    return 1

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    bl64_fs_cp_dir --no-target-directory "$source" "$target"
    status=$?
    ;;
  ${BL64_OS_MCOS}-*)
    # shellcheck disable=SC2086
    bl64_fs_cp_dir ${source}/ "$target"
    status=$?
    ;;
  ${BL64_OS_ALP}-*)
    shopt -sq dotglob
    # shellcheck disable=SC2086
    bl64_fs_cp_dir ${source}/* -t "$target"
    status=$?
    shopt -uq dotglob
    ;;
  esac

  return $status
}

#######################################
# Change object ownership with verbose flag
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_chown() {
  local verbose=''

  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_CHOWN_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_CHOWN" $verbose "$@"
}

#######################################
# Change object permission with verbose flag
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_chmod() {
  local verbose=''

  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_CHMOD_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_CHMOD" $verbose "$@"
}

#######################################
# Change directory ownership with verbose and recursive flags
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_chown_dir() {
  local verbose=''

  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_CHMOD_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_CHMOD" $verbose "$BL64_OS_SET_CHOWN_RECURSIVE" "$@"
}

#######################################
# Copy files with verbose and force flags
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_cp_file() {
  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_CP_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_CP" $verbose "$BL64_OS_SET_CP_FORCE" "$@"
}

#######################################
# Copy directory recursively with verbose and force flags
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_cp_dir() {
  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_CP_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_CP" $verbose "$BL64_OS_SET_CP_FORCE" "$BL64_OS_SET_CP_RECURSIVE" "$@"
}

#######################################
# Create a symbolic link with verbose flag
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_ln_symbolic() {
  $BL64_OS_ALIAS_LN_SYMBOLIC "$@"
}

#######################################
# List files with nocolor flag
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_ls_files() {
  $BL64_OS_ALIAS_LS_FILES "$@"
}

#######################################
# Create full path including parents. Uses verbose flag
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_mkdir() {
  local verbose=''

  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_MKDIR_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_MKDIR" $verbose "$@"
}

#######################################
# Create full path including parents. Uses verbose flag
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_mkdir_full() {
  local verbose=''

  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_MKDIR_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_MKDIR" $verbose "$BL64_OS_SET_MKDIR_PARENTS" "$@"
}

#######################################
# Move files using the verbose and force flags
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_mv() {
  local verbose=''

  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_MV_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_MV" $verbose "$BL64_OS_SET_MV_FORCE" "$@"
}

#######################################
# Remove files using the verbose and force flags. Limited to current filesystem
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_rm_file() {
  local verbose=''

  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_RM_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_RM" $verbose "$BL64_OS_SET_RM_FORCE" "$@"
}

#######################################
# Remove directories using the verbose and force flags. Limited to current filesystem
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_rm_full() {
  local verbose=''

  [[ "$BL64_LIB_VERBOSE" == "$BL64_LIB_VAR_ON" ]] &&
    verbose="$BL64_OS_SET_RM_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_OS_CMD_RM" $verbose "$BL64_OS_SET_RM_FORCE" "$BL64_OS_SET_RM_RECURSIVE" "$@"
}

#######################################
# Remove content from OS temporary repositories
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_tmps() {
  $BL64_OS_ALIAS_RM_FULL -- /tmp/[[:alnum:]]*
  $BL64_OS_ALIAS_RM_FULL -- /var/tmp/[[:alnum:]]*
  return 0
}

#######################################
# Remove or reset logs from standard locations
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_logs() {
  local target='/var/log'

  if [[ -d "$target" ]]; then
    $BL64_OS_ALIAS_RM_FULL ${target}/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Remove or reset OS caches from standard locations
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_caches() {
  local target='/var/cache/man'

  if [[ -d "$target" ]]; then
    $BL64_OS_ALIAS_RM_FULL ${target}/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Performs a complete cleanup of the OS temporary content
#
# * Removes temporary files
# * Cleans caches
# * Removes logs
#
# Arguments:
#   None
# Outputs:
#   STDOUT: output from clean functions
#   STDERR: output from clean functions
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_full() {
  bl64_pkg_cleanup
  bl64_fs_cleanup_tmps
  bl64_fs_cleanup_logs
  bl64_fs_cleanup_caches

  return 0
}
