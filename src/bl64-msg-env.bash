#######################################
# BashLib64 / Module / Globals / Display messages
#######################################

export BL64_MSG_VERSION='4.3.0'

export BL64_MSG_MODULE="$BL64_VAR_OFF"

# Target verbosity)
export BL64_MSG_VERBOSE=''

#
# Verbosity levels
#
# * 0: nothing is showed
# * 1: application messages only
# * 2: bashlib64 and application messages
#

export BL64_MSG_VERBOSE_NONE='NONE'
export BL64_MSG_VERBOSE_APP='APP'
export BL64_MSG_VERBOSE_LIB='LIB'
export BL64_MSG_VERBOSE_ALL='ALL'

#
# Message type tag
#

export BL64_MSG_TYPE_BATCH='BATCH'
export BL64_MSG_TYPE_BATCHERR='BATCHERR'
export BL64_MSG_TYPE_BATCHOK='BATCHOK'
export BL64_MSG_TYPE_ERROR='ERROR'
export BL64_MSG_TYPE_INFO='INFO'
export BL64_MSG_TYPE_INPUT='INPUT'
export BL64_MSG_TYPE_LIBINFO='LIBINFO'
export BL64_MSG_TYPE_LIBSUBTASK='LIBSUBTASK'
export BL64_MSG_TYPE_LIBTASK='LIBTASK'
export BL64_MSG_TYPE_PHASE='PHASE'
export BL64_MSG_TYPE_SEPARATOR='SEPARATOR'
export BL64_MSG_TYPE_SUBTASK='SUBTASK'
export BL64_MSG_TYPE_TASK='TASK'
export BL64_MSG_TYPE_WARNING='WARNING'

#
# Message output type
#

export BL64_MSG_OUTPUT_ASCII='A'
export BL64_MSG_OUTPUT_ANSI='N'

# default message output type
export BL64_MSG_OUTPUT=''

#
# Message formats
#

export BL64_MSG_FORMAT_PLAIN='R'
export BL64_MSG_FORMAT_HOST='H'
export BL64_MSG_FORMAT_TIME='T'
export BL64_MSG_FORMAT_CALLER='C'
export BL64_MSG_FORMAT_FULL='F'

# Selected message format
export BL64_MSG_FORMAT="${BL64_MSG_FORMAT:-$BL64_MSG_FORMAT_FULL}"

#
# Message Themes
#

export BL64_MSG_THEME_ID_ASCII_STD='ascii-std'
export BL64_MSG_THEME_ASCII_STD_BATCH='(@)'
export BL64_MSG_THEME_ASCII_STD_BATCHERR='(@)'
export BL64_MSG_THEME_ASCII_STD_BATCHOK='(@)'
export BL64_MSG_THEME_ASCII_STD_ERROR='(!)'
export BL64_MSG_THEME_ASCII_STD_FMTCALLER=''
export BL64_MSG_THEME_ASCII_STD_FMTHOST=''
export BL64_MSG_THEME_ASCII_STD_FMTTIME=''
export BL64_MSG_THEME_ASCII_STD_INFO='(I)'
export BL64_MSG_THEME_ASCII_STD_INPUT='(?)'
export BL64_MSG_THEME_ASCII_STD_LIBINFO='(II)'
export BL64_MSG_THEME_ASCII_STD_LIBSUBTASK='(>>)'
export BL64_MSG_THEME_ASCII_STD_LIBTASK='(--)'
export BL64_MSG_THEME_ASCII_STD_PHASE='(=)'
export BL64_MSG_THEME_ASCII_STD_SEPARATOR=''
export BL64_MSG_THEME_ASCII_STD_SUBTASK='(>)'
export BL64_MSG_THEME_ASCII_STD_TASK='(-)'
export BL64_MSG_THEME_ASCII_STD_WARNING='(*)'

export BL64_MSG_THEME_ID_ANSI_STD='ansi-std'
export BL64_MSG_THEME_ANSI_STD_BATCH='30;1;47'
export BL64_MSG_THEME_ANSI_STD_BATCHERR='5;30;41'
export BL64_MSG_THEME_ANSI_STD_BATCHOK='30;42'
export BL64_MSG_THEME_ANSI_STD_ERROR='5;37;41'
export BL64_MSG_THEME_ANSI_STD_FMTCALLER='33'
export BL64_MSG_THEME_ANSI_STD_FMTHOST='34'
export BL64_MSG_THEME_ANSI_STD_FMTTIME='36'
export BL64_MSG_THEME_ANSI_STD_INFO='36'
export BL64_MSG_THEME_ANSI_STD_INPUT='5;30;47'
export BL64_MSG_THEME_ANSI_STD_LIBINFO='1;32'
export BL64_MSG_THEME_ANSI_STD_LIBSUBTASK='1;36'
export BL64_MSG_THEME_ANSI_STD_LIBTASK='1;35'
export BL64_MSG_THEME_ANSI_STD_PHASE='7;1;36'
export BL64_MSG_THEME_ANSI_STD_SEPARATOR='30;44'
export BL64_MSG_THEME_ANSI_STD_SUBTASK='37'
export BL64_MSG_THEME_ANSI_STD_TASK='1;37'
export BL64_MSG_THEME_ANSI_STD_WARNING='5;37;43'

# Selected message theme
export BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'

#
# ANSI codes
#

export BL64_MSG_ANSI_FG_BLACK='30'
export BL64_MSG_ANSI_FG_RED='31'
export BL64_MSG_ANSI_FG_GREEN='32'
export BL64_MSG_ANSI_FG_BROWN='33'
export BL64_MSG_ANSI_FG_BLUE='34'
export BL64_MSG_ANSI_FG_PURPLE='35'
export BL64_MSG_ANSI_FG_CYAN='36'
export BL64_MSG_ANSI_FG_LIGHT_GRAY='37'
export BL64_MSG_ANSI_FG_DARK_GRAY='1;30'
export BL64_MSG_ANSI_FG_LIGHT_RED='1;31'
export BL64_MSG_ANSI_FG_LIGHT_GREEN='1;32'
export BL64_MSG_ANSI_FG_YELLOW='1;33'
export BL64_MSG_ANSI_FG_LIGHT_BLUE='1;34'
export BL64_MSG_ANSI_FG_LIGHT_PURPLE='1;35'
export BL64_MSG_ANSI_FG_LIGHT_CYAN='1;36'
export BL64_MSG_ANSI_FG_WHITE='1;37'

export BL64_MSG_ANSI_BG_BLACK='40'
export BL64_MSG_ANSI_BG_RED='41'
export BL64_MSG_ANSI_BG_GREEN='42'
export BL64_MSG_ANSI_BG_BROWN='43'
export BL64_MSG_ANSI_BG_BLUE='44'
export BL64_MSG_ANSI_BG_PURPLE='45'
export BL64_MSG_ANSI_BG_CYAN='46'
export BL64_MSG_ANSI_BG_LIGHT_GRAY='47'
export BL64_MSG_ANSI_BG_DARK_GRAY='1;40'
export BL64_MSG_ANSI_BG_LIGHT_RED='1;41'
export BL64_MSG_ANSI_BG_LIGHT_GREEN='1;42'
export BL64_MSG_ANSI_BG_YELLOW='1;43'
export BL64_MSG_ANSI_BG_LIGHT_BLUE='1;44'
export BL64_MSG_ANSI_BG_LIGHT_PURPLE='1;45'
export BL64_MSG_ANSI_BG_LIGHT_CYAN='1;46'
export BL64_MSG_ANSI_BG_WHITE='1;47'

export BL64_MSG_ANSI_CHAR_NORMAL='0'
export BL64_MSG_ANSI_CHAR_BOLD='1'
export BL64_MSG_ANSI_CHAR_UNDERLINE='4'
export BL64_MSG_ANSI_CHAR_BLINK='5'
export BL64_MSG_ANSI_CHAR_REVERSE='7'

#
# Cosmetic
#

export BL64_MSG_COSMETIC_ARROW='-->'
export BL64_MSG_COSMETIC_ARROW2='==>'
export BL64_MSG_COSMETIC_LEFT_ARROW='<--'
export BL64_MSG_COSMETIC_LEFT_ARROW2='<=='
export BL64_MSG_COSMETIC_PHASE_PREFIX='===['
export BL64_MSG_COSMETIC_PHASE_SUFIX=']==='
export BL64_MSG_COSMETIC_PIPE='|'

#
# Display messages
#

declare _BL64_MSG_TXT_BATCH_FINISH_ERROR='finished with errors'
declare _BL64_MSG_TXT_BATCH_FINISH_OK='finished successfully'
declare _BL64_MSG_TXT_BATCH_START='started'
declare _BL64_MSG_TXT_BATCH='Process'
declare _BL64_MSG_TXT_COMMANDS='Commands'
declare _BL64_MSG_TXT_ERROR='Error'
declare _BL64_MSG_TXT_FLAGS='Flags'
declare _BL64_MSG_TXT_INFO='Info'
declare _BL64_MSG_TXT_INPUT='Input'
declare _BL64_MSG_TXT_INVALID_VALUE='invalid value. Not one of'
declare _BL64_MSG_TXT_PARAMETERS='Parameters'
declare _BL64_MSG_TXT_PHASE='Phase'
declare _BL64_MSG_TXT_SEPARATOR='>>>>>'
declare _BL64_MSG_TXT_SUBTASK='Subtask'
declare _BL64_MSG_TXT_TASK='Task'
declare _BL64_MSG_TXT_USAGE='Usage'
declare _BL64_MSG_TXT_WARNING='Warning'
