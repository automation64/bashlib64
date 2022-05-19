#######################################
# BashLib64 / Module / Globals / Show shell debugging information
#
# Version: 1.5.0
#######################################

#
# Debug targets. Use to select what to debug and how
#
# * ALL_TRACE: Shell tracing for the application and bashlib64
# * APP_TRACE: Shell tracing for selected application functions
# * APP_TASK: Debugging messages from selected application functions
# * APP_CMD: External commands: enable command specific debugging options used in the app
# * APP_ALL: Enable full app debugging (task,trace,cmd)
# * LIB_TRACE: Shell tracing for selected bashlib64 functions
# * LIB_TASK: Debugging messages from selected bashlib64 functions
# * LIB_CMD: External commands: enable command specific debugging options used in bashlib64
# * LIB_ALL: Enable full bashlib64 debugging (task,trace,cmd)
#

export BL64_DBG_TARGET_NONE='0'
export BL64_DBG_TARGET_APP_TRACE='1'
export BL64_DBG_TARGET_APP_TASK='2'
export BL64_DBG_TARGET_APP_CMD='3'
export BL64_DBG_TARGET_APP_ALL='4'
export BL64_DBG_TARGET_LIB_TRACE='5'
export BL64_DBG_TARGET_LIB_TASK='6'
export BL64_DBG_TARGET_LIB_CMD='7'
export BL64_DBG_TARGET_LIB_ALL='8'

readonly _BL64_DBG_TXT_FUNCTION_START='function tracing started'
readonly _BL64_DBG_TXT_FUNCTION_STOP='function tracing stopped'
readonly _BL64_DBG_TXT_SHELL_VAR='shell variable'

readonly _BL64_DBG_TXT_BASH='Bash / Interpreter path'
readonly _BL64_DBG_TXT_BASHOPTS='Bash / ShOpt Options'
readonly _BL64_DBG_TXT_SHELLOPTS='Bash / Set -o Options'
readonly _BL64_DBG_TXT_BASH_VERSION='Bash / Version'
readonly _BL64_DBG_TXT_OSTYPE='Bash / Detected OS'
readonly _BL64_DBG_TXT_LC_ALL='Shell / Locale setting'
readonly _BL64_DBG_TXT_HOSTNAME='Shell / Hostname'
readonly _BL64_DBG_TXT_EUID='Script / User ID'
readonly _BL64_DBG_TXT_UID='Script / Effective User ID'
readonly _BL64_DBG_TXT_BASH_ARGV='Script / Arguments'
readonly _BL64_DBG_TXT_COMMAND='Script / Last executed command'
readonly _BL64_DBG_TXT_STATUS='Script / Last exit status'

readonly _BL64_DBG_TXT_FUNCTION_RUN='run function with parameters'

readonly _BL64_DBG_TXT_CALLSTACK='Last executed function'

readonly _BL64_DBG_TXT_HOME='Home directory (HOME)'
readonly _BL64_DBG_TXT_PATH='Search path (PATH)'
readonly _BL64_DBG_TXT_CD_PWD='Current cd working directory (PWD)'
readonly _BL64_DBG_TXT_CD_OLDPWD='Previous cd working directory (OLDPWD)'
readonly _BL64_DBG_TXT_SCRIPT_PATH='Initial script path (BL64_SCRIPT_PATH)'
readonly _BL64_DBG_TXT_TMPDIR='Temporary path (TMPDIR)'
readonly _BL64_DBG_TXT_PWD='Current working directory (pwd command)'
