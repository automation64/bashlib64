#######################################
# BashLib64 / Module / Setup / Show shell debugging inlevelion
#
# Version: 1.0.0
#######################################

#
# Individual debugging level status
#
function bl64_dbg_app_task_enabled { [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_ALL" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_TASK" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_task_enabled { [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_ALL" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_TASK" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_command_enabled { [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_ALL" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_CMD" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_command_enabled { [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_ALL" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_CMD" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_trace_enabled { [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_ALL" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_TRACE" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_trace_enabled { [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_ALL" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_TRACE" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }

#
# Individual debugging level control
#
function bl64_dbg_all_disable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_NONE"; }
function bl64_dbg_all_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_ALL"; }
function bl64_dbg_app_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_APP_ALL"; }
function bl64_dbg_lib_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_LIB_ALL"; }
function bl64_dbg_app_task_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_APP_TASK"; }
function bl64_dbg_lib_task_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_LIB_TASK"; }
function bl64_dbg_app_command_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_APP_CMD"; }
function bl64_dbg_lib_command_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_LIB_CMD"; }
function bl64_dbg_app_trace_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_APP_TRACE"; }
function bl64_dbg_lib_trace_enable { BL64_LIB_DEBUG="$BL64_DBG_TARGET_LIB_TRACE"; }

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
#   >0: unable to set
#######################################
function bl64_dbg_set_level() {
  local level="$1"

  bl64_check_parameter 'level' || return $?

  case "$level" in
  "$BL64_DBG_TARGET_NONE") bl64_dbg_all_disable ;;
  "$BL64_DBG_TARGET_APP_TRACE") bl64_dbg_app_trace_enable ;;
  "$BL64_DBG_TARGET_APP_TASK") bl64_dbg_app_task_enable ;;
  "$BL64_DBG_TARGET_APP_CMD") bl64_dbg_app_command_enable ;;
  "$BL64_DBG_TARGET_APP_ALL") bl64_dbg_app_enable ;;
  "$BL64_DBG_TARGET_LIB_TRACE") bl64_dbg_lib_trace_enable ;;
  "$BL64_DBG_TARGET_LIB_TASK") bl64_dbg_lib_task_enable ;;
  "$BL64_DBG_TARGET_LIB_CMD") bl64_dbg_lib_command_enable ;;
  "$BL64_DBG_TARGET_LIB_ALL") bl64_dbg_lib_enable ;;
  "$BL64_DBG_TARGET_ALL") bl64_dbg_all_enable ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}
