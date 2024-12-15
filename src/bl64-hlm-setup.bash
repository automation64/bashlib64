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
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last sourced module' &&
    return 21
  bl64_dbg_lib_show_function "$@"
  local helm_bin="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$helm_bin" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_check_directory "$helm_bin" ||
      return $?
  fi

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_hlm_set_command "$helm_bin" &&
    bl64_check_command "$BL64_HLM_CMD_HELM" &&
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
  local helm_bin="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$helm_bin" == "$BL64_VAR_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/helm' ]]; then
      helm_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/helm' ]]; then
      helm_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/helm' ]]; then
      helm_bin='/usr/local/bin'
    elif [[ -x '/opt/helm/bin/helm' ]]; then
      helm_bin='/opt/helm/bin'
    elif [[ -x '/usr/bin/helm' ]]; then
      helm_bin='/usr/bin'
    else
      bl64_check_alert_resource_not_found 'helm'
      return $?
    fi
  fi

  bl64_check_directory "$helm_bin" || return $?
  [[ -x "${helm_bin}/helm" ]] && BL64_HLM_CMD_HELM="${helm_bin}/helm"

  bl64_dbg_lib_show_vars 'BL64_HLM_CMD_HELM'
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
