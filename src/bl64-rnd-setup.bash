#######################################
# BashLib64 / Module / Setup / Generate random data
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Channels:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_rnd_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MOD_SETUP' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MOD_SETUP' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MOD_SETUP' &&
    BL64_RND_MOD_SETUP="$BL64_VAR_ON"
  bl64_check_rise_module_setup 'rnd'
}
