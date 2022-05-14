#######################################
# BashLib64 / Module / Globals / Display messages
#
# Version: 1.7.0
#######################################

export BL64_MSG_VERBOSE_NONE='0'
export BL64_MSG_VERBOSE_APP='1'
export BL64_MSG_VERBOSE_LIB='2'

export BL64_MSG_FORMAT_PLAIN='R'
export BL64_MSG_FORMAT_HOST='H'
export BL64_MSG_FORMAT_TIME='T'
export BL64_MSG_FORMAT_CALLER='C'
export BL64_MSG_FORMAT_FULL='F'

export BL64_MSG_FORMAT="${BL64_MSG_FORMAT:-$BL64_MSG_FORMAT_FULL}"

readonly _BL64_MSG_TXT_USAGE='Usage'
readonly _BL64_MSG_TXT_COMMANDS='Commands'
readonly _BL64_MSG_TXT_FLAGS='Flags'
readonly _BL64_MSG_TXT_PARAMETERS='Parameters'
readonly _BL64_MSG_TXT_ERROR='Error'
readonly _BL64_MSG_TXT_INFO='Info'
readonly _BL64_MSG_TXT_TASK='Task'
readonly _BL64_MSG_TXT_DEBUG='Debug'
readonly _BL64_MSG_TXT_WARNING='Warning'
readonly _BL64_MSG_TXT_BATCH='Process'
readonly _BL64_MSG_TXT_INVALID_FORMAT='invalid format. Please use one of BL64_MSG_FORMAT_*'
readonly _BL64_MSG_TXT_BATCH_START='started'
readonly _BL64_MSG_TXT_BATCH_FINISH_OK='finished successfully'
readonly _BL64_MSG_TXT_BATCH_FINISH_ERROR='finished with errors'

