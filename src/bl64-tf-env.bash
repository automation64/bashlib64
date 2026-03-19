#######################################
# BashLib64 / Module / Globals / Interact with Terraform
#######################################

# shellcheck disable=SC2034
{
  declare BL64_TF_VERSION='3.2.0'

  declare BL64_TF_MODULE='0'

  declare BL64_TF_LOG_PATH=''
  declare BL64_TF_LOG_LEVEL=''

  declare BL64_TF_CMD_TERRAFORM="$BL64_VAR_UNAVAILABLE"
  declare BL64_TF_CMD_TOFU="$BL64_VAR_UNAVAILABLE"

  declare BL64_TF_VERSION_CLI=''

  # Output export formats
  declare BL64_TF_OUTPUT_RAW='0'
  declare BL64_TF_OUTPUT_JSON='1'
  declare BL64_TF_OUTPUT_TEXT='2'

  declare BL64_TF_SET_LOG_TRACE='TRACE'
  declare BL64_TF_SET_LOG_DEBUG='DEBUG'
  declare BL64_TF_SET_LOG_INFO='INFO'
  declare BL64_TF_SET_LOG_WARN='WARN'
  declare BL64_TF_SET_LOG_ERROR='ERROR'
  declare BL64_TF_SET_LOG_OFF='OFF'

  declare BL64_TF_DEF_PATH_LOCK=''
  declare BL64_TF_DEF_PATH_RUNTIME=''
}
