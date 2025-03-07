#######################################
# BashLib64 / Module / Globals / Write messages to logs
#######################################

# shellcheck disable=SC2034
{
  declare BL64_LOG_VERSION='3.0.1'

  declare BL64_LOG_MODULE='0'

  # Log file types
  declare BL64_LOG_FORMAT_CSV='C'

  # Logging categories
  declare BL64_LOG_CATEGORY_NONE='NONE'
  declare BL64_LOG_CATEGORY_INFO='INFO'
  declare BL64_LOG_CATEGORY_DEBUG='DEBUG'
  declare BL64_LOG_CATEGORY_WARNING='WARNING'
  declare BL64_LOG_CATEGORY_ERROR='ERROR'

  # Parameters
  declare BL64_LOG_REPOSITORY_MODE='0755'
  declare BL64_LOG_TARGET_MODE='0644'

  # Log Target Type
  declare BL64_LOG_TYPE_SINGLE='S'
  declare BL64_LOG_TYPE_MULTIPLE='M'

  # Module variables
  declare BL64_LOG_FS=''
  declare BL64_LOG_FORMAT=''
  declare BL64_LOG_LEVEL=''
  declare BL64_LOG_REPOSITORY=''
  declare BL64_LOG_DESTINATION=''
  declare BL64_LOG_RUNTIME=''
}
