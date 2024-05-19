#######################################
# BashLib64 / Module / Globals / Interact with Kubernetes
#######################################

# shellcheck disable=SC2034
{
  declare BL64_K8S_VERSION='3.1.0'

  declare BL64_K8S_MODULE='0'

  declare BL64_K8S_CMD_KUBECTL="$BL64_VAR_UNAVAILABLE"

  declare BL64_K8S_CFG_KUBECTL_OUTPUT=''
  declare BL64_K8S_CFG_KUBECTL_OUTPUT_JSON='j'
  declare BL64_K8S_CFG_KUBECTL_OUTPUT_YAML='y'

  declare BL64_K8S_SET_VERBOSE_NONE="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_VERBOSE_NORMAL="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_VERBOSE_DEBUG="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_OUTPUT_JSON="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_OUTPUT_YAML="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_OUTPUT_TXT="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_OUTPUT_NAME="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_DRY_RUN_SERVER="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_DRY_RUN_CLIENT="$BL64_VAR_UNAVAILABLE"

  declare BL64_K8S_VERSION_KUBECTL=''

  declare BL64_K8S_RESOURCE_NS='namespace'
  declare BL64_K8S_RESOURCE_SA='serviceaccount'
  declare BL64_K8S_RESOURCE_SECRET='secret'

  declare _BL64_K8S_TXT_CREATE_NS='create namespace'
  declare _BL64_K8S_TXT_CREATE_SA='create service account'
  declare _BL64_K8S_TXT_CREATE_SECRET='create generic secret'
  declare _BL64_K8S_TXT_SET_LABEL='set or update label'
  declare _BL64_K8S_TXT_SET_ANNOTATION='set or update annotation'
  declare _BL64_K8S_TXT_GET_SECRET='get secret definition from source'
  declare _BL64_K8S_TXT_CREATE_SECRET='copy secret to destination'
  declare _BL64_K8S_TXT_RESOURCE_UPDATE='create or update resource definition'
  declare _BL64_K8S_TXT_RESOURCE_EXISTING='the resource is already created. No further actions are needed'
  declare _BL64_K8S_TXT_ERROR_KUBECTL_VERSION='unable to determine kubectl version'
  declare _BL64_K8S_TXT_ERROR_INVALID_KUBECONF='kubectl config file not found'
  declare _BL64_K8S_TXT_ERROR_MISSING_COMMAND='kubectl command not provided'
}
