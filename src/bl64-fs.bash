#######################################
# BashLib64 / Module / Functions / Manage local filesystem
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_fs_create_dir() {
  bl64_msg_show_deprecated 'bl64_fs_create_dir' 'bl64_fs_dir_create'
  bl64_fs_dir_create "$@"
}
function bl64_fs_cp_file() {
  bl64_msg_show_deprecated 'bl64_fs_cp_file' 'bl64_fs_file_copy'
  bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$@"
}
function bl64_fs_cp_dir() {
  bl64_msg_show_deprecated 'bl64_fs_cp_dir' 'bl64_fs_path_copy'
  bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_RECURSIVE" "$@"
}
function bl64_fs_ln_symbolic() {
  bl64_msg_show_deprecated 'bl64_fs_ln_symbolic' 'bl64_fs_symlink_create'
  bl64_fs_symlink_create "$@"
}
function bl64_fs_create_symlink() {
  bl64_msg_show_deprecated 'bl64_fs_create_symlink' 'bl64_fs_symlink_create'
  bl64_fs_symlink_create "$@"
}
function bl64_fs_rm_file() {
  bl64_msg_show_deprecated 'bl64_fs_rm_file' 'bl64_fs_file_remove'
  bl64_fs_file_remove "$@"
}
function bl64_fs_rm_full() {
  bl64_msg_show_deprecated 'bl64_fs_rm_full' 'bl64_fs_path_remove'
  bl64_fs_path_remove "$@"
}
function bl64_fs_create_file() {
  bl64_msg_show_deprecated 'bl64_fs_create_file' 'bl64_fs_file_create'
  bl64_fs_file_create "$@"
}
function bl64_fs_copy_files() {
  bl64_msg_show_deprecated 'bl64_fs_copy_files' 'bl64_fs_file_copy'
  bl64_fs_file_copy "$@"
}
function bl64_fs_safeguard() {
  bl64_msg_show_deprecated 'bl64_fs_safeguard' 'bl64_fs_path_archive'
  bl64_fs_path_archive "$@"
}
function bl64_fs_restore() {
  bl64_msg_show_deprecated 'bl64_fs_restore' 'bl64_fs_path_recover'
  bl64_fs_path_recover "$@"
}
function bl64_fs_find_files() {
  bl64_msg_show_deprecated 'bl64_fs_find_files' 'bl64_fs_file_search'
  bl64_fs_file_search "$@"
}
function bl64_fs_chown_dir() {
  bl64_msg_show_deprecated 'bl64_fs_chown_dir' 'bl64_fs_run_chown'
  bl64_fs_run_chown "$BL64_FS_SET_CHOWN_RECURSIVE" "$@"
}
function bl64_fs_chmod_dir() {
  bl64_msg_show_deprecated 'bl64_fs_chmod_dir' 'bl64_fs_run_chmod'
  bl64_fs_run_chmod "$BL64_FS_SET_CHMOD_RECURSIVE" "$@"
}
function bl64_fs_mkdir_full() {
  bl64_msg_show_deprecated 'bl64_fs_mkdir_full' 'bl64_fs_run_mkdir'
  bl64_fs_run_mkdir "$BL64_FS_SET_MKDIR_PARENTS" "$@"
}
function bl64_fs_merge_files() {
  bl64_msg_show_deprecated 'bl64_fs_merge_files' 'bl64_fs_file_merge'
  bl64_fs_file_merge "$@"
}
function bl64_fs_merge_dir() {
  bl64_msg_show_deprecated 'bl64_fs_merge_dir' 'bl64_fs_path_merge'
  bl64_fs_path_merge "$@"
}
function bl64_fs_set_permissions() {
  bl64_dbg_lib_show_function "$@"
  bl64_msg_show_deprecated 'bl64_fs_set_permissions' 'bl64_fs_path_permission_set'
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local path=''

  shift
  shift
  shift

  bl64_fs_path_permission_set \
    "$mode" \
    "$mode" \
    "$user" \
    "$group" \
    "$BL64_VAR_OFF" \
    "$@"
}

function bl64_fs_fix_permissions() {
  bl64_dbg_lib_show_function "$@"
  bl64_msg_show_deprecated 'bl64_fs_fix_permissions' 'bl64_fs_path_permission_set'
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local path=''

  shift
  shift

  bl64_fs_path_permission_set \
    "$file_mode" \
    "$dir_mode" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_ON" \
    "$@"
}

#
# Private functions
#

function _bl64_fs_path_permission_set_file() {
  bl64_dbg_lib_show_function "$@"
  local mode="$1"
  local recursive="$2"
  local path="$3"

  bl64_lib_var_is_default "$mode" && return 0
  bl64_msg_show_lib_subtask "set file permissions (${file_mode} ${BL64_MSG_COSMETIC_ARROW} ${path})"
  if bl64_lib_flag_is_enabled "$recursive"; then
    # shellcheck disable=SC2086
    bl64_fs_run_find \
      "$path" \
      ${BL64_FS_SET_FIND_STAY} \
      ${BL64_FS_SET_FIND_TYPE_FILE} \
      ${BL64_FS_SET_FIND_RUN} "$BL64_FS_CMD_CHMOD" "$file_mode" "{}" \;
  else
    [[ ! -f "$path" ]] && return 0
    bl64_fs_run_chmod "$mode" "$path"
  fi
}

function _bl64_fs_path_permission_set_dir() {
  bl64_dbg_lib_show_function "$@"
  local mode="$1"
  local recursive="$2"
  local path="$3"

  bl64_lib_var_is_default "$mode" && return 0
  bl64_msg_show_lib_subtask "set directory permissions (${dir_mode} ${BL64_MSG_COSMETIC_ARROW} ${path})"
  if bl64_lib_flag_is_enabled "$recursive"; then
    # shellcheck disable=SC2086
    bl64_fs_run_find \
      "$path" \
      ${BL64_FS_SET_FIND_STAY} \
      ${BL64_FS_SET_FIND_TYPE_DIR} \
      ${BL64_FS_SET_FIND_RUN} "$BL64_FS_CMD_CHMOD" "$dir_mode" "{}" \;
  else
    [[ ! -d "$path" ]] && return 0
    bl64_fs_run_chmod "$mode" "$path"
  fi
}

function _bl64_fs_path_permission_set_user() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local recursive="$2"
  local path="$3"
  local cli_options=' '

  bl64_lib_var_is_default "$user" && return 0
  bl64_lib_flag_is_enabled "$recursive" && cli_options="$BL64_FS_SET_CHOWN_RECURSIVE"
  bl64_msg_show_lib_subtask "set new file owner (${user} ${BL64_MSG_COSMETIC_ARROW2} ${path})"
  # shellcheck disable=SC2086
  bl64_fs_run_chown \
    $cli_options \
    "${user}" \
    "$path"
}

function _bl64_fs_path_permission_set_group() {
  bl64_dbg_lib_show_function "$@"
  local group="$1"
  local recursive="$2"
  local path="$3"
  local cli_options=' '

  bl64_lib_var_is_default "$group" && return 0
  bl64_lib_flag_is_enabled "$recursive" && cli_options="$BL64_FS_SET_CHOWN_RECURSIVE"
  bl64_msg_show_lib_subtask "set new file group (${group} ${BL64_MSG_COSMETIC_ARROW2} ${path})"
  # shellcheck disable=SC2086
  bl64_fs_run_chown \
    $cli_options \
    ":${group}" \
    "$path"
}

#
# Public functions
#

#######################################
# Create one ore more directories, then set owner and permissions
#
#  Features:
#   * If the new path is already present nothing is done. No error or warning is presented
# Limitations:
#   * No rollback in case of errors. The process will not remove already created paths
#   * Parents are created, but permissions and ownership is not changed
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $@: full directory paths
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_dir_create() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local path=''

  # Remove consumed parameters
  shift
  shift
  shift

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "path list:[${*}]"

  for path in "$@"; do
    bl64_check_path_absolute "$path" || return $?
    [[ -d "$path" ]] && continue
    bl64_msg_show_lib_subtask "create directory (${path})"
    bl64_fs_run_mkdir \
      "$BL64_FS_SET_MKDIR_PARENTS" \
      "$path" &&
      bl64_fs_path_permission_set \
        "$BL64_VAR_DEFAULT" \
        "$mode" \
        "$user" \
        "$group" \
        "$BL64_VAR_OFF" \
        "$path" ||
      return $?
  done
  return 0
}

#######################################
#  Remove paths (files, directories)
#
# * Recursive
# * No error if the path is not present
# * No backup previous to removal
#
# Arguments:
#   $@: list of full paths
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_path_remove() {
  bl64_dbg_lib_show_function "$@"
  local path_current=''

  bl64_check_parameters_none "$#" ||
    return $?

  for path_current in "$@"; do
    [[ ! -e "$path_current" ]] && continue
    bl64_msg_show_lib_subtask "remove path (${path_current})"
    bl64_fs_run_rm \
      "$BL64_FS_SET_RM_FORCE" \
      "$BL64_FS_SET_RM_RECURSIVE" \
      "$path_current" ||
      return $?
  done
}

#######################################
# Copy one ore more paths to a single destination. Optionally set owner and permissions
#
# * Root privilege (sudo) needed if paths are restricted or change owner is requested
# * No rollback in case of errors. The process will not remove already copied files
# * Recursive
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: use current umask
#   $2: directory permissions. Format: chown format. Default: use current umask
#   $3: user name. Default: current
#   $4: group name. Default: current
#   $5: destination path. Created if not present
#   $@: full source paths. Directory and/or files
# Outputs:
#   STDOUT: verbose operation
#   STDERR: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_path_copy() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local group="${4:-${BL64_VAR_DEFAULT}}"
  local destination="${5:-${BL64_VAR_DEFAULT}}"
  local path_current=''
  local path_base=

  shift
  shift
  shift
  shift
  shift

  bl64_check_parameter 'destination' || return $?

  [[ "$#" == 0 ]] &&
    bl64_msg_show_warning 'there are no files to copy. No further action taken' &&
    return 0

  bl64_fs_dir_create \
    "$dir_mode" \
    "$user" \
    "$group" \
    "$destination" ||
    return $?

  # shellcheck disable=SC2086
  bl64_msg_show_lib_subtask "copy paths (${*} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
  # shellcheck disable=SC2086
  bl64_fs_run_cp \
    $BL64_FS_SET_CP_FORCE \
    $BL64_FS_SET_CP_RECURSIVE \
    "$@" \
    "$destination" ||
    return $?

  for path_current in "$@"; do
    path_base="$(bl64_fmt_path_get_basename "$path_current")"
    bl64_fs_path_permission_set \
      "$file_mode" \
      "$dir_mode" \
      "$user" \
      "$group" \
      "$BL64_VAR_ON" \
      "${destination}/${path_base}" ||
      return $?
  done
}

#######################################
# Copy one ore more files to a single destination. Optionally set owner and permissions
#
# * Root privilege (sudo) needed if paths are restricted or change owner is requested
# * No rollback in case of errors. The process will not remove already copied files
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: destination path. Must exist
#   $@: full file paths. No wildcards allowed
# Outputs:
#   STDOUT: verbose operation
#   STDERR: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_file_copy() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local destination="${4:-${BL64_VAR_DEFAULT}}"
  local path_current=''
  local path_base=

  # Remove consumed parameters
  shift
  shift
  shift
  shift

  bl64_check_parameter 'destination' &&
    bl64_check_directory "$destination" || return $?

  [[ "$#" == 0 ]] &&
    bl64_msg_show_warning 'there are no files to copy. No further action taken' &&
    return 0

  # shellcheck disable=SC2086
  bl64_msg_show_lib_subtask "copy files (${*} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
  # shellcheck disable=SC2086
  bl64_fs_run_cp \
    $BL64_FS_SET_CP_FORCE \
    "$@" \
    "$destination" ||
    return $?

  for path_current in "$@"; do
    path_base="$(bl64_fmt_path_get_basename "$path_current")"
    bl64_fs_path_permission_set \
      "$file_mode" \
      "$BL64_VAR_DEFAULT" \
      "$user" \
      "$group" \
      "$BL64_VAR_OFF" \
      "${destination}/${path_base}" ||
      return $?
  done
}

#######################################
# Merge 2 or more files into a new one, then set owner and permissions
#
# * If the destination is already present no update is done unless requested
# * If asked to replace destination, no backup is done. Caller must take one if needed
# * If merge fails, the incomplete file will be removed
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: replace existing content. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $5: destination file. Full path
#   $@: source files. Full path
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   command dependant
#   $BL64_FS_ERROR_EXISTING_FILE
#   $BL64_LIB_ERROR_TASK_FAILED
#######################################
function bl64_fs_file_merge() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local replace="${4:-${BL64_VAR_DEFAULT}}"
  local destination="${5:-${BL64_VAR_DEFAULT}}"
  local path=''
  local -i status=0
  local -i first=1

  bl64_check_parameter 'destination' &&
    bl64_fs_check_new_file "$destination" &&
    bl64_check_overwrite "$destination" "$replace" ||
    return $?

  # Remove consumed parameters
  shift
  shift
  shift
  shift
  shift
  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "source files:[${*}]"

  for path in "$@"; do
    bl64_msg_show_lib_subtask "merge content from source (${path} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
    if ((first == 1)); then
      first=0
      bl64_check_path_absolute "$path" &&
        "$BL64_OS_CMD_CAT" "$path" >"$destination"
    else
      bl64_check_path_absolute "$path" &&
        "$BL64_OS_CMD_CAT" "$path" >>"$destination"
    fi
    status=$?
    ((status != 0)) && break
    :
  done

  if ((status == 0)); then
    bl64_dbg_lib_show_comments "merge commplete, update permissions if needed (${destination})"
    bl64_fs_path_permission_set "$mode" "$BL64_VAR_DEFAULT" "$user" "$group" "$BL64_VAR_OFF" "$destination"
    status=$?
  else
    bl64_dbg_lib_show_comments "merge failed, removing incomplete file (${destination})"
    bl64_fs_file_remove "$destination"
  fi

  return "$status"
}

#######################################
# Merge directory contents from source directory to target
#
# * Content includes files and directories
# * Recursive should not be disabled if the source contains directories, as it will fail
#
# Requirements:
#   * root privilege (sudo) if the files are restricted
# Arguments:
#   $1: source path
#   $2: target path
#   $3: recursive. Default: ON
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_path_merge() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_VAR_DEFAULT}}"
  local target="${2:-${BL64_VAR_DEFAULT}}"
  local recursive="${3:-${BL64_VAR_ON}}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' &&
    bl64_check_directory "$source" &&
    bl64_check_directory "$target" ||
    return $?

  bl64_msg_show_lib_subtask "merge directories content (${source} ${BL64_MSG_COSMETIC_ARROW2} ${target})"
  if bl64_lib_flag_is_enabled "$recursive"; then
    recursive="$BL64_FS_SET_CP_RECURSIVE"
  else
    recursive=''
  fi
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" --no-target-directory "$source" "$target"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" --no-target-directory "$source" "$target"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" --no-target-directory "$source" "$target"
      ;;
    ${BL64_OS_ALP}-*)
      # shellcheck disable=SC2086
      shopt -sq dotglob &&
        bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" ${source}/* -t "$target" &&
        shopt -uq dotglob
      ;;
    ${BL64_OS_ARC}-*)
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" --no-target-directory "$source" "$target"
      ;;
    ${BL64_OS_MCOS}-*)
      # shellcheck disable=SC2086
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" ${source}/ "$target"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_chown() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_CHOWN_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CHOWN" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Warning: mktemp with no arguments creates a temp file by default
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_mktemp() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_FS_MODULE' ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MKTEMP" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_chmod() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_CHMOD_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CHMOD" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_mkdir() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_MKDIR_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MKDIR" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_mv() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_MV_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MV" $debug "$BL64_FS_SET_MV_FORCE" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove content from OS temporary repositories
#
# * Warning: intented for container build only, not to run on regular OS
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
  bl64_dbg_lib_show_function
  local target=''

  target='/tmp'
  bl64_msg_show_lib_subtask "clean up OS temporary files (${target})"
  bl64_fs_path_remove -- "${target}"/[[:alnum:]]*

  target='/var/tmp'
  bl64_msg_show_lib_subtask "clean up OS temporary files (${target})"
  bl64_fs_path_remove -- "${target}"/[[:alnum:]]*
  return 0
}

#######################################
# Remove or reset logs from standard locations
#
# * Warning: intented for container build only, not to run on regular OS
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
  bl64_dbg_lib_show_function
  local target='/var/log'

  if [[ -d "$target" ]]; then
    bl64_msg_show_lib_subtask "clean up OS logs (${target})"
    bl64_fs_path_remove "${target}"/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Remove or reset OS caches from standard locations
#
# * Warning: intented for container build only, not to run on regular OS
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
  bl64_dbg_lib_show_function
  local target='/var/cache/man'

  if [[ -d "$target" ]]; then
    bl64_msg_show_lib_subtask "clean up OS cache contents (${target})"
    bl64_fs_path_remove "${target}"/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Performs a complete cleanup of OS ephemeral content
#
# * Warning: intented for container build only, not to run on regular OS
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
  bl64_dbg_lib_show_function

  bl64_fs_cleanup_tmps
  bl64_fs_cleanup_logs
  bl64_fs_cleanup_caches

  return 0
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_find() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_check_command "$BL64_FS_CMD_FIND" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_FS_CMD_FIND" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Find files and report as list
#
# * Not using bl64_fs_run_find to avoid file expansion for -name
#
# Arguments:
#   $1: search path
#   $2: search pattern. Format: find -name options
#   $3: search content in text files
# Outputs:
#   STDOUT: file list. One path per line
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_file_search() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-.}"
  local pattern="${2:-${BL64_VAR_DEFAULT}}"
  local content="${3:-${BL64_VAR_DEFAULT}}"

  bl64_check_command "$BL64_FS_CMD_FIND" &&
    bl64_check_directory "$path" || return $?

  bl64_lib_var_is_default "$pattern" && pattern=''

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  if bl64_lib_var_is_default "$content"; then
    "$BL64_FS_CMD_FIND" \
      "$path" \
      -type 'f' \
      ${pattern:+-name "${pattern}"} \
      -print
  else
    "$BL64_FS_CMD_FIND" \
      "$path" \
      -type 'f' \
      ${pattern:+-name "${pattern}"} \
      -exec \
      "$BL64_TXT_CMD_GREP" \
      "$BL64_TXT_SET_GREP_SHOW_FILE_ONLY" \
      "$BL64_TXT_SET_GREP_ERE" "$content" \
      "{}" \;
  fi
  bl64_dbg_lib_trace_stop

}

#######################################
# Archive path to a temporary location
#
# * Use for file/dir operations that will alter or replace the content and requires a quick rollback mechanism
# * The original path is renamed until bl64_fs_path_recover is called to either remove or restore it
# * If the source is not present nothing is done. Return with no error. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_path_archive)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_path_archive() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local backup="${source}${BL64_FS_ARCHIVE_POSTFIX}"

  bl64_check_parameter 'source' ||
    return $?

  # Return if not present
  if [[ ! -e "$source" ]]; then
    bl64_dbg_lib_show_comments "path is not yet created, nothing to do (${source})"
    return 0
  fi

  bl64_msg_show_lib_subtask "backup source path ([${source}]->[${backup}])"
  if ! bl64_fs_run_mv "$source" "$backup"; then
    bl64_msg_show_lib_error "unable to archive source path ($source)"
    return "$BL64_LIB_ERROR_TASK_BACKUP"
  fi

  return 0
}

#######################################
# Recover path from safeguard if operation failed or remove if operation was ok
#
# * Use as a quick rollback for file/dir operations
# * Called after bl64_fs_path_archive creates the backup
# * If the backup is not there nothing is done, no error returned. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_path_archive)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_path_recover() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local -i result=$2
  local backup="${source}${BL64_FS_ARCHIVE_POSTFIX}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'result' ||
    return $?

  # Return if not present
  if [[ ! -e "$backup" ]]; then
    bl64_dbg_lib_show_comments "backup was not created, nothing to do (${backup})"
    return 0
  fi

  # Check if restore is needed based on the operation result
  if ((result == 0)); then
    bl64_msg_show_lib_subtask "remove obsolete backup (${backup})"
    bl64_fs_path_remove "$backup"
    return 0
  else
    bl64_msg_show_lib_subtask "restore original path from backup ([${backup}]->[${source}])"
    # shellcheck disable=SC2086
    bl64_fs_run_mv "$backup" "$source" ||
      return "$BL64_LIB_ERROR_TASK_RESTORE"
  fi
}

#######################################
# Set path permissions and ownership
#
# * Path: directory and/or file only
# * Allow different permissions for files and directories
# * Requires root privilege if current user is not the path owner
# * Path wildcards are not allowed
# * Recursive
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: no change
#   $2: directory permissions. Format: chown format. Default: no change
#   $3: user name. Default: no change
#   $4: group name. Default: no change
#   $5: Recursive. Format: ON|OFF. Default: OFF
#   $@: list of paths. Must use full path for each
# Outputs:
#   STDOUT: command stdin
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_path_permission_set() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local group="${4:-${BL64_VAR_DEFAULT}}"
  local recursive="${5:-${BL64_VAR_DEFAULT}}"
  local target_path=''

  bl64_lib_var_is_default "$recursive" && recursive="$BL64_VAR_OFF"
  # Remove consumed parameters
  shift
  shift
  shift
  shift
  shift

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "path list:[${*}]"
  for target_path in "$@"; do
    bl64_check_path "$target_path" || return $?
    _bl64_fs_path_permission_set_file "$file_mode" "$recursive" "$target_path" &&
      _bl64_fs_path_permission_set_dir "$dir_mode" "$recursive" "$target_path" &&
      _bl64_fs_path_permission_set_user "$user" "$recursive" "$target_path" &&
      _bl64_fs_path_permission_set_group "$group" "$recursive" "$target_path" ||
      return $?
  done
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_cp() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_CP_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CP" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_rm() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_CP_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_RM" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_ls() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_FS_CMD_LS" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_ln() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_LN_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_LN" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Set default path creation permission with umask
#
# * Uses symbolic permission form
# * Supports predefined sets: BL64_FS_UMASK_*
#
# Arguments:
#   $1: permission. Format: BL64_FS_UMASK_RW_USER
# Outputs:
#   STDOUT: None
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_fs_set_umask() {
  bl64_dbg_lib_show_function "$@"
  local permissions="${1:-${BL64_FS_UMASK_RW_USER}}"

  bl64_dbg_lib_show_comments "temporary change current script umask (${permissions})"
  umask -S "$permissions" >/dev/null
}

#######################################
# Set global ephemeral paths for bashlib64 functions
#
# * When set, bashlib64 can use these locations as alternative paths to standard ephemeral locations (tmp, cache, etc)
# * Path is created if not already present
#
# Arguments:
#   $1: Temporal files. Short lived, data should be removed after usage. Format: full path
#   $2: cache files. Lifecycle managed by the consumer. Data can persist between runs. If data is removed, consumer should be able to regenerate it. Format: full path
#   $3: permissions. Format: chown format. Default: use current umask
#   $4: user name. Default: current
#   $5: group name. Default: current
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_set_ephemeral() {
  bl64_dbg_lib_show_function "$@"
  local temporal="${1:-${BL64_VAR_DEFAULT}}"
  local cache="${2:-${BL64_VAR_DEFAULT}}"
  local mode="${3:-${BL64_VAR_DEFAULT}}"
  local user="${4:-${BL64_VAR_DEFAULT}}"
  local group="${5:-${BL64_VAR_DEFAULT}}"

  if [[ "$temporal" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_dir_create "$mode" "$user" "$group" "$temporal" &&
      BL64_FS_PATH_TEMPORAL="$temporal" ||
      return $?
  fi

  if [[ "$cache" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_dir_create "$mode" "$user" "$group" "$cache" &&
      BL64_FS_PATH_CACHE="$cache" ||
      return $?
  fi

  return 0
}

#######################################
# Create temporal directory
#
# * Wrapper for the mktemp tool
#
# Arguments:
#   None
# Outputs:
#   STDOUT: full path to temp dir
#   STDERR: error messages
# Returns:
#   0: temp created ok
#  >0: failed to create temp
#######################################
function bl64_fs_create_tmpdir() {
  bl64_dbg_lib_show_function
  local template="${BL64_FS_TMP_PREFIX}-${BL64_SCRIPT_NAME}.XXXXXXXXXX"

  bl64_fs_run_mktemp \
    "$BL64_FS_SET_MKTEMP_DIRECTORY" \
    "$BL64_FS_SET_MKTEMP_TMPDIR" "$BL64_FS_PATH_TMP" \
    "$template"
}

#######################################
# Create temporal file
#
# * Wrapper for the mktemp tool
#
# Arguments:
#   None
# Outputs:
#   STDOUT: full path to temp file
#   STDERR: error messages
# Returns:
#   0: temp created ok
#  >0: failed to create temp
#######################################
function bl64_fs_create_tmpfile() {
  bl64_dbg_lib_show_function
  local template="${BL64_FS_TMP_PREFIX}-${BL64_SCRIPT_NAME}.XXXXXXXXXX"

  bl64_fs_run_mktemp \
    "$BL64_FS_SET_MKTEMP_TMPDIR" "$BL64_FS_PATH_TMP" \
    "$template"
}

#######################################
# Remove temporal directory created by bl64_fs_create_tmpdir
#
# Arguments:
#   $1: full path to the tmpdir
# Outputs:
#   STDOUT: None
#   STDERR: error messages
# Returns:
#   0: temp removed ok
#  >0: failed to remove temp
#######################################
function bl64_fs_rm_tmpdir() {
  bl64_dbg_lib_show_function "$@"
  local tmpdir="$1"

  bl64_check_parameter 'tmpdir' &&
    bl64_check_directory "$tmpdir" ||
    return $?

  if [[ "$tmpdir" != ${BL64_FS_PATH_TMP}/${BL64_FS_TMP_PREFIX}-*.* ]]; then
    bl64_msg_show_lib_error "provided directory was not created by bl64_fs_create_tmpdir (${tmpdir})"
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi

  bl64_fs_path_remove "$tmpdir"
}

#######################################
# Remove temporal file create by bl64_fs_create_tmpfile
#
# Arguments:
#   $1: full path to the tmpfile
# Outputs:
#   STDOUT: None
#   STDERR: error messages
# Returns:
#   0: temp removed ok
#  >0: failed to remove temp
#######################################
function bl64_fs_rm_tmpfile() {
  bl64_dbg_lib_show_function "$@"
  local tmpfile="$1"

  bl64_check_parameter 'tmpfile' &&
    bl64_check_file "$tmpfile" ||
    return $?

  if [[ "$tmpfile" != ${BL64_FS_PATH_TMP}/${BL64_FS_TMP_PREFIX}-*.* ]]; then
    bl64_msg_show_lib_error "provided directory was not created by bl64_fs_create_tmpfile (${tmpfile})"
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi

  bl64_fs_file_remove "$tmpfile"
}

#######################################
# Check that the new file path is valid
#
# * If path exists, check that is not a directory
# * Check is ok when path does not exist or exists but it's a file
#
# Arguments:
#   $1: new file path
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_fs_check_new_file() {
  bl64_dbg_lib_show_function "$@"
  local file="${1:-}"

  bl64_check_parameter 'file' ||
    return $?

  if [[ -d "$file" ]]; then
    bl64_msg_show_check "invalid file destination. Provided path exists and is a directory (${file})"
    return "$BL64_LIB_ERROR_PARAMETER_INVALID"
  fi

  return 0
}

#######################################
# Check that the new directory path is valid
#
# * If path exists, check that is not a file
# * Check is ok when path does not exist or exists but it's a directory
#
# Arguments:
#   $1: new directory path
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_fs_check_new_dir() {
  bl64_dbg_lib_show_function "$@"
  local directory="${1:-}"

  bl64_check_parameter 'directory' ||
    return $?

  if [[ -f "$directory" ]]; then
    bl64_msg_show_check "invalid directory destination. Provided path exists and is a file (${directory})"
    return "$BL64_LIB_ERROR_PARAMETER_INVALID"
  fi

  return 0
}

#######################################
# Create symbolic link
#
# * Wrapper for the ln -s command
# * Provide extra checks and verbosity
#
# Arguments:
#   $1: source path
#   $2: destination path
#   $3: overwrite symlink if already present?
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_symlink_create() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local destination="${2:-}"
  local overwrite="${3:-$BL64_VAR_OFF}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_path "$source" ||
    return $?

  bl64_msg_show_lib_subtask "create symbolic link (${source} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"

  if [[ -L "$destination" ]]; then
    if [[ "$overwrite" == "$BL64_VAR_ON" ]]; then
      bl64_fs_file_remove "$destination" ||
        return $?
    else
      bl64_msg_show_warning "target symbolic link is already present. No further action taken (${destination})"
      return 0
    fi
  elif [[ -f "$destination" ]]; then
    bl64_msg_show_lib_error 'invalid destination. It is already present and it is a regular file'
    return "$BL64_LIB_ERROR_TASK_REQUIREMENTS"
  elif [[ -d "$destination" ]]; then
    bl64_msg_show_lib_error 'invalid destination. It is already present and it is a directory'
    return "$BL64_LIB_ERROR_TASK_REQUIREMENTS"
  fi
  bl64_fs_run_ln "$BL64_FS_SET_LN_SYMBOLIC" "$source" "$destination" ||
    return $?
  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    bl64_dbg_lib_show_comments 'emulating Linux behaviour for symbolic link permissions'
    bl64_fs_run_chmod "$BL64_FS_SET_CHMOD_SYMLINK" '0777' "$destination"
  fi
}

#######################################
# Creates an empty regular file
#
# * Creates file if not existing only
#
# Arguments:
#   $1: full path to the file
#   $2: (optional) permissions. Format: chown format. Default: use current umask
#   $3: (optional) user name. Default: current
#   $4: (optional) group name. Default: current
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_file_create() {
  bl64_dbg_lib_show_function "$@"
  local file_path="$1"
  local mode="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local group="${4:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'file_path' ||
    return $?

  [[ -f "$file_path" ]] && return 0

  bl64_msg_show_lib_subtask "create empty regular file (${file_path})"
  bl64_fs_run_touch "$file_path" &&
    bl64_fs_path_permission_set \
      "$mode" \
      "$BL64_VAR_DEFAULT" \
      "$user" \
      "$group" \
      "$BL64_VAR_OFF" \
      "$file_path"
}

#######################################
#  Remove files
#
# * No error if the path is not present
# * No backup previous to removal
# * Will only remove files and links
#
# Arguments:
#   $@: list of full file paths
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_file_remove() {
  bl64_dbg_lib_show_function "$@"
  local path_current=''

  [[ "$#" == 0 ]] &&
    bl64_msg_show_warning 'there are no files to remove. No further action taken' &&
    return 0

  for path_current in "$@"; do
    [[ ! -e "$path_current" && ! -L "$path_current" ]] &&
      bl64_dbg_lib_show_info 'file already removed. No further action taken' &&
      continue
    bl64_msg_show_lib_subtask "remove file (${path_current})"

    [[ ! -f "$path_current" && ! -L "$path_current" ]] &&
      bl64_msg_show_lib_error 'invalid file type. It must be a regular file or a symlink. No further action taken.' &&
      return "$BL64_LIB_ERROR_TASK_FAILED"

    bl64_fs_run_rm \
      "$BL64_FS_SET_RM_FORCE" \
      "$path_current" ||
      return $?
  done
}

#######################################
#  Recreate ephemeral directory path
#
# * No error if the path is not present
# * No backup previous to removal
# * Recursive delete if path is present
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $@: full directory paths
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_dir_reset() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"

  # Remove consumed parameters
  shift
  shift
  shift

  bl64_fs_path_remove "$@" &&
    bl64_fs_dir_create "$mode" "$user" "$group" "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_run_touch() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_TOUCH" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Backup path
#
# * Use for file  operations that will alter or replace the content and requires a quick rollback mechanism
# * The original file is copied until bl64_fs_file_restore is called to either remove or restore it
# * If the source is not present nothing is done. Return with no error. This is to cover for first time path creation
#
# Arguments:
#   $1: file path
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_file_backup() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local backup="${source}${BL64_FS_BACKUP_POSTFIX}"

  bl64_check_parameter 'source' || return $?
  [[ ! -f "$source" ]] && bl64_dbg_lib_show_comments "file is not yet created, nothing to do (${source})" && return 0

  bl64_msg_show_lib_subtask "backup original file ([${source}]->[${backup}])"
  if ! bl64_fs_run_cp "$source" "$backup"; then
    bl64_msg_show_lib_error 'failed to create file backup'
    return "$BL64_LIB_ERROR_TASK_BACKUP"
  fi

  return 0
}

#######################################
# Restore path from safeguard if operation failed or remove if operation was ok
#
# * Use as a quick rollback for file/dir operations
# * Called after bl64_fs_file_archive creates the backup
# * If the backup is not there nothing is done, no error returned. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_file_backup)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_file_restore() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local -i result=$2
  local backup="${source}${BL64_FS_BACKUP_POSTFIX}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'result' ||
    return $?

  bl64_dbg_lib_show_comments 'Return if not present'
  if [[ ! -f "$backup" ]]; then
    bl64_dbg_lib_show_info "backup was not created, nothing to do (${backup})"
    return 0
  fi

  bl64_dbg_lib_show_comments 'Check if restore is needed based on the operation result'
  if ((result == 0)); then
    bl64_msg_show_lib_subtask 'discard obsolete backup'
    bl64_fs_file_remove "$backup"
    return 0
  else
    bl64_msg_show_lib_subtask "restore original file from backup ([${backup}]->[${source}])"
    # shellcheck disable=SC2086
    bl64_os_run_cat "$backup" >"$source" &&
      bl64_fs_file_remove "$backup" ||
      return "$BL64_LIB_ERROR_TASK_RESTORE"
  fi
}

#######################################
# Move one ore more paths to a single destination. Optionally set owner and permissions
#
# * Wildcards are not allowed. Use run_mv instead if needed
# * Destination path should be present
# * Root privilege (sudo) needed if paths are restricted or change owner is requested
# * No rollback in case of errors. The process will not remove already copied files
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: use current umask
#   $2: directory permissions. Format: chown format. Default: use current umask
#   $3: user name. Default: current
#   $4: group name. Default: current
#   $5: destination path
#   $@: full source paths. No wildcards allowed
# Outputs:
#   STDOUT: verbose operation
#   STDERR: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_path_move() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local group="${4:-${BL64_VAR_DEFAULT}}"
  local destination="${5:-${BL64_VAR_DEFAULT}}"
  local path_current=''
  local path_base=

  bl64_check_directory "$destination" || return $?

  # Remove consumed parameters
  shift
  shift
  shift
  shift
  shift

  # shellcheck disable=SC2086
  bl64_check_parameters_none "$#" || return $?
  bl64_msg_show_lib_subtask "move paths (${*} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
  # shellcheck disable=SC2086
  bl64_fs_run_mv \
    $BL64_FS_SET_MV_FORCE \
    "$@" \
    "$destination" ||
    return $?

  for path_current in "$@"; do
    path_base="$(bl64_fmt_path_get_basename "$path_current")"
    bl64_fs_path_permission_set \
      "$file_mode" \
      "$dir_mode" \
      "$user" \
      "$group" \
      "$BL64_VAR_ON" \
      "${destination}/${path_base}" ||
      return $?
  done
}
