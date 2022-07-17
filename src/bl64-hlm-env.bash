#######################################
# BashLib64 / Module / Globals / Interact with HLM
#
# Version: 1.0.0
#######################################

# Optional module. Not enabled by default
export BL64_HLM_MODULE="$BL64_LIB_VAR_OFF"

export BL64_HLM_CMD_HELM="$BL64_LIB_UNAVAILABLE"

export BL64_HLM_SET_DEBUG=''
export BL64_HLM_SET_OUTPUT_TABLE=''
export BL64_HLM_SET_OUTPUT_JSON=''
export BL64_HLM_SET_OUTPUT_YAML=''

export BL64_HLM_K8S_TIMEOUT=''

# Variables from external commands
export HELM_CACHE_HOME
export HELM_CONFIG_HOME
export HELM_DATA_HOME
export HELM_DEBUG
export HELM_DRIVER
export HELM_DRIVER_SQL_CONNECTION_STRING
export HELM_MAX_HISTORY
export HELM_NAMESPACE
export HELM_NO_PLUGINS
export HELM_PLUGINS
export HELM_REGISTRY_CONFIG
export HELM_REPOSITORY_CACHE
export HELM_REPOSITORY_CONFIG
export HELM_KUBEAPISERVER
export HELM_KUBECAFILE
export HELM_KUBEASGROUPS
export HELM_KUBEASUSER
export HELM_KUBECONTEXT
export HELM_KUBETOKEN
