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
  local kubectl_bin="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$kubectl_bin" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_check_directory "$kubectl_bin" ||
      return $?
  fi

  bl64_k8s_set_command "$kubectl_bin" &&
    bl64_check_command "$BL64_K8S_CMD_KUBECTL" &&
    bl64_k8s_set_version &&
    bl64_k8s_set_options &&
    bl64_k8s_set_kubectl_output &&
    BL64_K8S_MODULE="$BL64_VAR_ON"

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
  local kubectl_bin="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$kubectl_bin" == "$BL64_VAR_DEFAULT" ]]; then
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
    [[ ! -x "${kubectl_bin}/kubectl" ]] && kubectl_bin="$BL64_VAR_DEFAULT"
  fi

  if [[ "$kubectl_bin" != "$BL64_VAR_DEFAULT" ]]; then
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

  case "$BL64_K8S_VERSION_KUBECTL" in
  1.22 | 1.23 | 1.24 | 1.25 )
    BL64_K8S_SET_VERBOSE_NONE='--v=0'
    BL64_K8S_SET_VERBOSE_NORMAL='--v=2'
    BL64_K8S_SET_VERBOSE_DEBUG='--v=4'
    BL64_K8S_SET_VERBOSE_TRACE='--v=6'

    BL64_K8S_SET_OUTPUT_JSON='--output=json'
    BL64_K8S_SET_OUTPUT_YAML='--output=yaml'
    BL64_K8S_SET_OUTPUT_TXT='--output=wide'
    BL64_K8S_SET_OUTPUT_NAME='--output=name'

    BL64_K8S_SET_DRY_RUN_SERVER='--dry-run=server'
    BL64_K8S_SET_DRY_RUN_CLIENT='--dry-run=client'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Identify and set module components versions
#
# * Version information is stored in module global variables
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: command errors
# Returns:
#   0: version set ok
#   >0: command error
#######################################
function bl64_k8s_set_version() {
  bl64_dbg_lib_show_function
  local version=''

  bl64_dbg_lib_show_info "run kubectl to obtain client version"
  version="$(
    "$BL64_K8S_CMD_KUBECTL" version --client --output=json | bl64_txt_run_awk $BL64_TXT_SET_AWS_FS ':' '
      $1 ~ /^ +"major"$/ { gsub( /[" ,]/, "", $2 ); Major = $2 }
      $1 ~ /^ +"minor"$/ { gsub( /[" ,]/, "", $2 ); Minor = $2 }
      END { print Major "." Minor }
    '
  )"

  if [[ -n "$version" ]]; then
    BL64_K8S_VERSION_KUBECTL="$version"
  else
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  bl64_dbg_lib_show_vars 'BL64_K8S_VERSION_KUBECTL'
  return 0
}

#######################################
# Set default output type for kubectl
#
# * Not global, the function that needs to use the default must read the variable BL64_K8S_CFG_KUBECTL_OUTPUT
# * Not all types are supported. The calling function is reponsible for checking compatibility
#
# Arguments:
#   $1: output type. Default: json. One of BL64_K8S_CFG_KUBECTL_OUTPUT_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
# shellcheck disable=SC2120
function bl64_k8s_set_kubectl_output() {
  bl64_dbg_lib_show_function "$@"
  local output="${1:-${BL64_K8S_CFG_KUBECTL_OUTPUT_JSON}}"

  case "$output" in
  "$BL64_K8S_CFG_KUBECTL_OUTPUT_JSON") BL64_K8S_CFG_KUBECTL_OUTPUT="$BL64_K8S_SET_OUTPUT_JSON" ;;
  "$BL64_K8S_CFG_KUBECTL_OUTPUT_YAML") BL64_K8S_CFG_KUBECTL_OUTPUT="$BL64_K8S_SET_OUTPUT_YAML" ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}
