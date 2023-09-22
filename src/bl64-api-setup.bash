#######################################
# BashLib64 / Module / Setup / Interact with RESTful APIs
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
function bl64_api_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
  bl64_dbg_lib_show_function

  BL64_API_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'api'
}
