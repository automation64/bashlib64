#######################################
# BashLib64 / Module / Setup / Show shell debugging inlevelion
#######################################

#
# Individual debugging level status
#
function bl64_dbg_app_task_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_TASK" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_task_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_TASK" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_command_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CMD" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_command_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_CMD" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_trace_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_TRACE" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_trace_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_TRACE" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_custom_1_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_1" ]]; }
function bl64_dbg_app_custom_2_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_2" ]]; }
function bl64_dbg_app_custom_3_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_3" ]]; }

#
# Individual debugging level control
#
function bl64_dbg_all_disable { BL64_DBG_TARGET="$BL64_DBG_TARGET_NONE"; }
function bl64_dbg_all_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_ALL"; }
function bl64_dbg_app_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_ALL"; }
function bl64_dbg_lib_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_ALL"; }
function bl64_dbg_app_task_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_TASK"; }
function bl64_dbg_lib_task_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_TASK"; }
function bl64_dbg_app_command_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CMD"; }
function bl64_dbg_lib_command_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_CMD"; }
function bl64_dbg_app_trace_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_TRACE"; }
function bl64_dbg_lib_trace_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_TRACE"; }
function bl64_dbg_app_custom_1_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_1"; }
function bl64_dbg_app_custom_2_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_2"; }
function bl64_dbg_app_custom_3_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_3"; }

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
# * Warning: keep this module independant (do not depend on other bl64 modules)
# * Debugging messages are disabled by default
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_dbg_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
  bl64_dbg_lib_show_function

  bl64_dbg_all_disable &&
    BL64_DBG_MODULE="$BL64_VAR_ON"
}

#######################################
# Set debugging level
#
# Arguments:
#   $1: target level. One of BL64_DBG_TARGET_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_dbg_set_level() {
  local level="$1"
  case "$level" in
  "$BL64_DBG_TARGET_NONE") bl64_dbg_all_disable ;;
  "$BL64_DBG_TARGET_APP_TRACE") bl64_dbg_app_trace_enable ;;
  "$BL64_DBG_TARGET_APP_TASK") bl64_dbg_app_task_enable ;;
  "$BL64_DBG_TARGET_APP_CMD") bl64_dbg_app_command_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_1") bl64_dbg_app_custom_1_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_2") bl64_dbg_app_custom_2_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_3") bl64_dbg_app_custom_3_enable ;;
  "$BL64_DBG_TARGET_APP_ALL") bl64_dbg_app_enable ;;
  "$BL64_DBG_TARGET_LIB_TRACE") bl64_dbg_lib_trace_enable ;;
  "$BL64_DBG_TARGET_LIB_TASK") bl64_dbg_lib_task_enable ;;
  "$BL64_DBG_TARGET_LIB_CMD") bl64_dbg_lib_command_enable ;;
  "$BL64_DBG_TARGET_LIB_ALL") bl64_dbg_lib_enable ;;
  "$BL64_DBG_TARGET_ALL") bl64_dbg_all_enable ;;
  *)
    _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_WRONG_LEVEL} ${BL64_DBG_TARGET_ALL}|${BL64_DBG_TARGET_APP_ALL}|${BL64_DBG_TARGET_LIB_ALL}"
    return $BL64_LIB_ERROR_PARAMETER_INVALID
    ;;
  esac
}
