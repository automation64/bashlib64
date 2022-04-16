#######################################
# BashLib64 / Manage role based access service
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.5.0
#######################################

#######################################
# Add password-less root privilege
#
# Arguments:
#   $1: user name. User must already be present.
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: rule added
#   >0: failed command exit status
#   BL64_RBAC_ERROR_MISSING_PARAMETER
#   BL64_RBAC_ERROR_MISSING_SUDOERS
#   BL64_RBAC_ERROR_MISSING_AWK
#   BL64_RBAC_ERROR_UPDATE_FAILED
#   BL64_RBAC_ERROR_INVALID_SUDOERS
#######################################
function bl64_rbac_add_root() {
  local user="$1"
  local status=$BL64_RBAC_ERROR_UPDATE_FAILED
  local new_sudoers="${BL64_RBAC_FILE_SUDOERS}.bl64_new"
  local old_sudoers="${BL64_RBAC_FILE_SUDOERS}.bl64_old"

  if [[ -z "$user" ]]; then
    bl64_msg_show_error "$_BL64_RBAC_TXT_MISSING_PARAMETER (user)"
    # shellcheck disable=SC2086
    return $BL64_RBAC_ERROR_MISSING_PARAMETER
  fi

  # shellcheck disable=SC2086
  bl64_check_command "$BL64_OS_CMD_AWK" || return $BL64_RBAC_ERROR_MISSING_AWK
  # shellcheck disable=SC2086
  bl64_check_file "$BL64_RBAC_FILE_SUDOERS" || return $BL64_RBAC_ERROR_MISSING_SUDOERS
  # shellcheck disable=SC2086
  bl64_rbac_check_sudoers "$BL64_RBAC_FILE_SUDOERS" || return $BL64_RBAC_ERROR_INVALID_SUDOERS

  umask 0266
  # shellcheck disable=SC2016
  $BL64_OS_ALIAS_AWK \
    -v ControlUsr="$user" \
    '
      BEGIN { Found = 0 }
      ControlUsr " ALL=(ALL) NOPASSWD: ALL" == $0 { Found = 1 }
      { print $0 }
      END {
        if( Found == 0) {
          print( ControlUsr " ALL=(ALL) NOPASSWD: ALL" )
        }
      }
    ' \
    "$BL64_RBAC_FILE_SUDOERS" >"$new_sudoers"

  if [[ -s "$new_sudoers" ]]; then
    bl64_fs_cp_file "${BL64_RBAC_FILE_SUDOERS}" "$old_sudoers"
  fi
  if [[ -s "$new_sudoers" && -s "$old_sudoers" ]]; then
    "$BL64_OS_CMD_CAT" "${BL64_RBAC_FILE_SUDOERS}.bl64_new" >"${BL64_RBAC_FILE_SUDOERS}" &&
      bl64_rbac_check_sudoers "$BL64_RBAC_FILE_SUDOERS"
    status=$?
  fi

  return $status
}

#######################################
# Use visudo --check to validate sudoers file
#
# Arguments:
#   $1: full path to the sudoers file
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: sudoers sintax ok
#   BL64_RBAC_ERROR_MISSING_VISUDO
#   visudo exit status
#######################################
function bl64_rbac_check_sudoers() {
  local sudoers="$1"
  local status=0

  # shellcheck disable=SC2086
  bl64_check_command "$BL64_RBAC_CMD_VISUDO" || return $BL64_RBAC_ERROR_MISSING_VISUDO

  "$BL64_RBAC_CMD_VISUDO" \
    --check \
    --file "$sudoers"
  status=$?

  if ((status != 0)); then
    bl64_msg_show_error "$_BL64_RBAC_TXT_INVALID_SUDOERS ($sudoers)"
  fi

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
function bl64_rbac_set_command() {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_ALP}-* | ${BL64_OS_MCOS}-*)
    BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
    BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
    BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
    ;;
  esac
  # Do not use return as this function gets sourced
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
function bl64_rbac_set_alias() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_ALP}-* | ${BL64_OS_MCOS}-*)
    BL64_RBAC_ALIAS_SUDO_ENV="$BL64_RBAC_CMD_SUDO --preserve-env --set-home"
    ;;
  esac
}

#######################################
# Run privileged OS command using Sudo if needed
#
# Arguments:
#   $@: command and arguments to run
# Outputs:
#   STDOUT: command or sudo output
#   STDERR: command or sudo error
# Returns:
#   command or sudo exit status
#######################################
function bl64_rbac_run_command() {
  local -i status=0

  # shellcheck disable=SC2086
  (($# == 0)) && return $BL64_RBAC_ERROR_MISSING_PARAMETER
  # shellcheck disable=SC2086
  bl64_check_command "$BL64_RBAC_CMD_SUDO" || return $BL64_RBAC_ERROR_MISSING_SUDO
  bl64_dbg_lib_trace_start

  # Check the effective user id
  if [[ "$EUID" == '0' ]]; then
    # Already root, execute command directly
    "$@"
  else
    # Current user is regular, use SUDO
    $BL64_RBAC_ALIAS_SUDO_ENV "$@"
  fi
  status=$?

  bl64_dbg_lib_trace_stop
  return $status
}
