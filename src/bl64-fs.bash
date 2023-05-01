#######################################
# BashLib64 / Module / Functions / Manage local filesystem
#
# Version: 4.2.0
#######################################

#######################################
# Create one ore more directories, then set owner and permissions
#
#  Features:
#   * If the new path is already present nothing is done. No error or warning is presented
# Limitations:
#   * Parent directories are not created
#   * No rollback in case of errors. The process will not remove already created paths
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $@: full directory paths
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_create_dir() {
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

    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_CREATE_DIR_PATH} (${path})"
    bl64_fs_run_mkdir "$path" &&
      bl64_fs_set_permissions "$mode" "$user" "$group" "$path" ||
      return $?

  done

  return 0
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
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: destination path
#   $@: full file paths
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_copy_files() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local destination="${4:-${BL64_VAR_DEFAULT}}"
  local path=''
  local target=''

  bl64_check_directory "$destination" || return $?

  # Remove consumed parameters
  bl64_dbg_lib_show_info "source files:[${*}]"
  shift
  shift
  shift
  shift

  # shellcheck disable=SC2086
  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "paths:[${*}]"
  for path in "$@"; do

    target=''
    bl64_check_path_absolute "$path" &&
      target="${destination}/$(bl64_fmt_basename "$path")" || return $?

    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_COPY_FILE_PATH} (${target})"
    bl64_fs_cp_file "$path" "$target" &&
      bl64_fs_set_permissions "$mode" "$user" "$group" "$target" ||
      return $?
  done

  return 0
}

#######################################
# Merge 2 or more files into a new one, then set owner and permissions
#
# * If the destination is already present no update is done unless requested
# * If asked to replace destination, no backup is done. User must take one if needed
# * If merge fails the incomplete file will be removed
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: replace existing content. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $5: destination file. Full path
#   $@: source files. Full path
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#   $BL64_FS_ERROR_EXISTING_FILE
#   $BL64_LIB_ERROR_TASK_FAILED
#######################################
function bl64_fs_merge_files() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local replace="${4:-${BL64_VAR_DEFAULT}}"
  local destination="${5:-${BL64_VAR_DEFAULT}}"
  local path=''
  local -i status=0
  local -i first=1

  bl64_check_parameter 'destination' || return $?
  bl64_check_overwrite "$destination" "$replace" || return $?

  # Remove consumed parameters
  shift
  shift
  shift
  shift
  shift
  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "source files:[${*}]"

  for path in "$@"; do
    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_MERGE_ADD_SOURCE} (${path})"
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
    bl64_dbg_lib_show_info "merge commplete, update permissions if needed (${destination})"
    bl64_fs_set_permissions "$mode" "$user" "$group" "$destination"
    status=$?
  else
    bl64_dbg_lib_show_info "merge failed, removing incomplete file (${destination})"
    [[ -f "$destination" ]] && bl64_fs_rm_file "$destination"
  fi

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
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_VAR_DEFAULT}}"
  local target="${2:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' &&
    bl64_check_directory "$source" &&
    bl64_check_directory "$target" ||
    return $?

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_fs_cp_dir --no-target-directory "$source" "$target"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    bl64_fs_cp_dir --no-target-directory "$source" "$target"
    ;;
  ${BL64_OS_SLES}-*)
    bl64_fs_cp_dir --no-target-directory "$source" "$target"
    ;;
  ${BL64_OS_ALP}-*)
    # shellcheck disable=SC2086
    shopt -sq dotglob &&
      bl64_fs_cp_dir ${source}/* -t "$target" &&
      shopt -uq dotglob
    ;;
  ${BL64_OS_MCOS}-*)
    # shellcheck disable=SC2086
    bl64_fs_cp_dir ${source}/ "$target"
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
#   command exit status
#######################################
function bl64_fs_run_chown() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_CHOWN_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CHOWN" $verbose "$@"
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
#   command exit status
#######################################
function bl64_fs_run_chmod() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_CHMOD_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CHMOD" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Change directory ownership recursively
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
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_fs_run_chown "$BL64_FS_SET_CHOWN_RECURSIVE" "$@"
}

#######################################
# Change directory permissions recursively
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_chmod_dir() {
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_fs_run_chmod "$BL64_FS_SET_CHMOD_RECURSIVE" "$@"
}

#######################################
# Copy files with force flag
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
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$@"
}

#######################################
# Copy directory with recursive and force flags
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
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_RECURSIVE" "$@"
}

#######################################
# Create a symbolic link
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
  bl64_dbg_lib_show_function "$@"

  bl64_fs_run_ln "$BL64_FS_SET_LN_SYMBOLIC" "$@"
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
#   command exit status
#######################################
function bl64_fs_run_mkdir() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_MKDIR_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MKDIR" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Create full path including parents
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
  bl64_dbg_lib_show_function "$@"

  bl64_fs_run_mkdir "$BL64_FS_SET_MKDIR_PARENTS" "$@"
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
#   command exit status
#######################################
function bl64_fs_run_mv() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_MV_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MV" $verbose "$BL64_FS_SET_MV_FORCE" "$@"
  bl64_dbg_lib_trace_stop
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
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" || return $?

  bl64_fs_run_rm "$BL64_FS_SET_RM_FORCE" "$@"
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
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" || return $?

  bl64_fs_run_rm "$BL64_FS_SET_RM_FORCE" "$BL64_FS_SET_RM_RECURSIVE" "$@"
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
  bl64_dbg_lib_show_function
  bl64_fs_rm_full -- /tmp/[[:alnum:]]*
  bl64_fs_rm_full -- /var/tmp/[[:alnum:]]*
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
  bl64_dbg_lib_show_function
  local target='/var/log'

  if [[ -d "$target" ]]; then
    bl64_fs_rm_full ${target}/[[:alnum:]]*
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
  bl64_dbg_lib_show_function
  local target='/var/cache/man'

  if [[ -d "$target" ]]; then
    bl64_fs_rm_full ${target}/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Performs a complete cleanup of OS ephemeral content
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
#   command exit status
#######################################
function bl64_fs_run_find() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_FS_CMD_FIND" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_FS_CMD_FIND" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Find files and report as list
#
# * Not using bl64_fs_find to avoid file expansion for -name
#
# Arguments:
#   $1: search path
#   $2: search pattern. Format: find -name options
#   $3: search content in text files
# Outputs:
#   STDOUT: file list. One path per line
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_find_files() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-.}"
  local pattern="${2:-${BL64_VAR_DEFAULT}}"
  local content="${3:-${BL64_VAR_DEFAULT}}"

  bl64_check_command "$BL64_FS_CMD_FIND" &&
    bl64_check_directory "$path" || return $?

  [[ "$pattern" == "$BL64_VAR_DEFAULT" ]] && pattern=''

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  if [[ "$content" == "$BL64_VAR_DEFAULT" ]]; then
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
# Safeguard path to a temporary location
#
# * Use for file/dir operations that will alter or replace the content and requires a quick rollback mechanism
# * The original path is renamed until bl64_fs_restore is called to either remove or restore it
# * If the destination is not present nothing is done. Return with no error. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_safeguard)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_safeguard() {
  bl64_dbg_lib_show_function "$@"
  local destination="${1:-}"
  local backup="${destination}${BL64_FS_SAFEGUARD_POSTFIX}"

  bl64_check_parameter 'destination' ||
    return $?

  # Return if not present
  if [[ ! -e "$destination" ]]; then
    bl64_dbg_lib_show_info "path is not yet created, nothing to do (${destination})"
    return 0
  fi

  bl64_msg_show_lib_task "${_BL64_FS_TXT_SAFEGUARD_OBJECT} ([${destination}]->[${backup}])"
  if ! bl64_fs_run_mv "$destination" "$backup"; then
    bl64_msg_show_error "$_BL64_FS_TXT_SAFEGUARD_FAILED ($destination)"
    return $BL64_LIB_ERROR_TASK_BACKUP
  fi

  return 0
}

#######################################
# Restore path from safeguard if operation failed or remove if operation was ok
#
# * Use as a quick rollback for file/dir operations
# * Called after bl64_fs_safeguard creates the backup
# * If the backup is not there nothing is done, no error returned. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_safeguard)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_restore() {
  bl64_dbg_lib_show_function "$@"
  local destination="${1:-}"
  local result="${2:-}"
  local backup="${destination}${BL64_FS_SAFEGUARD_POSTFIX}"

  bl64_check_parameter 'destination' &&
    bl64_check_parameter 'result' ||
    return $?

  # Return if not present
  if [[ ! -e "$backup" ]]; then
    bl64_dbg_lib_show_info "backup was not created, nothing to do (${backup})"
    return 0
  fi

  # Check if restore is needed based on the operation result
  if [[ "$result" == "$BL64_VAR_OK" ]]; then
    bl64_dbg_lib_show_info 'operation was ok, backup no longer needed, remove it'
    [[ -e "$backup" ]] && bl64_fs_rm_full "$backup"

    # shellcheck disable=SC2086
    return $BL64_VAR_OK
  else
    bl64_dbg_lib_show_info 'operation was NOT ok, remove invalid content'
    [[ -e "$destination" ]] && bl64_fs_rm_full "$destination"

    bl64_msg_show_lib_task "${_BL64_FS_TXT_RESTORE_OBJECT} ([${backup}]->[${destination}])"
    # shellcheck disable=SC2086
    bl64_fs_run_mv "$backup" "$destination" ||
      return $BL64_LIB_ERROR_TASK_RESTORE
  fi
}

#######################################
# Set object permissions and ownership
#
# * work on individual files
# * no recurse option
# * all files get the same permissions, user, group
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: nonde
#   $3: group name. Default: current
#   $@: list of objects. Must use full path for each
# Outputs:
#   STDOUT: command stdin
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_set_permissions() {
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

  # Determine if mode needs to be set
  if [[ "$mode" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_run_chmod "$mode" "$@" || return $?
  fi

  # Determine if owner needs to be set
  if [[ "$user" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_run_chown "${user}" "$@" || return $?
  fi

  # Determine if group needs to be set
  if [[ "$group" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_run_chown ":${group}" "$@" || return $?
  fi

  return 0
}

#######################################
# Fix path permissions
#
# * allow different permissions for files and directories
# * recursive
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: no action
#   $2: directory permissions. Format: chown format. Default: no action
#   $@: list of paths. Must use full path for each
# Outputs:
#   STDOUT: command stdin
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_fix_permissions() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local path=''

  # Remove consumed parameters
  shift
  shift

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "path list:[${*}]"

  if [[ "$file_mode" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_dbg_lib_show_info "fix file permissions (${file_mode})"
    # shellcheck disable=SC2086
    bl64_fs_run_find \
      "$@" \
      ${BL64_FS_SET_FIND_STAY} \
      ${BL64_FS_SET_FIND_TYPE_FILE} \
      ${BL64_FS_SET_FIND_RUN} "$BL64_FS_CMD_CHMOD" "$file_mode" "{}" \; ||
      return $?
  fi

  if [[ "$dir_mode" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_dbg_lib_show_info "fix directory permissions (${dir_mode})"
    # shellcheck disable=SC2086
    bl64_fs_run_find \
      "$@" \
      ${BL64_FS_SET_FIND_STAY} \
      ${BL64_FS_SET_FIND_TYPE_DIR} \
      ${BL64_FS_SET_FIND_RUN} "$BL64_FS_CMD_CHMOD" "$dir_mode" "{}" \; ||
      return $?
  fi

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
#   command exit status
#######################################
function bl64_fs_run_cp() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_CP_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CP" $verbose "$@"
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
#   command exit status
#######################################
function bl64_fs_run_rm() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_CP_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_RM" $verbose "$@"
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
#   command exit status
#######################################
function bl64_fs_run_ls() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" || return $?

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
#   command exit status
#######################################
function bl64_fs_run_ln() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_LN_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_LN" $verbose "$@"
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
#   command exit status
#######################################
# shellcheck disable=SC2120
function bl64_fs_set_umask() {
  bl64_dbg_lib_show_function "$@"
  local permissions="${1:-${BL64_FS_UMASK_RW_USER}}"

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
#   command exit status
#######################################
function bl64_fs_set_ephemeral() {
  bl64_dbg_lib_show_function "$@"
  local temporal="${1:-${BL64_VAR_DEFAULT}}"
  local cache="${2:-${BL64_VAR_DEFAULT}}"
  local mode="${3:-${BL64_VAR_DEFAULT}}"
  local user="${4:-${BL64_VAR_DEFAULT}}"
  local group="${5:-${BL64_VAR_DEFAULT}}"

  if [[ "$temporal" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_create_dir "$mode" "$user" "$group" "$temporal" &&
      BL64_FS_PATH_TEMPORAL="$temporal" ||
      return $?
  fi

  if [[ "$cache" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_create_dir "$mode" "$user" "$group" "$cache" &&
      BL64_FS_PATH_CACHE="$cache" ||
      return $?
  fi

  return 0
}
