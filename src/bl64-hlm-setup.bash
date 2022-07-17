#######################################
# BashLib64 / Module / Setup / Interact with HLM
#
# Version: 1.0.0
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
  bl64_dbg_lib_show_function "$@"
  local helm_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$helm_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$helm_bin" ||
      return $?
  fi

  bl64_hlm_set_command "$helm_bin" &&
    bl64_hlm_set_options &&
    bl64_check_command "$BL64_HLM_CMD_HELM" &&
    bl64_hlm_set_defaults &&
    BL64_HLM_MODULE="$BL64_LIB_VAR_ON"

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
function bl64_hlm_set_command() {
  bl64_dbg_lib_show_function "$@"
  local helm_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$helm_bin" == "$BL64_LIB_DEFAULT" ]]; then
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
    fi
  else
    [[ ! -x "${helm_bin}/helm" ]] && helm_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$helm_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${helm_bin}/helm" ]] && BL64_HLM_CMD_HELM="${helm_bin}/helm"
  fi

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
function bl64_hlm_set_options() {
  bl64_dbg_lib_show_function

  BL64_HLM_SET_DEBUG='--debug'
  BL64_HLM_SET_OUTPUT_TABLE='--output table'
  BL64_HLM_SET_OUTPUT_JSON='--output json'
  BL64_HLM_SET_OUTPUT_YAML='--output yaml'
}

function bl64_hlm_set_defaults() {
  bl64_dbg_lib_show_function

  BL64_HLM_K8S_TIMEOUT='5m0s'
}
