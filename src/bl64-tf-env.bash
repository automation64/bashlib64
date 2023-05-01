#######################################
# BashLib64 / Module / Globals / Interact with Terraform
#
# Version: 1.2.0
#######################################

# Optional module. Not enabled by default
export BL64_TF_MODULE="$BL64_VAR_OFF"

export BL64_TF_LOG_PATH=''
export BL64_TF_LOG_LEVEL=''

export BL64_TF_CMD_TERRAFORM="$BL64_VAR_UNAVAILABLE"

export BL64_TF_VERSION=''

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

export BL64_TF_DEF_PATH_LOCK=''
export BL64_TF_DEF_PATH_RUNTIME=''

export _BL64_TF_TXT_ERROR_GET_VERSION='failed to get terraform CLI version'
