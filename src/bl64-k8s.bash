#######################################
# BashLib64 / Module / Functions / Interact with Kubernetes
#######################################

#######################################
# Set label on resource
#
# * Overwrite existing
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
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local resource="${2:-${BL64_VAR_NULL}}"
  local name="${3:-${BL64_VAR_NULL}}"
  local key="${4:-${BL64_VAR_NULL}}"
  local value="${5:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'resource' &&
    bl64_check_parameter 'name' &&
    bl64_check_parameter 'key' &&
    bl64_check_parameter 'value' ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  bl64_msg_show_lib_task "${_BL64_K8S_TXT_SET_LABEL} (${resource}/${name}/${key})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    'label' $verbosity \
    --overwrite \
    "$resource" \
    "$name" \
    "$key"="$value"
}

#######################################
# Set annotation on resource
#
# * Overwrite existing
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: namespace. If not required assign $BL64_VAR_NONE
#   $2: resource type
#   $3: resource name
#   $@: remaining args are passed as is. Use the syntax: key=value
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_annotation_set() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NONE}}"
  local resource="${3:-${BL64_VAR_NULL}}"
  local name="${4:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'resource' &&
    bl64_check_parameter 'name' ||
    return $?

  shift
  shift
  shift
  shift

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"
  [[ "$namespace" == "$BL64_VAR_NONE" ]] && namespace='' || namespace="--namespace ${namespace}"

  bl64_msg_show_lib_task "${_BL64_K8S_TXT_SET_ANNOTATION} (${resource}/${name})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    'annotate' $verbosity $namespace \
    --overwrite \
    "$resource" \
    "$name" \
    "$@"
}

#######################################
# Create namespace
#
# * If already created do nothing
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
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'namespace' ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  if bl64_k8s_resource_is_created "$kubeconfig" "$BL64_K8S_RESOURCE_NS" "$namespace"; then
    bl64_msg_show_lib_info "${_BL64_K8S_TXT_RESOURCE_EXISTING} (${_BL64_K8S_TXT_CREATE_NS}:${namespace})"
    return 0
  fi

  bl64_msg_show_lib_task "${_BL64_K8S_TXT_CREATE_NS} (${namespace})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl "$kubeconfig" \
    'create' $verbosity "$BL64_K8S_RESOURCE_NS" "$namespace"
}

#######################################
# Create service account
#
# * If already created do nothing
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: target namespace
#   $3: service account name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_sa_create() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NULL}}"
  local sa="${3:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'sa' ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  if bl64_k8s_resource_is_created "$kubeconfig" "$BL64_K8S_RESOURCE_SA" "$sa" "$namespace"; then
    bl64_msg_show_lib_info "${_BL64_K8S_TXT_RESOURCE_EXISTING} (${_BL64_K8S_TXT_CREATE_SA}:${sa})"
    return 0
  fi

  bl64_msg_show_lib_task "${_BL64_K8S_TXT_CREATE_SA} (${namespace}/${sa})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl "$kubeconfig" \
    'create' $verbosity --namespace="$namespace" "$BL64_K8S_RESOURCE_SA" "$sa"
}

#######################################
# Create generic secret from file
#
# * If already created do nothing
# * File must containe the secret value only
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: target namespace
#   $3: secret name
#   $4: secret key
#   $5: path to the file with the secret value
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_secret_create() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NULL}}"
  local secret="${3:-${BL64_VAR_NULL}}"
  local key="${4:-${BL64_VAR_NULL}}"
  local file="${5:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'secret' &&
    bl64_check_parameter 'file' &&
    bl64_check_file "$file" ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  if bl64_k8s_resource_is_created "$kubeconfig" "$BL64_K8S_RESOURCE_SECRET" "$secret" "$namespace"; then
    bl64_msg_show_lib_info "${_BL64_K8S_TXT_RESOURCE_EXISTING} (${BL64_K8S_RESOURCE_SECRET}:${secret})"
    return 0
  fi

  bl64_msg_show_lib_task "${_BL64_K8S_TXT_CREATE_SECRET} (${namespace}/${secret}/${key})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl "$kubeconfig" \
    'create' $verbosity --namespace="$namespace" \
    "$BL64_K8S_RESOURCE_SECRET" 'generic' "$secret" \
    --type 'Opaque' \
    --from-file="${key}=${file}"
}

#######################################
# Copy secret between namespaces
#
# * If already created do nothing
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: source namespace
#   $3: target namespace
#   $4: secret name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_secret_copy() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace_src="${2:-${BL64_VAR_NULL}}"
  local namespace_dst="${3:-${BL64_VAR_NULL}}"
  local secret="${4:-${BL64_VAR_NULL}}"
  local resource=''
  local -i status=0

  bl64_check_parameter 'namespace_src' &&
    bl64_check_parameter 'namespace_dst' &&
    bl64_check_parameter 'secret' ||
    return $?

  if bl64_k8s_resource_is_created "$kubeconfig" "$BL64_K8S_RESOURCE_SECRET" "$secret" "$namespace_dst"; then
    bl64_msg_show_lib_info "${_BL64_K8S_TXT_RESOURCE_EXISTING} (${BL64_K8S_RESOURCE_SECRET}:${secret})"
    return 0
  fi

  resource="$($BL64_FS_CMD_MKTEMP)" || return $?

  bl64_msg_show_lib_task "${_BL64_K8S_TXT_GET_SECRET} (${namespace_src}/${secret})"
  bl64_k8s_resource_get "$kubeconfig" "$BL64_K8S_RESOURCE_SECRET" "$secret" "$namespace_src" |
    bl64_txt_run_awk $BL64_TXT_SET_AWS_FS ':' '
      BEGIN { metadata = 0 }
      $1 ~ /"metadata"/ { metadata = 1 }
      metadata == 1 && $1 ~ /"namespace"/ { metadata = 0; next }
      { print $0 }
      ' >"$resource"
  status=$?

  if ((status == 0)); then
    bl64_msg_show_lib_task "${_BL64_K8S_TXT_CREATE_SECRET} (${namespace_dst}/${secret})"
    bl64_k8s_resource_update "$kubeconfig" "$namespace_dst" "$resource"
    status=$?
  fi

  [[ -f "$resource" ]] && bl64_fs_rm_file "$resource"
  return $status
}

#######################################
# Apply updates to resources based on definition file
#
# * Overwrite
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
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NULL}}"
  local definition="${3:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'definition' &&
    bl64_check_file "$definition" ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  bl64_msg_show_lib_task "${_BL64_K8S_TXT_RESOURCE_UPDATE} (${definition} -> ${namespace})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    'apply' $verbosity \
    --namespace="$namespace" \
    --force='false' \
    --force-conflicts='false' \
    --grace-period='-1' \
    --overwrite='true' \
    --validate='strict' \
    --wait='true' \
    --filename="$definition"
}

#######################################
# Get resource definition
#
# * output type is json
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: resource type
#   $3: resource name
#   $4: namespace where resources are (optional)
# Outputs:
#   STDOUT: resource definition
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_resource_get() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local resource="${2:-${BL64_VAR_NULL}}"
  local name="${3:-${BL64_VAR_NULL}}"
  local namespace="${4:-}"

  bl64_check_parameter 'resource' &&
    bl64_check_parameter 'name' ||
    return $?

  [[ -n "$namespace" ]] && namespace="--namespace ${namespace}"

  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    'get' $BL64_K8S_SET_OUTPUT_JSON \
    $namespace "$resource" "$name"
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
    bl64_check_module 'BL64_K8S_MODULE' ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_SET_VERBOSE_NORMAL"
  bl64_dbg_lib_command_enabled && verbosity="$BL64_K8S_SET_VERBOSE_TRACE"

  bl64_k8s_blank_kubectl
  shift

  bl64_dbg_lib_command_trace_start
  # shellcheck disable=SC2086
  "$BL64_K8S_CMD_KUBECTL" \
    --kubeconfig="$kubeconfig" \
    $verbosity "$@"
  bl64_dbg_lib_command_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_k8s_blank_kubectl() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited HELM_* shell variables'
  bl64_dbg_lib_trace_start
  unset POD_NAMESPACE
  unset KUBECONFIG
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Verify that the resource is created
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: resource type
#   $3: resource name
#   $4: namespace where resources are
# Outputs:
#   STDOUT: nothing
#   STDERR: nothing unless debug
# Returns:
#   0: resource exists
#   >0: resources does not exist or execution error
#######################################
function bl64_k8s_resource_is_created() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local type="${2:-${BL64_VAR_NULL}}"
  local name="${3:-${BL64_VAR_NULL}}"
  local namespace="${4:-}"

  bl64_check_parameter 'type' &&
    bl64_check_parameter 'name' ||
    return $?

  [[ -n "$namespace" ]] && namespace="--namespace ${namespace}"

  # shellcheck disable=SC2086
  if bl64_dbg_lib_task_enabled; then
    bl64_k8s_run_kubectl "$kubeconfig" \
      'get' "$type" "$name" \
      $BL64_K8S_SET_OUTPUT_NAME $namespace
  else
    bl64_k8s_run_kubectl "$kubeconfig" \
      'get' "$type" "$name" \
      $BL64_K8S_SET_OUTPUT_NAME $namespace >/dev/null 2>&1
  fi
}
