#######################################
# BashLib64 / Module / Setup / Interact with Kubernetes
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
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
  bl64_dbg_lib_show_function "$@"
  local kubectl_bin="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$kubectl_bin" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_check_directory "$kubectl_bin" ||
      return $?
  fi

  bl64_lib_module_imported 'BL64_CHECK_MODULE' &&
    bl64_lib_module_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    bl64_lib_module_imported 'BL64_MSG_MODULE' &&
    bl64_lib_module_imported 'BL64_TXT_MODULE' &&
    _bl64_k8s_set_command "$kubectl_bin" &&
    bl64_check_command "$BL64_K8S_CMD_KUBECTL" &&
    _bl64_k8s_set_version &&
    _bl64_k8s_set_options &&
    _bl64_k8s_set_runtime &&
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
function _bl64_k8s_set_command() {
  bl64_dbg_lib_show_function "$@"
  local kubectl_bin="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$kubectl_bin" == "$BL64_VAR_DEFAULT" ]]; then
    bl64_dbg_lib_show_info 'no custom path provided. Using known locations to detect ansible'
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/kubectl' ]]; then
      kubectl_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/kubectl' ]]; then
      kubectl_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/kubectl' ]]; then
      kubectl_bin='/usr/local/bin'
    elif [[ -x '/usr/bin/kubectl' ]]; then
      kubectl_bin='/usr/bin'
    else
      bl64_check_alert_resource_not_found 'kubectl'
      return $?
    fi
  fi

  bl64_check_directory "$kubectl_bin" || return $?
  [[ -x "${kubectl_bin}/kubectl" ]] && BL64_K8S_CMD_KUBECTL="${kubectl_bin}/kubectl"

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
function _bl64_k8s_set_options() {
  bl64_dbg_lib_show_function

  case "$BL64_K8S_VERSION_KUBECTL" in
  1.22 | 1.23 | 1.24 | 1.25 | 1.26 | 1.27 | 1.28)
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
  *)
    bl64_check_compatibility_mode "k8s-api: ${BL64_K8S_VERSION_KUBECTL}" || return $?
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
function _bl64_k8s_set_version() {
  bl64_dbg_lib_show_function
  local cli_version=''

  bl64_dbg_lib_show_info "run kubectl to obtain client version"
  cli_version="$(_bl64_k8s_get_version_1_22)"
  bl64_dbg_lib_show_vars 'cli_version'

  if [[ -n "$cli_version" ]]; then
    BL64_K8S_VERSION_KUBECTL="$cli_version"
  else
    bl64_msg_show_error "$_BL64_K8S_TXT_ERROR_KUBECTL_VERSION"
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  bl64_dbg_lib_show_vars 'BL64_K8S_VERSION_KUBECTL'
  return 0
}

function _bl64_k8s_get_version_1_22() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info "try with kubectl v1.22 options"
  # shellcheck disable=SC2086
  "$BL64_K8S_CMD_KUBECTL" version --client --output=json |
    bl64_txt_run_awk $BL64_TXT_SET_AWS_FS ':' '
    $1 ~ /^ +"major"$/ { gsub( /[" ,]/, "", $2 ); Major = $2 }
    $1 ~ /^ +"minor"$/ { gsub( /[" ,]/, "", $2 ); Minor = $2 }
    END { print Major "." Minor }
  '
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: setting errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function _bl64_k8s_set_runtime() {
  bl64_dbg_lib_show_function

  bl64_k8s_set_kubectl_output
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
