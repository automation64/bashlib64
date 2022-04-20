#######################################
# BashLib64 / Manage OS identity and access service
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.4.0
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
function bl64_iam_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    BL64_IAM_CMD_USERADD='/usr/sbin/useradd'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_IAM_CMD_USERADD='/usr/sbin/adduser'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_IAM_CMD_USERADD='/usr/bin/dscl'
    ;;
  *) bl64_msg_show_unsupported ;;
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
function bl64_iam_set_alias() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD -q . -create"
    ;;
  *) bl64_msg_show_unsupported ;;
  esac
}

#######################################
# Create OS user
#
# Arguments:
#   $1: login name
# Outputs:
#   STDOUT: native user add command output
#   STDERR: native user add command error messages
# Returns:
#   BL64_IAM_ERROR_MISSING_PARAMETER
#   native user add command error status
#######################################
function bl64_iam_user_add() {
  local login="$1"

  bl64_check_privilege_root || return $?
  bl64_check_parameter 'login' || return $?

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    $BL64_IAM_ALIAS_USERADD "$login"
    ;;
  ${BL64_OS_ALP}-*)
    $BL64_IAM_ALIAS_USERADD -D "$login"
    ;;
  ${BL64_OS_MCOS}-*)
    $BL64_IAM_ALIAS_USERADD "/Users/${login}"
    ;;
  esac
}