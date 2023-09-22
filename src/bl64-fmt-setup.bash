#######################################
# BashLib64 / Module / Setup / Format text data
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
function bl64_fmt_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
  bl64_dbg_lib_show_function

  bl64_check_module_imported 'BL64_DBG_MODULE' &&
    bl64_check_module_imported 'BL64_TXT_MODULE' &&
    BL64_FMT_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'fmt'
}
