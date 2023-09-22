#######################################
# BashLib64 / Module / Setup / Interact with Bash shell
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
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
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
  4*) BL64_BSH_VERSION_BASH='4.0' ;;
  5*) BL64_BSH_VERSION_BASH='5.0' ;;
  *)
    bl64_msg_show_error "${_BL64_BSH_TXT_UNSUPPORTED} (${BASH_VERSINFO[0]})" &&
      return $BL64_LIB_ERROR_OS_BASH_VERSION
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_BSH_VERSION_BASH'

  return 0
}
