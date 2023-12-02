#######################################
# BashLib64 / Module / Globals / Write messages to logs
#######################################

export BL64_LOG_VERSION='2.1.1'

# Optional module. Not enabled by default
export BL64_LOG_MODULE='0'

# Log file types
export BL64_LOG_FORMAT_CSV='C'

# Logging categories
export BL64_LOG_CATEGORY_NONE='NONE'
export BL64_LOG_CATEGORY_INFO='INFO'
export BL64_LOG_CATEGORY_DEBUG='DEBUG'
export BL64_LOG_CATEGORY_WARNING='WARNING'
export BL64_LOG_CATEGORY_ERROR='ERROR'

# Parameters
export BL64_LOG_REPOSITORY_MODE='0755'
export BL64_LOG_TARGET_MODE='0644'

# Module variables
export BL64_LOG_FS=''
export BL64_LOG_FORMAT=''
export BL64_LOG_LEVEL=''
export BL64_LOG_REPOSITORY=''
export BL64_LOG_DESTINATION=''
export BL64_LOG_RUNTIME=''

export _BL64_LOG_TXT_INVALID_TYPE='invalid log type. Please use any of BL64_LOG_TYPE_*'
export _BL64_LOG_TXT_SET_TARGET_FAILED='failed to set log target'
export _BL64_LOG_TXT_CREATE_REPOSITORY='create log repository'