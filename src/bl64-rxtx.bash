#######################################
# BashLib64 / Transfer and Receive data over the network
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.2.0
#######################################

function _bl64_rxtx_backup() {

  local destination="$1"
  local backup="${destination}${_BL64_RXTX_BACKUP_POSTFIX}"
  local status=0

  if [[ -e "$destination" ]]; then
    bl64_os_mv "$destination" "$backup"
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
    [[ -e "$backup" ]] && bl64_os_rm_full "$backup"
    # shellcheck disable=SC2086
    return $BL64_LIB_VAR_OK
  fi

  # Remove invalid content
  [[ -e "$destination" ]] && bl64_os_rm_full "$destination"

  # Restore content from backup
  bl64_os_mv "$backup" "$destination"
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
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_ALP}-*)
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
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_ALP}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL --no-progress-meter  --config /dev/null"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET --no-config"
    ;;
  ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL --config /dev/null"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET --no-config"
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
#   STDOUT: None unless BL64_LIB_DEBUG_CMD is enabled
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
    [[ "$BL64_LIB_DEBUG" == "$BL64_LIB_DEBUG_CMD" ]] && verbose='--verbose'
    $BL64_RXTX_ALIAS_CURL $verbose \
      --output "$destination" \
      "$source"
    status=$?
  elif [[ -x "$BL64_RXTX_CMD_WGET" ]]; then
    [[ "$BL64_LIB_DEBUG" == "$BL64_LIB_DEBUG_CMD" ]] && verbose='--verbose'
    $BL64_RXTX_ALIAS_WGET $verbose \
      --no-directories \
      --output-document "$destination" \
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
# Pull directory structure from git repo
#
# * If the destination is already present no update is done unless $3=$BL64_LIB_VAR_ON
# * Warning: git repo info is removed after pull (.git)
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: source path. Format: relative to the repo URL
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
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local replace="${4:-$BL64_LIB_VAR_OFF}"
  local branch="${5:-main}"
  local repo=''
  local target=''
  local source=''
  local status=0

  # shellcheck disable=SC2086
  bl64_check_parameter 'source_url' 'git repository' &&
    bl64_check_parameter 'source_path' 'source path' &&
    bl64_check_parameter 'destination' 'target destination' ||
    return $BL64_RXTX_ERROR_MISSING_PARAMETER

  # shellcheck disable=SC2086
  [[ "$replace" == "$BL64_LIB_VAR_OFF" && -e "$destination" ]] && return $BL64_LIB_VAR_OK
  _bl64_rxtx_backup "$destination" >/dev/null || return $?

  repo="$($BL64_OS_ALIAS_MKTEMP_DIR)"
  # shellcheck disable=SC2086
  bl64_check_directory "$repo" 'unable to create temporary git repo' || return $BL64_RXTX_ERROR_TEMPORARY_REPO

  # Use transition path to get to the final target path
  source="${repo}/${source_path}"
  target="$(bl64_fmt_basename "$destination")"
  transition="${repo}/transition/${target}"

  bl64_vcs_git_sparse "$source_url" "$repo" "$branch" "$source_path" &&
    [[ -d "$source" ]] &&
    bl64_os_mkdir_full "${repo}/transition" &&
    bl64_os_mv "$source" "$transition" >/dev/null &&
    bl64_os_mv "${transition}" "$destination" >/dev/null
  status=$?

  _bl64_rxtx_restore "$destination" "$status" >/dev/null || return $?
  [[ -d "$repo" ]] && bl64_os_rm_full "$repo" >/dev/null

  return $status
}
