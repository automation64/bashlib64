#######################################
# BashLib64 / Module / Globals / Interact with Terraform
#######################################

declare BL64_TF_VERSION='1.4.1'

declare BL64_TF_MODULE='0'

declare BL64_TF_LOG_PATH=''
declare BL64_TF_LOG_LEVEL=''

declare BL64_TF_CMD_TERRAFORM="$BL64_VAR_UNAVAILABLE"

declare BL64_TF_VERSION_CLI=''

# Output export formats
declare BL64_TF_OUTPUT_RAW='0'
declare BL64_TF_OUTPUT_JSON='1'
declare BL64_TF_OUTPUT_TEXT='2'

declare BL64_TF_SET_LOG_TRACE=''
declare BL64_TF_SET_LOG_DEBUG=''
declare BL64_TF_SET_LOG_INFO=''
declare BL64_TF_SET_LOG_WARN=''
declare BL64_TF_SET_LOG_ERROR=''
declare BL64_TF_SET_LOG_OFF=''

declare BL64_TF_DEF_PATH_LOCK=''
declare BL64_TF_DEF_PATH_RUNTIME=''

declare _BL64_TF_TXT_ERROR_GET_VERSION='failed to get terraform CLI version'
