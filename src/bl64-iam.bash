#######################################
# BashLib64 / Module / Functions / Manage OS identity and access service
#
# Version: 1.6.0
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

  bl64_msg_show_lib_task "$_BL64_IAM_TXT_ADD_USER ($login)"
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*) $BL64_IAM_ALIAS_USERADD "$login" ;;
  ${BL64_OS_ALP}-*) $BL64_IAM_ALIAS_USERADD -D "$login" ;;
  ${BL64_OS_MCOS}-*) $BL64_IAM_ALIAS_USERADD "/Users/${login}" ;;
  *) bl64_check_show_unsupported ;;
  esac
}
