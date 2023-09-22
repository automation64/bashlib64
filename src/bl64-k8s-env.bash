#######################################
# BashLib64 / Module / Globals / Interact with Kubernetes
#######################################

export BL64_K8S_VERSION='2.0.2'

# Optional module. Not enabled by default
export BL64_K8S_MODULE="$BL64_VAR_OFF"

export BL64_K8S_CMD_KUBECTL="$BL64_VAR_UNAVAILABLE"

export BL64_K8S_CFG_KUBECTL_OUTPUT=''
export BL64_K8S_CFG_KUBECTL_OUTPUT_JSON='j'
export BL64_K8S_CFG_KUBECTL_OUTPUT_YAML='y'

export BL64_K8S_SET_VERBOSE_NONE="$BL64_VAR_UNAVAILABLE"
export BL64_K8S_SET_VERBOSE_NORMAL="$BL64_VAR_UNAVAILABLE"
export BL64_K8S_SET_VERBOSE_DEBUG="$BL64_VAR_UNAVAILABLE"
export BL64_K8S_SET_OUTPUT_JSON="$BL64_VAR_UNAVAILABLE"
export BL64_K8S_SET_OUTPUT_YAML="$BL64_VAR_UNAVAILABLE"
export BL64_K8S_SET_OUTPUT_TXT="$BL64_VAR_UNAVAILABLE"
export BL64_K8S_SET_OUTPUT_NAME="$BL64_VAR_UNAVAILABLE"
export BL64_K8S_SET_DRY_RUN_SERVER="$BL64_VAR_UNAVAILABLE"
export BL64_K8S_SET_DRY_RUN_CLIENT="$BL64_VAR_UNAVAILABLE"

export BL64_K8S_VERSION_KUBECTL=''

export BL64_K8S_RESOURCE_NS='namespace'
export BL64_K8S_RESOURCE_SA='serviceaccount'
export BL64_K8S_RESOURCE_SECRET='secret'

export _BL64_K8S_TXT_CREATE_NS='create namespace'
export _BL64_K8S_TXT_CREATE_SA='create service account'
export _BL64_K8S_TXT_CREATE_SECRET='create generic secret'
export _BL64_K8S_TXT_SET_LABEL='set or update label'
export _BL64_K8S_TXT_SET_ANNOTATION='set or update annotation'
export _BL64_K8S_TXT_GET_SECRET='get secret definition from source'
export _BL64_K8S_TXT_CREATE_SECRET='copy secret to destination'
export _BL64_K8S_TXT_RESOURCE_UPDATE='create or update resource definition'
export _BL64_K8S_TXT_RESOURCE_EXISTING='the resource is already created. No further actions are needed'
export _BL64_K8S_TXT_ERROR_KUBECTL_VERSION='unable to determine kubectl version'
