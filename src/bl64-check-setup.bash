#######################################
# BashLib64 / Module / Setup / Check for conditions and report status
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
function bl64_check_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: BashLib64 core module not loaded (bashlib64-module-core.bash). Ensure it is sourced before any other one.' &&
    return 21
  bl64_dbg_lib_show_function

  BL64_CHECK_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'check'
}
