#######################################
# BashLib64 / Manage OS identity and access service
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
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
#   BL64_IAM_ERROR_MISSING_PARAMETER
#   native user add command error status
#######################################
function bl64_iam_user_add() {
  local login="$1"

  if [[ -z "$login" ]]; then
    bl64_msg_show_error "$_BL64_IAM_TXT_MISSING_PARAMETER (login)"
    # shellcheck disable=SC2086
    return $BL64_IAM_ERROR_MISSING_PARAMETER
  fi

  bl64_check_command "$BL64_OS_CMD_USERADD" || return $BL64_IAM_ERROR_MISSING_USER_ADD

  "$BL64_OS_CMD_USERADD" "$login"
}
