#######################################
# BashLib64 / Module / Setup / Interact with Bash shell
#
# Version: 1.1.1
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
function bl64_bsh_setup() {
  bl64_dbg_lib_show_function

  _bl64_bsh_set_version &&
    BL64_BSH_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'bsh'
}

#######################################
# Identify and set module components versions
#
# * Version information is stored in module global variables
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: command errors
# Returns:
#   0: version set ok
#   >0: command error
#######################################
function _bl64_bsh_set_version() {
  bl64_dbg_lib_show_function

  case "${BASH_VERSINFO[0]}" in
  4*) BL64_BSH_VERSION='4.0' ;;
  5*) BL64_BSH_VERSION='5.0' ;;
  *)
    bl64_msg_show_error "${_BL64_BSH_TXT_UNSUPPORTED} (${BASH_VERSINFO[0]})" &&
      return $BL64_LIB_ERROR_OS_BASH_VERSION
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_BSH_VERSION'

  return 0
}
