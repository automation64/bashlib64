#######################################
# BashLib64 / Module / Globals / Show shell debugging information
#######################################

# shellcheck disable=SC2034
{
  declare BL64_DBG_VERSION='3.1.3'

  declare BL64_DBG_MODULE='0'

  # Debug target
  declare BL64_DBG_TARGET=''

  #
  # Debug targets. Use to select what to debug and how
  #
  # * ALL_TRACE: Shell tracing for the application and bashlib64
  # * APP_TRACE: Shell tracing for selected application functions
  # * APP_TASK: Debugging messages from selected application functions
  # * APP_CMD: External commands: enable command specific debugging options used in the app
  # * APP_CUSTOM_X: Do nothing. Reserved to allow the application define custom debug
  # * APP_ALL: Enable full app debugging (task,trace,cmd)
  # * LIB_TRACE: Shell tracing for selected bashlib64 functions
  # * LIB_TASK: Debugging messages from selected bashlib64 functions
  # * LIB_CMD: External commands: enable command specific debugging options used in bashlib64
  # * LIB_ALL: Enable full bashlib64 debugging (task,trace,cmd)
  #

  declare BL64_DBG_TARGET_NONE='NONE'
  declare BL64_DBG_TARGET_APP_TRACE='APP_TRACE'
  declare BL64_DBG_TARGET_APP_TASK='APP_TASK'
  declare BL64_DBG_TARGET_APP_CMD='APP_CMD'
  declare BL64_DBG_TARGET_APP_ALL='APP'
  declare BL64_DBG_TARGET_APP_CUSTOM_1='CUSTOM_1'
  declare BL64_DBG_TARGET_APP_CUSTOM_2='CUSTOM_2'
  declare BL64_DBG_TARGET_APP_CUSTOM_3='CUSTOM_3'
  declare BL64_DBG_TARGET_LIB_TRACE='LIB_TRACE'
  declare BL64_DBG_TARGET_LIB_TASK='LIB_TASK'
  declare BL64_DBG_TARGET_LIB_CMD='LIB_CMD'
  declare BL64_DBG_TARGET_LIB_ALL='LIB'
  declare BL64_DBG_TARGET_ALL='ALL'

  #
  # Debugging exclussions
  #
  # * Used to excluded non-esential debugging information from general output
  # * Each variable represents a module
  # * Default is to exclude declared modules
  #

  declare BL64_DBG_EXCLUDE_CHECK="$BL64_VAR_ON"
  declare BL64_DBG_EXCLUDE_MSG="$BL64_VAR_ON"
  declare BL64_DBG_EXCLUDE_LOG="$BL64_VAR_ON"

  declare _BL64_DBG_TXT_FUNCTION_START='start-function-tracing'
  declare _BL64_DBG_TXT_FUNCTION_STOP='stop-function-tracing'
  declare _BL64_DBG_TXT_SHELL_VAR='shell-variable'
  declare _BL64_DBG_TXT_COMMENTS='dev-comments'
  declare _BL64_DBG_TXT_INFO='dev-info'

  declare _BL64_DBG_TXT_LABEL_BASH_RUNTIME='[bash-runtime]'
  declare _BL64_DBG_TXT_LABEL_BASH_VARIABLE='[bash-variable]'
  declare _BL64_DBG_TXT_LABEL_FUNCTION='>>>'
  declare _BL64_DBG_TXT_LABEL_INFO='==='
  declare _BL64_DBG_TXT_LABEL_TRACE='***'

  declare _BL64_DBG_TXT_CALLSTACK='Last executed function'
}
