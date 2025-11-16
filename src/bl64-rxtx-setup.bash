#######################################
# BashLib64 / Module / Setup / Transfer and Receive data over the network
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
function bl64_rxtx_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_VCS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_rxtx_set_command &&
    _bl64_rxtx_set_options &&
    _bl64_rxtx_set_alias &&
    BL64_RXTX_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'rxtx'
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_rxtx_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET="$BL64_VAR_INCOMPATIBLE"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_rxtx_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-18.* | ${BL64_OS_DEB}-9.* | ${BL64_OS_DEB}-10.*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS='--no-progress-meter'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS='--no-progress-meter'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='-O'
    BL64_RXTX_SET_WGET_SECURE=' '
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS='--no-progress-meter'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT=' '
    BL64_RXTX_SET_WGET_SECURE=' '
    BL64_RXTX_SET_WGET_VERBOSE=' '
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_rxtx_set_alias() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET=''
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}
