#######################################
# BashLib64 / Module / Setup / Manipulate text files content
#
# Version: 1.3.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_txt_setup() {
  bl64_dbg_lib_show_function

  bl64_txt_set_command &&
    BL64_TXT_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function bl64_txt_set_command() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/bin/grep'
    BL64_TXT_CMD_SED='/bin/sed'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/bin/grep'
    BL64_TXT_CMD_SED='/bin/sed'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_BASE64='/bin/base64'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_GAWK="$BL64_LIB_INCOMPATIBLE"
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_ENVSUBST='/opt/homebrew/bin/envsubst'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}
