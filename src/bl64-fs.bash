#######################################
# BashLib64 / Manage local filesystem
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
#######################################

#######################################
# Change directory ownership with verbose and recursive flags
#
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_chown_dir() {
  $BL64_OS_ALIAS_CHOWN_DIR "$@"
}

#######################################
# Copy files with verbose and force flags
#
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_cp_file() {
  $BL64_OS_ALIAS_CP_FILE "$@"
}

#######################################
# Copy directory recursively with verbose and force flags
#
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_cp_dir() {
  $BL64_OS_ALIAS_CP_DIR "$@"
}

#######################################
# Create one ore more directories, set owner and permissions
#
# Limitations:
#   * Parent directories are not created
# Requirements:
#   * root privilege (sudo)
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
  bl64_dbg_lib_show "parameters:[${*}]"
  bl64_dbg_lib_trace_start
  local mode="${1:-"$BL64_LIB_VAR_TBD"}"
  local user="${2:-"$BL64_LIB_VAR_TBD"}"
  local group="${3:-"$BL64_LIB_VAR_TBD"}"
  local path=''
  local -i status=0

  # Remove consumed parameters
  shift
  shift
  shift

  # shellcheck disable=SC2086
  (($# == 0)) && return $BL64_FS_ERROR_MISSING_PARAMETER
  bl64_dbg_lib_show "parameters:[${*}]"

  for path in "$@"; do

    bl64_check_path_absolute "$path"
    status=$?
    ((status != 0)) && break

    bl64_sudo_run_command "$BL64_OS_CMD_MKDIR" "$BL64_OS_SET_MKDIR_VERBOSE" "$path"
    status=$?
    ((status != 0)) && break

    # Determine if mode needs to be set
    if [[ "$mode" != "$BL64_LIB_VAR_TBD" ]]; then
      bl64_sudo_run_command "$BL64_OS_CMD_CHMOD" "$mode" "$path"
      status=$?
      ((status != 0)) && break
    fi

    # Determine if owner needs to be set
    if [[ "$user" != "$BL64_LIB_VAR_TBD" && "$group" != "$BL64_LIB_VAR_TBD" ]]; then
      bl64_sudo_run_command "$BL64_OS_CMD_CHOWN" "${user}:${group}" "$path"
      status=$?
      ((status != 0)) && break
    fi

  done

  bl64_dbg_lib_trace_stop
  return $status
}

#######################################
# Merge contents from source directory to target
#
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
  local status=0

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' &&
    bl64_check_directory "$source" &&
    bl64_check_directory "$target" ||
    return 1

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    $BL64_OS_ALIAS_CP_DIR --no-target-directory "$source" "$target"
    status=$?
    ;;
  ${BL64_OS_MCOS}-*)
    # shellcheck disable=SC2086
    $BL64_OS_ALIAS_CP_DIR ${source}/ "$target"
    status=$?
    ;;
  ${BL64_OS_ALP}-*)
    shopt -sq dotglob
    # shellcheck disable=SC2086
    $BL64_OS_ALIAS_CP_DIR ${source}/* -t "$target"
    status=$?
    shopt -uq dotglob
    ;;
  esac

  return $status
}

#######################################
# Create a symbolic link with verbose flag
#
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
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
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
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
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_mkdir_full() {
  $BL64_OS_ALIAS_MKDIR_FULL "$@"
}

#######################################
# Move files using the verbose and force flags
#
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_mv() {
  $BL64_OS_ALIAS_MV "$@"
}

#######################################
# Remove files using the verbose and force flags. Limited to current filesystem
#
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_rm_file() {
  $BL64_OS_ALIAS_RM_FILE "$@"
}

#######################################
# Remove directories using the verbose and force flags. Limited to current filesystem
#
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_rm_full() {
  $BL64_OS_ALIAS_RM_FULL "$@"
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
