#######################################
# BashLib64 / Transfer and Receive data over the network
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.7.0
#######################################

function _bl64_rxtx_backup() {

  local destination="$1"
  local backup="${destination}${_BL64_RXTX_BACKUP_POSTFIX}"
  local status=0

  if [[ -e "$destination" ]]; then
    bl64_fs_mv "$destination" "$backup"
    status=$?
  fi

  ((status != 0)) && status=$BL64_RXTX_ERROR_BACKUP
  # shellcheck disable=SC2086
  return $status
}

function _bl64_rxtx_restore() {
  local destination="$1"
  local result="$2"
  local backup="${destination}${_BL64_RXTX_BACKUP_POSTFIX}"
  local status=0

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

  ((status != 0)) && status=$BL64_RXTX_ERROR_RESTORE
  # shellcheck disable=SC2086
  return $status
}

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
function bl64_rxtx_set_command() {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_ALP}-* | ${BL64_OS_MCOS}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
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
function bl64_rxtx_set_alias() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-11.* | ${BL64_OS_FD}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL --no-progress-meter  --config /dev/null"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET --no-config"
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    ;;
  ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_DEB}-9.* | ${BL64_OS_DEB}-10.*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL --config /dev/null"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET --no-config"
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET"
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_WGET_OUTPUT='-O'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL --no-progress-meter  --config /dev/null"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET --no-config"
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    ;;
  esac
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
# Outputs:
#   STDOUT: None unless BL64_DBG_TARGET_CMD
#   STDERR: command error
# Returns:
#   BL64_RXTX_ERROR_MISSING_PARAMETER
#   BL64_RXTX_ERROR_MISSING_COMMAND
#   command error status
#######################################
function bl64_rxtx_web_get_file() {
  local source="$1"
  local destination="$2"
  local replace="${3:-$BL64_LIB_VAR_OFF}"
  local verbose=''
  local status=0

  if [[ -z "$source" ]]; then
    bl64_msg_show_error "$_BL64_RXTX_TXT_MISSING_PARAMETER (source url)"
    # shellcheck disable=SC2086
    return $BL64_RXTX_ERROR_MISSING_PARAMETER
  fi

  if [[ -z "$destination" ]]; then
    bl64_msg_show_error "$_BL64_RXTX_TXT_MISSING_PARAMETER (source url)"
    # shellcheck disable=SC2086
    return $BL64_RXTX_ERROR_MISSING_PARAMETER
  fi

  [[ "$replace" == "$BL64_LIB_VAR_OFF" && -e "$destination" ]] && return 0
  _bl64_rxtx_backup "$destination" >/dev/null || return $?

  if [[ -x "$BL64_RXTX_CMD_CURL" ]]; then
    [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_CMD" ]] && verbose="$BL64_RXTX_SET_CURL_VERBOSE"
    $BL64_RXTX_ALIAS_CURL $verbose \
      $BL64_RXTX_SET_CURL_OUTPUT "$destination" \
      "$source"
    status=$?
  elif [[ -x "$BL64_RXTX_CMD_WGET" ]]; then
    [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_CMD" ]] && verbose="$BL64_RXTX_SET_WGET_VERBOSE"
    $BL64_RXTX_ALIAS_WGET $verbose \
      $BL64_RXTX_SET_WGET_OUTPUT "$destination" \
      "$source"
    status=$?
  else
    # shellcheck disable=SC2086
    bl64_msg_show_error "$_BL64_RXTX_TXT_MISSING_COMMAND (wget or curl)" &&
      return $BL64_RXTX_ERROR_MISSING_COMMAND
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
#   BL64_RXTX_ERROR_MISSING_PARAMETER
#   BL64_RXTX_ERROR_TEMPORARY_REPO
#   command error status
#######################################
function bl64_rxtx_git_get_dir() {
  bl64_dbg_lib_trace_start
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local replace="${4:-$BL64_LIB_VAR_OFF}"
  local branch="${5:-main}"
  local status=0
  bl64_dbg_lib_trace_stop

  # shellcheck disable=SC2086
  bl64_check_parameter 'source_url' 'git repository' &&
    bl64_check_parameter 'source_path' 'source path' &&
    bl64_check_parameter 'destination' 'target destination' &&
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
    bl64_dbg_lib_show_info 'process full repo'
    _bl64_rxtx_git_get_dir_root "$source_url" "$destination" "$branch"
  else
    bl64_dbg_lib_show_info 'process repo subdirectory'
    _bl64_rxtx_git_get_dir_sub "$source_url" "$source_path" "$destination" "$branch"
  fi
  status=$?

  # Remove GIT repo metadata
  if [[ -d "${destination}/.git" ]]; then
    # shellcheck disable=SC2164
    cd "$destination"
    bl64_fs_rm_full '.git' >/dev/null
  fi

  # Check if restore is needed
  _bl64_rxtx_restore "$destination" "$status" >/dev/null || return $?
  return $status
}

function _bl64_rxtx_git_get_dir_root() {
  local source_url="${1}"
  local destination="${2}"
  local branch="${3:-main}"
  local status=0
  local repo=''
  local git_name=''
  local transition=''

  repo="$($BL64_OS_ALIAS_MKTEMP_DIR)"
  # shellcheck disable=SC2086
  bl64_check_directory "$repo" "$_BL64_RXTX_TXT_CREATION_PROBLEM" || return $BL64_RXTX_ERROR_TEMPORARY_REPO

  git_name="$(bl64_fmt_basename "$source_url")"
  git_name="${git_name/.git/}"
  transition="${repo}/${git_name}"
  bl64_dbg_lib_show_info "temporary local git path: transition=[$transition]"

  # Clone the repo
  bl64_vcs_git_clone "$source_url" "$repo" "$branch" && \
  [[ -d "$transition" ]] &&
  # Promote to destination
  bl64_fs_mv "$transition" "$destination"
  status=$?

  [[ -d "$repo" ]] && bl64_fs_rm_full "$repo" >/dev/null
  return $status
}

function _bl64_rxtx_git_get_dir_sub() {
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local branch="${4:-main}"
  local status=0
  local repo=''
  local target=''
  local source=''
  local transition=''

  repo="$($BL64_OS_ALIAS_MKTEMP_DIR)"
  # shellcheck disable=SC2086
  bl64_check_directory "$repo" "$_BL64_RXTX_TXT_CREATION_PROBLEM" || return $BL64_RXTX_ERROR_TEMPORARY_REPO

  # Use transition path to get to the final target path
  source="${repo}/${source_path}"
  target="$(bl64_fmt_basename "$destination")"
  transition="${repo}/transition/${target}"

  bl64_vcs_git_sparse "$source_url" "$repo" "$branch" "$source_path" &&
    [[ -d "$source" ]] &&
    bl64_fs_mkdir_full "${repo}/transition" &&
    bl64_fs_mv "$source" "$transition" >/dev/null &&
    bl64_fs_mv "${transition}" "$destination" >/dev/null
  status=$?

  [[ -d "$repo" ]] && bl64_fs_rm_full "$repo" >/dev/null
  return $status
}
