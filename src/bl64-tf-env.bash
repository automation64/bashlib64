#######################################
# BashLib64 / Module / Globals / Interact with Terraform
#
# Version: 1.0.0
#######################################

# Optional module. Not enabled by default
export BL64_TF_MODULE="$BL64_LIB_VAR_OFF"

export BL64_TF_LOG_PATH=''
export BL64_TF_LOG_LEVEL=''

export BL64_TF_CMD_TERRAFORM="$BL64_LIB_UNAVAILABLE"

# Output export formats
export BL64_TF_OUTPUT_RAW='0'
export BL64_TF_OUTPUT_JSON='1'
export BL64_TF_OUTPUT_TEXT='2'

export BL64_TF_SET_LOG_TRACE=''
export BL64_TF_SET_LOG_DEBUG=''
export BL64_TF_SET_LOG_INFO=''
export BL64_TF_SET_LOG_WARN=''
export BL64_TF_SET_LOG_ERROR=''
export BL64_TF_SET_LOG_OFF=''

# Variables for external commands
export TF_LOG
export TF_LOG_PATH
export TF_CLI_CONFIG_FILE
export TF_LOG
export TF_LOG_PATH
export TF_IN_AUTOMATION
export TF_INPUT
export TF_VAR_name
export TF_DATA_DIR
export TF_PLUGIN_CACHE_DIR
export TF_REGISTRY_DISCOVERY_RETRY
export TF_REGISTRY_CLIENT_TIMEOUT
