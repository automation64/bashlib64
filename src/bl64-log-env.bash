#######################################
# BashLib64 / Module / Globals / Write messages to logs
#
# Version: 1.2.0
#######################################

export BL64_LOG_TYPE_FILE='F'
export BL64_LOG_CATEGORY_INFO='info'
export BL64_LOG_CATEGORY_TASK='task'
export BL64_LOG_CATEGORY_DEBUG='debug'
export BL64_LOG_CATEGORY_WARNING='warning'
export BL64_LOG_CATEGORY_ERROR='error'
export BL64_LOG_CATEGORY_RECORD='record'

readonly _BL64_LOG_TXT_NOT_SETUP='missing setup information. Please use the bl64_log_setup function before calling bl64_log_* functions'
readonly _BL64_LOG_TXT_INVALID_TYPE='invalid log type. Please use any of BL64_LOG_TYPE_*'
readonly _BL64_LOG_TXT_INVALID_VERBOSE='invalid option for verbose. Please use 1 (enable) or 0 (disable)'

export BL64_LOG_PATH=''
export BL64_LOG_VERBOSE=''
export BL64_LOG_FS=''
export BL64_LOG_TYPE=''
