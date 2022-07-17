#######################################
# BashLib64 / Module / Functions / Interact with Kubernetes
#
# Version: 1.0.0
#######################################

#######################################
# Set label on resource
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: resource type
#   $3: resource name
#   $4: label name
#   $5: label value
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_label_set() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_LIB_DEFAULT}}"
  local resource="${2:-${BL64_LIB_DEFAULT}}"
  local name="${3:-${BL64_LIB_DEFAULT}}"
  local key="${4:-${BL64_LIB_DEFAULT}}"
  local value="${5:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'resource' &&
    bl64_check_parameter 'name' &&
    bl64_check_parameter 'key' &&
    bl64_check_parameter 'value' ||
    return $?

  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    label \
    --overwrite \
    "$resource" \
    "$name" \
    "$key"="$value"
}

#######################################
# Create namespace
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: namespace name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_namespace_create() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_LIB_DEFAULT}}"
  local namespace="${2:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'namespace' ||
    return $?

  bl64_k8s_run_kubectl "$kubeconfig" create namespace "$namespace"
}

#######################################
# Apply updates to resources based on definition file
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: namespace where resources are
#   $3: full path to the resource definition file
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_resource_update() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_LIB_DEFAULT}}"
  local namespace="${2:-${BL64_LIB_DEFAULT}}"
  local definition="${3:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'definition' &&
    bl64_check_file "$definition" ||
    return $?

  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    --namespace "$namespace" \
    apply \
    --force='false' \
    --force-conflicts='false' \
    --grace-period='-1' \
    --overwrite='true' \
    --validate='strict' \
    --wait='true' \
    --filename="$definition"

}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_run_kubectl() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-}"
  local verbosity="$BL64_K8S_SET_VERBOSE_NONE"

  bl64_check_parameters_none "$#" &&
    bl64_check_parameter 'kubeconfig' &&
    bl64_check_file "$kubeconfig" &&
    bl64_check_module_setup "$BL64_K8S_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_SET_VERBOSE_NORMAL"
  bl64_dbg_lib_command_enabled && verbosity="$BL64_K8S_SET_VERBOSE_TRACE"

  unset POD_NAMESPACE
  unset KUBECONFIG
  shift

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_K8S_CMD_KUBECTL" \
    --kubeconfig="$kubeconfig" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}
