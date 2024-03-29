#######################################
# BashLib64 / Module / Globals / Display messages
#######################################

# shellcheck disable=SC2034
{
  declare BL64_MSG_VERSION='5.0.1'

  declare BL64_MSG_MODULE='0'

  # Target verbosity)
  declare BL64_MSG_VERBOSE=''

  #
  # Verbosity levels
  #
  # * 0: nothing is showed
  # * 1: application messages only
  # * 2: bashlib64 and application messages
  #

  declare BL64_MSG_VERBOSE_NONE='NONE'
  declare BL64_MSG_VERBOSE_APP='APP'
  declare BL64_MSG_VERBOSE_LIB='LIB'
  declare BL64_MSG_VERBOSE_ALL='ALL'

  #
  # Message type tag
  #

  declare BL64_MSG_TYPE_BATCH='BATCH'
  declare BL64_MSG_TYPE_BATCHERR='BATCHERR'
  declare BL64_MSG_TYPE_BATCHOK='BATCHOK'
  declare BL64_MSG_TYPE_ERROR='ERROR'
  declare BL64_MSG_TYPE_INFO='INFO'
  declare BL64_MSG_TYPE_INPUT='INPUT'
  declare BL64_MSG_TYPE_LIBINFO='LIBINFO'
  declare BL64_MSG_TYPE_LIBSUBTASK='LIBSUBTASK'
  declare BL64_MSG_TYPE_LIBTASK='LIBTASK'
  declare BL64_MSG_TYPE_PHASE='PHASE'
  declare BL64_MSG_TYPE_SEPARATOR='SEPARATOR'
  declare BL64_MSG_TYPE_SUBTASK='SUBTASK'
  declare BL64_MSG_TYPE_TASK='TASK'
  declare BL64_MSG_TYPE_WARNING='WARNING'

  #
  # Message output type
  #

  declare BL64_MSG_OUTPUT_ASCII='A'
  declare BL64_MSG_OUTPUT_ANSI='N'

  # default message output type
  declare BL64_MSG_OUTPUT=''

  #
  # Message formats
  #

  declare BL64_MSG_FORMAT_PLAIN='R'
  declare BL64_MSG_FORMAT_HOST='H'
  declare BL64_MSG_FORMAT_TIME='T'
  declare BL64_MSG_FORMAT_CALLER='C'
  declare BL64_MSG_FORMAT_FULL='F'

  # Selected message format
  declare BL64_MSG_FORMAT="${BL64_MSG_FORMAT:-$BL64_MSG_FORMAT_FULL}"

  #
  # Message Themes
  #

  declare BL64_MSG_THEME_ID_ASCII_STD='ascii-std'
  # shellcheck disable=SC2034
  declare BL64_MSG_THEME_ASCII_STD_BATCH='(@)'
  declare BL64_MSG_THEME_ASCII_STD_BATCHERR='(@)'
  declare BL64_MSG_THEME_ASCII_STD_BATCHOK='(@)'
  declare BL64_MSG_THEME_ASCII_STD_ERROR='(!)'
  declare BL64_MSG_THEME_ASCII_STD_FMTCALLER=''
  declare BL64_MSG_THEME_ASCII_STD_FMTHOST=''
  declare BL64_MSG_THEME_ASCII_STD_FMTTIME=''
  declare BL64_MSG_THEME_ASCII_STD_INFO='(I)'
  declare BL64_MSG_THEME_ASCII_STD_INPUT='(?)'
  declare BL64_MSG_THEME_ASCII_STD_LIBINFO='(II)'
  declare BL64_MSG_THEME_ASCII_STD_LIBSUBTASK='(>>)'
  declare BL64_MSG_THEME_ASCII_STD_LIBTASK='(--)'
  declare BL64_MSG_THEME_ASCII_STD_PHASE='(=)'
  declare BL64_MSG_THEME_ASCII_STD_SEPARATOR=''
  declare BL64_MSG_THEME_ASCII_STD_SUBTASK='(>)'
  declare BL64_MSG_THEME_ASCII_STD_TASK='(-)'
  declare BL64_MSG_THEME_ASCII_STD_WARNING='(*)'

  declare BL64_MSG_THEME_ID_ANSI_STD='ansi-std'
  # shellcheck disable=SC2034
  declare BL64_MSG_THEME_ANSI_STD_BATCH='30;1;47'
  declare BL64_MSG_THEME_ANSI_STD_BATCHERR='5;30;41'
  declare BL64_MSG_THEME_ANSI_STD_BATCHOK='30;42'
  declare BL64_MSG_THEME_ANSI_STD_ERROR='5;37;41'
  declare BL64_MSG_THEME_ANSI_STD_FMTCALLER='33'
  declare BL64_MSG_THEME_ANSI_STD_FMTHOST='34'
  declare BL64_MSG_THEME_ANSI_STD_FMTTIME='36'
  declare BL64_MSG_THEME_ANSI_STD_INFO='36'
  declare BL64_MSG_THEME_ANSI_STD_INPUT='5;30;47'
  declare BL64_MSG_THEME_ANSI_STD_LIBINFO='1;32'
  declare BL64_MSG_THEME_ANSI_STD_LIBSUBTASK='1;36'
  declare BL64_MSG_THEME_ANSI_STD_LIBTASK='1;35'
  declare BL64_MSG_THEME_ANSI_STD_PHASE='7;1;36'
  declare BL64_MSG_THEME_ANSI_STD_SEPARATOR='30;44'
  declare BL64_MSG_THEME_ANSI_STD_SUBTASK='37'
  declare BL64_MSG_THEME_ANSI_STD_TASK='1;37'
  declare BL64_MSG_THEME_ANSI_STD_WARNING='5;37;43'

  # Selected message theme
  declare BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'

  #
  # ANSI codes
  #

  # shellcheck disable=SC2034
  declare BL64_MSG_ANSI_FG_BLACK='30'
  declare BL64_MSG_ANSI_FG_RED='31'
  declare BL64_MSG_ANSI_FG_GREEN='32'
  declare BL64_MSG_ANSI_FG_BROWN='33'
  declare BL64_MSG_ANSI_FG_BLUE='34'
  declare BL64_MSG_ANSI_FG_PURPLE='35'
  declare BL64_MSG_ANSI_FG_CYAN='36'
  declare BL64_MSG_ANSI_FG_LIGHT_GRAY='37'
  declare BL64_MSG_ANSI_FG_DARK_GRAY='1;30'
  declare BL64_MSG_ANSI_FG_LIGHT_RED='1;31'
  declare BL64_MSG_ANSI_FG_LIGHT_GREEN='1;32'
  declare BL64_MSG_ANSI_FG_YELLOW='1;33'
  declare BL64_MSG_ANSI_FG_LIGHT_BLUE='1;34'
  declare BL64_MSG_ANSI_FG_LIGHT_PURPLE='1;35'
  declare BL64_MSG_ANSI_FG_LIGHT_CYAN='1;36'
  declare BL64_MSG_ANSI_FG_WHITE='1;37'

  # shellcheck disable=SC2034
  declare BL64_MSG_ANSI_BG_BLACK='40'
  declare BL64_MSG_ANSI_BG_RED='41'
  declare BL64_MSG_ANSI_BG_GREEN='42'
  declare BL64_MSG_ANSI_BG_BROWN='43'
  declare BL64_MSG_ANSI_BG_BLUE='44'
  declare BL64_MSG_ANSI_BG_PURPLE='45'
  declare BL64_MSG_ANSI_BG_CYAN='46'
  declare BL64_MSG_ANSI_BG_LIGHT_GRAY='47'
  declare BL64_MSG_ANSI_BG_DARK_GRAY='1;40'
  declare BL64_MSG_ANSI_BG_LIGHT_RED='1;41'
  declare BL64_MSG_ANSI_BG_LIGHT_GREEN='1;42'
  declare BL64_MSG_ANSI_BG_YELLOW='1;43'
  declare BL64_MSG_ANSI_BG_LIGHT_BLUE='1;44'
  declare BL64_MSG_ANSI_BG_LIGHT_PURPLE='1;45'
  declare BL64_MSG_ANSI_BG_LIGHT_CYAN='1;46'
  declare BL64_MSG_ANSI_BG_WHITE='1;47'

  # shellcheck disable=SC2034
  declare BL64_MSG_ANSI_CHAR_NORMAL='0'
  declare BL64_MSG_ANSI_CHAR_BOLD='1'
  declare BL64_MSG_ANSI_CHAR_UNDERLINE='4'
  declare BL64_MSG_ANSI_CHAR_BLINK='5'
  declare BL64_MSG_ANSI_CHAR_REVERSE='7'

  #
  # Cosmetic
  #

  # shellcheck disable=SC2034
  declare BL64_MSG_COSMETIC_ARROW='-->'
  declare BL64_MSG_COSMETIC_ARROW2='==>'
  declare BL64_MSG_COSMETIC_LEFT_ARROW='<--'
  declare BL64_MSG_COSMETIC_LEFT_ARROW2='<=='
  declare BL64_MSG_COSMETIC_PHASE_PREFIX='===['
  declare BL64_MSG_COSMETIC_PHASE_SUFIX=']==='
  declare BL64_MSG_COSMETIC_PIPE='|'

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
}
