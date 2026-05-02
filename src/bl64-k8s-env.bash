#######################################
# BashLib64 / Module / Globals / Interact with Kubernetes
#######################################

# shellcheck disable=SC2034
{
  declare BL64_K8S_VERSION='4.1.0'

  declare BL64_K8S_MODULE='0'

  declare BL64_K8S_CMD_KUBECTL="$BL64_VAR_UNAVAILABLE"

  declare BL64_K8S_CFG_KUBECONFIG=''
  declare BL64_K8S_CFG_KUBECTL_OUTPUT=''
  declare BL64_K8S_CFG_KUBECTL_OUTPUT_JSON='j'
  declare BL64_K8S_CFG_KUBECTL_OUTPUT_YAML='y'

  declare BL64_K8S_VERSION_KUBECTL=''

  declare BL64_K8S_RESOURCE_NS='namespace'
  declare BL64_K8S_RESOURCE_SA='serviceaccount'
  declare BL64_K8S_RESOURCE_SECRET='secret'
}
