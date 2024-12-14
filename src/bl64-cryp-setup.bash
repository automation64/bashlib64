#######################################
# BashLib64 / Module / Setup / Cryptography tools
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
function bl64_cryp_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last sourced module' &&
    return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_RXTX_MODULE' &&
    _bl64_cryp_set_command &&
    BL64_CRYP_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'cryp'
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
function _bl64_cryp_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_CRYP_CMD_GPG='/usr/bin/gpg'
    BL64_CRYP_CMD_OPENSSL='/usr/bin/openssl'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_CRYP_CMD_GPG='/usr/bin/gpg'
    BL64_CRYP_CMD_OPENSSL='/usr/bin/openssl'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_CRYP_CMD_GPG='/usr/bin/gpg'
    BL64_CRYP_CMD_OPENSSL='/usr/bin/openssl'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_CRYP_CMD_GPG='/usr/bin/gpg'
    BL64_CRYP_CMD_OPENSSL='/usr/bin/openssl'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_CRYP_CMD_GPG='/usr/bin/gpg'
    BL64_CRYP_CMD_OPENSSL='/usr/bin/openssl'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}
