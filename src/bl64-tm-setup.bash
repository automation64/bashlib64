#######################################
# BashLib64 / Module / Setup / Manage date-time data
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
function bl64_tm_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be sourced at the end' && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    bl64_dbg_lib_show_function &&
    BL64_TM_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'tm'
}
