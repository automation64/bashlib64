#######################################
# BashLib64 / Module / Globals / Show shell debugging information
#
# Version: 1.7.0
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
export BL64_DBG_TARGET_ALL='9'

export _BL64_DBG_TXT_FUNCTION_START='function tracing started'
export _BL64_DBG_TXT_FUNCTION_STOP='function tracing stopped'
export _BL64_DBG_TXT_SHELL_VAR='shell variable'

export _BL64_DBG_TXT_BASH='Bash / Interpreter path'
export _BL64_DBG_TXT_BASHOPTS='Bash / ShOpt Options'
export _BL64_DBG_TXT_SHELLOPTS='Bash / Set -o Options'
export _BL64_DBG_TXT_BASH_VERSION='Bash / Version'
export _BL64_DBG_TXT_OSTYPE='Bash / Detected OS'
export _BL64_DBG_TXT_LC_ALL='Shell / Locale setting'
export _BL64_DBG_TXT_HOSTNAME='Shell / Hostname'
export _BL64_DBG_TXT_EUID='Script / User ID'
export _BL64_DBG_TXT_UID='Script / Effective User ID'
export _BL64_DBG_TXT_BASH_ARGV='Script / Arguments'
export _BL64_DBG_TXT_COMMAND='Script / Last executed command'
export _BL64_DBG_TXT_STATUS='Script / Last exit status'

export _BL64_DBG_TXT_FUNCTION_APP_RUN='run app function with parameters'
export _BL64_DBG_TXT_FUNCTION_LIB_RUN='run bashlib64 function with parameters'

export _BL64_DBG_TXT_CALLSTACK='Last executed function'

export _BL64_DBG_TXT_HOME='Home directory (HOME)'
export _BL64_DBG_TXT_PATH='Search path (PATH)'
export _BL64_DBG_TXT_CD_PWD='Current cd working directory (PWD)'
export _BL64_DBG_TXT_CD_OLDPWD='Previous cd working directory (OLDPWD)'
export _BL64_DBG_TXT_SCRIPT_PATH='Initial script path (BL64_SCRIPT_PATH)'
export _BL64_DBG_TXT_TMPDIR='Temporary path (TMPDIR)'
export _BL64_DBG_TXT_PWD='Current working directory (pwd command)'
