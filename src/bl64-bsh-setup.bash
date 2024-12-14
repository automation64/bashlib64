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

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_XSV_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
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
#   $BL64_LIB_ERROR_OS_BASH_VERSION
#######################################
function _bl64_bsh_set_version() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "${BASH_VERSINFO[0]}" in
  4*) BL64_BSH_VERSION_BASH='4.0' ;;
  5*) BL64_BSH_VERSION_BASH='5.0' ;;
  *)
    bl64_check_alert_unsupported "Bash: ${BASH_VERSINFO[0]}"
    return $BL64_LIB_ERROR_OS_BASH_VERSION
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_BSH_VERSION_BASH'

  return 0
}
