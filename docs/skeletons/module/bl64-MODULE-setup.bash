#######################################
# BashLib64 / Module / Setup / X_MODULE_DESCRIPTION_X
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
function bl64_X_MODULE_X_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MOD_SETUP' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MOD_SETUP' &&
    _bl64_lib_module_is_imported 'BL64_OS_MOD_SETUP' &&
    bl64_dbg_lib_show_function &&
    BL64_X_MODULE_CAPS_X_MODULE="$BL64_VAR_ON"
  bl64_check_rise_module_setup 'tm'
}
