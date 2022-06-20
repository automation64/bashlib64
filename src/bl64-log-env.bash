#######################################
# BashLib64 / Module / Globals / Write messages to logs
#
# Version: 1.2.0
#######################################

# Optional module. Not enabled by default
export BL64_LOG_MODULE="$BL64_LIB_VAR_OFF"

# Log file types
export BL64_LOG_TYPE_FILE='F'

# Logging categories
export BL64_LOG_CATEGORY_INFO='info'
export BL64_LOG_CATEGORY_TASK='task'
export BL64_LOG_CATEGORY_DEBUG='debug'
export BL64_LOG_CATEGORY_WARNING='warning'
export BL64_LOG_CATEGORY_ERROR='error'
export BL64_LOG_CATEGORY_RECORD='record'

declare _BL64_LOG_TXT_INVALID_TYPE='invalid log type. Please use any of BL64_LOG_TYPE_*'
declare _BL64_LOG_TXT_INVALID_VERBOSE='invalid option for verbose. Please use 1 (enable) or 0 (disable)'

# Module parameters
export BL64_LOG_PATH=''
export BL64_LOG_VERBOSE=''
export BL64_LOG_FS=''
export BL64_LOG_TYPE=''
