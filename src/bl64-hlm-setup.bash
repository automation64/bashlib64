#######################################
# BashLib64 / Module / Setup / Interact with HLM
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_hlm_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local helm_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_hlm_set_command "$helm_bin" &&
    _bl64_hlm_set_options &&
    _bl64_hlm_set_runtime &&
    BL64_HLM_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'hlm'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_hlm_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_HLM_CMD_HELM="$(bl64_bsh_command_import 'helm' '/opt/helm/bin' "$@")"
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_hlm_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  BL64_HLM_SET_DEBUG='--debug' &&
    BL64_HLM_SET_OUTPUT_TABLE='--output table' &&
    BL64_HLM_SET_OUTPUT_JSON='--output json' &&
    BL64_HLM_SET_OUTPUT_YAML='--output yaml'
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_hlm_set_runtime() {
  bl64_dbg_lib_show_function

  bl64_hlm_set_timeout '5m0s'
}

#######################################
# Update runtime variables: timeout
#
# Arguments:
#   $1: timeout value. Format: same as helm --timeout parameter
# Outputs:
#   STDOUT: None
#   STDERR: Validation
# Returns:
#   0: set ok
#   >0: set error
#######################################
function bl64_hlm_set_timeout() {
  bl64_dbg_lib_show_function "$@"
  local timeout="$1"

  bl64_check_parameter 'timeout' || return $?

  BL64_HLM_RUN_TIMEOUT="$timeout"
}
