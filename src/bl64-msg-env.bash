#######################################
# BashLib64 / Module / Globals / Display messages
#
# Version: 2.0.0
#######################################

#
# Verbosity levels
#
# * 0: nothing is showed
# * 1: application messages only
# * 2: bashlib64 and application messages
#

export BL64_MSG_VERBOSE_NONE='0'
export BL64_MSG_VERBOSE_APP='1'
export BL64_MSG_VERBOSE_LIB='2'

#
# Message output type
#

export BL64_MSG_OUTPUT_ASCII='A'
export BL64_MSG_OUTPUT_ANSI='N'

# default message output type
export BL64_MSG_OUTPUT="$BL64_MSG_OUTPUT_ANSI"

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

declare -g -A BL64_MSG_THEME_ASCII_STD=(
  [ERROR]='(!)'
  [WARNING]='(*)'
  [INFO]='(I)'
  [TASK]='(-)'
  [LIBTASK]='(-)'
  [DEBUG]='(=)'
  [BATCH]='(@)'
  [BATCHOK]='(@)'
  [BATCHERR]='(@)'
  [FMTHOST]=''
  [FMTCALLER]=''
  [FMTTIME]=''
)

#  [ERROR]="$BL64_MSG_ANSI_FG_RED"
declare -g -A BL64_MSG_THEME_ANSI_STD=(
  [ERROR]='5;31'
  [WARNING]='35'
  [INFO]='36'
  [TASK]='1;37'
  [LIBTASK]='37'
  [DEBUG]='33'
  [BATCH]='30;1;47'
  [BATCHOK]='30;42'
  [BATCHERR]='5;30;41'
  [FMTHOST]='34'
  [FMTCALLER]='33'
  [FMTTIME]='36'
)

# Selected message theme
declare -g -n BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'

#
# ANSI codes
#

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

declare BL64_MSG_ANSI_CHAR_NORMAL='0'
declare BL64_MSG_ANSI_CHAR_BOLD='1'
declare BL64_MSG_ANSI_CHAR_UNDERLINE='4'
declare BL64_MSG_ANSI_CHAR_BLINK='5'
declare BL64_MSG_ANSI_CHAR_REVERSE='7'

#
# Display messages
#

declare _BL64_MSG_TXT_USAGE='Usage'
declare _BL64_MSG_TXT_COMMANDS='Commands'
declare _BL64_MSG_TXT_FLAGS='Flags'
declare _BL64_MSG_TXT_PARAMETERS='Parameters'
declare _BL64_MSG_TXT_ERROR='Error'
declare _BL64_MSG_TXT_INFO='Info'
declare _BL64_MSG_TXT_TASK='Task'
declare _BL64_MSG_TXT_DEBUG='Debug'
declare _BL64_MSG_TXT_WARNING='Warning'
declare _BL64_MSG_TXT_BATCH='Process'
declare _BL64_MSG_TXT_BATCH_START='started'
declare _BL64_MSG_TXT_BATCH_FINISH_OK='finished successfully'
declare _BL64_MSG_TXT_BATCH_FINISH_ERROR='finished with errors'
declare _BL64_MSG_TXT_INVALID_FORMAT='invalid format. Please use one of BL64_MSG_FORMAT_*'
declare _BL64_MSG_TXT_INVALID_OUTPUT='invalid output type. Please use one of BL64_MSG_OUTPUT_*'
declare _BL64_MSG_TXT_INVALID_THEME='invalid theme. Please use one of BL64_MSG_THEME_*'
