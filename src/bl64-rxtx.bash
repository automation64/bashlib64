#######################################
# BashLib64 / Transfer and Receive data over the network
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.10.0
#######################################

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
# Warning: bootstrap function: use pure bash, no return, no exit
function bl64_rxtx_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_ALP}-* | ${BL64_OS_MCOS}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  *) bl64_msg_show_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
# Warning: bootstrap function: use pure bash, no return, no exit
function bl64_rxtx_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-11.* | ${BL64_OS_FD}-*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent --no-progress-meter'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_DEB}-9.* | ${BL64_OS_DEB}-10.*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='-O'
    BL64_RXTX_SET_WGET_SECURE=' '
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent --no-progress-meter'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  *) bl64_msg_show_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
# Warning: bootstrap function: use pure bash, no return, no exit
function bl64_rxtx_set_alias() {
  bl64_dbg_lib_show_function
  BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
  BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
}

#######################################
# Pull data from web server
#
# * If the destination is already present no update is done unless $3=$BL64_LIB_VAR_ON
#
# Arguments:
#   $1: Source URL
#   $2: Full path to the destination file
#   $3: replace existing content Values: $BL64_LIB_VAR_ON | $BL64_LIB_VAR_OFF (default)
#   $4: permissions. Regular chown format accepted. Default: umask defined
# Outputs:
#   STDOUT: None unless BL64_DBG_TARGET_LIB_CMD
#   STDERR: command error
# Returns:
#   BL64_LIB_ERROR_APP_MISSING
#   command error status
#######################################
function bl64_rxtx_web_get_file() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local replace="${3:-${BL64_LIB_VAR_OFF}}"
  local mode="${4:-${BL64_LIB_DEFAULT}}"
  local verbose="$BL64_RXTX_SET_CURL_SILENT"
  local -i status=0

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' || return $?

  [[ "$replace" == "$BL64_LIB_VAR_OFF" && -e "$destination" ]] && return 0
  _bl64_rxtx_backup "$destination" >/dev/null || return $?

  if [[ -x "$BL64_RXTX_CMD_CURL" ]]; then
    bl64_dbg_lib_command_enabled && verbose="$BL64_RXTX_SET_CURL_VERBOSE"
    $BL64_RXTX_ALIAS_CURL $verbose \
      $BL64_RXTX_SET_CURL_REDIRECT \
      $BL64_RXTX_SET_CURL_OUTPUT "$destination" \
      "$source"
    status=$?
  elif [[ -x "$BL64_RXTX_CMD_WGET" ]]; then
    bl64_dbg_lib_command_enabled && verbose="$BL64_RXTX_SET_WGET_VERBOSE"
    $BL64_RXTX_ALIAS_WGET $verbose \
      $BL64_RXTX_SET_WGET_OUTPUT "$destination" \
      "$source"
    status=$?
  else
    # shellcheck disable=SC2086
    bl64_msg_show_error "$_BL64_RXTX_TXT_MISSING_COMMAND (wget or curl)" &&
      return $BL64_LIB_ERROR_APP_MISSING
  fi

  # Determine if mode needs to be set
  if [[ "$status" == '0' && "$mode" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_fs_chmod "$mode" "$destination"
    status=$?
  fi

  _bl64_rxtx_restore "$destination" "$status" >/dev/null || return $?

  return $status
}

#######################################
# Pull directory contents from git repo
#
# * Content of source path is downloaded into destination (source_path/* --> destionation/). Source path itself is not created
# * If the destination is already present no update is done unless $3=$BL64_LIB_VAR_ON
# * If asked to replace destination, temporary backup is done in case git fails by moving the destination to a temp name
# * Warning: git repo info is removed after pull (.git)
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: source path. Format: relative to the repo URL. Use '.' to download the full repo
#   $3: destination path. Format: full path
#   $3: branch name. Default: main
#   $5: replace existing content. Values: $BL64_LIB_VAR_ON | $BL64_LIB_VAR_OFF (default)
# Outputs:
#   STDOUT: command stdout
#   STDERR: command error
# Returns:
#   BL64_LIB_ERROR_TASK_TEMP
#   command error status
#######################################
function bl64_rxtx_git_get_dir() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local replace="${4:-${BL64_LIB_VAR_OFF}}"
  local branch="${5:-main}"
  local -i status=0

  # shellcheck disable=SC2086
  bl64_check_parameter 'source_url' &&
    bl64_check_parameter 'source_path' &&
    bl64_check_parameter 'destination' &&
    bl64_check_path_relative "$source_path" ||
    return $?

  # Check if destination is already present
  if [[ "$replace" == "$BL64_LIB_VAR_OFF" && -e "$destination" ]]; then
    bl64_msg_show_warning "$_BL64_RXTX_TXT_EXISTING_DESTINATION"
    # shellcheck disable=SC2086
    return $BL64_LIB_VAR_OK
  else
    # Asked to replace, backup first
    _bl64_rxtx_backup "$destination" >/dev/null || return $?
  fi

  # Detect what type of path is requested
  if [[ "$source_path" == '.' || "$source_path" == './' ]]; then
    _bl64_rxtx_git_get_dir_root "$source_url" "$destination" "$branch"
  else
    _bl64_rxtx_git_get_dir_sub "$source_url" "$source_path" "$destination" "$branch"
  fi
  status=$?

  # Remove GIT repo metadata
  if [[ -d "${destination}/.git" ]]; then
    bl64_dbg_lib_show_info 'remove git metadata'
    # shellcheck disable=SC2164
    cd "$destination"
    bl64_fs_rm_full '.git' >/dev/null
  fi

  # Check if restore is needed
  _bl64_rxtx_restore "$destination" "$status" >/dev/null || return $?
  return $status
}

function _bl64_rxtx_git_get_dir_root() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local destination="${2}"
  local branch="${3:-main}"
  local -i status=0
  local repo=''
  local git_name=''
  local transition=''

  repo="$($BL64_OS_ALIAS_MKTEMP_DIR)"
  # shellcheck disable=SC2086
  bl64_check_directory "$repo" "$_BL64_RXTX_TXT_CREATION_PROBLEM" || return $BL64_LIB_ERROR_TASK_TEMP

  git_name="$(bl64_fmt_basename "$source_url")"
  git_name="${git_name/.git/}"
  transition="${repo}/${git_name}"
  bl64_dbg_lib_show_vars 'git_name' 'transition'

  # Clone the repo
  bl64_vcs_git_clone "$source_url" "$repo" "$branch" &&
    # Promote to destination
    [[ -d "$transition" ]] &&
    bl64_dbg_lib_show_info 'promote to destination' &&
    bl64_fs_mv "$transition" "$destination"
  status=$?

  [[ -d "$repo" ]] && bl64_fs_rm_full "$repo" >/dev/null
  return $status
}

function _bl64_rxtx_git_get_dir_sub() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local branch="${4:-main}"
  local -i status=0
  local repo=''
  local target=''
  local source=''
  local transition=''

  repo="$($BL64_OS_ALIAS_MKTEMP_DIR)"
  # shellcheck disable=SC2086
  bl64_check_directory "$repo" "$_BL64_RXTX_TXT_CREATION_PROBLEM" || return $BL64_LIB_ERROR_TASK_TEMP

  # Use transition path to get to the final target path
  source="${repo}/${source_path}"
  target="$(bl64_fmt_basename "$destination")"
  transition="${repo}/transition/${target}"
  bl64_dbg_lib_show_vars 'source' 'target' 'transition'

  bl64_vcs_git_sparse "$source_url" "$repo" "$branch" "$source_path" &&
    [[ -d "$source" ]] &&
    bl64_fs_mkdir_full "${repo}/transition" &&
    bl64_fs_mv "$source" "$transition" >/dev/null &&
    bl64_fs_mv "${transition}" "$destination" >/dev/null
  status=$?

  [[ -d "$repo" ]] && bl64_fs_rm_full "$repo" >/dev/null
  return $status
}

function _bl64_rxtx_backup() {
  bl64_dbg_lib_show_function "$@"
  local destination="$1"
  local backup="${destination}${_BL64_RXTX_BACKUP_POSTFIX}"
  local -i status=0

  if [[ -e "$destination" ]]; then
    bl64_fs_mv "$destination" "$backup"
    status=$?
  fi

  ((status != 0)) && status=$BL64_LIB_ERROR_TASK_BACKUP
  # shellcheck disable=SC2086
  return $status
}

function _bl64_rxtx_restore() {
  bl64_dbg_lib_show_function "$@"
  local destination="$1"
  local result="$2"
  local backup="${destination}${_BL64_RXTX_BACKUP_POSTFIX}"
  local -i status=0

  # Check if restore is needed based on the operation result
  if [[ "$result" == "$BL64_LIB_VAR_OK" ]]; then
    # Operation was ok, backup no longer needed
    [[ -e "$backup" ]] && bl64_fs_rm_full "$backup"
    # shellcheck disable=SC2086
    return $BL64_LIB_VAR_OK
  fi

  # Remove invalid content
  [[ -e "$destination" ]] && bl64_fs_rm_full "$destination"

  # Restore content from backup
  bl64_fs_mv "$backup" "$destination"
  status=$?

  ((status != 0)) && status=$BL64_LIB_ERROR_TASK_RESTORE
  # shellcheck disable=SC2086
  return $status
}
