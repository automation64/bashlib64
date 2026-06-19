#######################################
# BashLib64 / Module / Globals / Interact with Terraform
#######################################

# shellcheck disable=SC2034
{
  declare BL64_TF_VERSION='3.3.0'

  declare BL64_TF_MODULE='0'

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

  declare BL64_TF_FILE_LOCK='.terraform.lock.hcl'
  declare BL64_TF_DIR_RUNTIME='.terraform'

  declare BL64_TF_CFG_LOG_LEVEL=''

  declare BL64_TF_PATH_PLUGIN_CACHE=''
  declare BL64_TF_PATH_LOG=''
}
