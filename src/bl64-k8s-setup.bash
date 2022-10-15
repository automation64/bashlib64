#######################################
# BashLib64 / Module / Setup / Interact with Kubernetes
#
# Version: 1.2.0
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
function bl64_k8s_setup() {
  bl64_dbg_lib_show_function "$@"
  local kubectl_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$kubectl_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$kubectl_bin" ||
      return $?
  fi

  bl64_k8s_set_command "$kubectl_bin" &&
    bl64_k8s_set_options &&
    bl64_check_command "$BL64_K8S_CMD_KUBECTL" &&
    BL64_K8S_MODULE="$BL64_LIB_VAR_ON"

  bl64_check_alert_module_setup 'k8s'
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
function bl64_k8s_set_command() {
  bl64_dbg_lib_show_function "$@"
  local kubectl_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$kubectl_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/kubectl' ]]; then
      kubectl_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/kubectl' ]]; then
      kubectl_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/kubectl' ]]; then
      kubectl_bin='/usr/local/bin'
    elif [[ -x '/usr/bin/kubectl' ]]; then
      kubectl_bin='/usr/bin'
    fi
  else
    [[ ! -x "${kubectl_bin}/kubectl" ]] && kubectl_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$kubectl_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${kubectl_bin}/kubectl" ]] && BL64_K8S_CMD_KUBECTL="${kubectl_bin}/kubectl"
  fi

  bl64_dbg_lib_show_vars 'BL64_K8S_CMD_KUBECTL'
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
function bl64_k8s_set_options() {
  bl64_dbg_lib_show_function

  BL64_K8S_SET_VERBOSE_NONE='--v=0'
  BL64_K8S_SET_VERBOSE_NORMAL='--v=2'
  BL64_K8S_SET_VERBOSE_DEBUG='--v=4'
  BL64_K8S_SET_VERBOSE_TRACE='--v=6'

  BL64_K8S_SET_OUTPUT_JSON='--output=json'
  BL64_K8S_SET_OUTPUT_YAML='--output=yaml'
  BL64_K8S_SET_OUTPUT_TXT='--output=wide'
  BL64_K8S_SET_OUTPUT_NAME='--output=name'
}
