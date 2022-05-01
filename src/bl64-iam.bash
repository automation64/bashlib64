#######################################
# BashLib64 / Manage OS identity and access service
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.5.0
#######################################

#######################################
# Create OS user
#
# Arguments:
#   $1: login name
# Outputs:
#   STDOUT: native user add command output
#   STDERR: native user add command error messages
# Returns:
#   native user add command error status
#######################################
function bl64_iam_user_add() {
  bl64_dbg_lib_show_function "$@"
  local login="$1"

  bl64_check_privilege_root &&
    bl64_check_parameter 'login' ||
    return $?

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
