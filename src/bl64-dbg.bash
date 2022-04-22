#######################################
# BashLib64 / Show shell debugging information
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.4.0
#######################################

#######################################
# Show runtime info up to the current function call
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: runtime info
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show() {
  local -i last_status=$?

  [[ "$BL64_LIB_DEBUG" != "$BL64_DBG_TARGET_APP_TASK" && "$BL64_LIB_DEBUG" != "$BL64_DBG_TARGET_APP_ALL" ]] &&
    return 0

  bl64_msg_show_debug "${_BL64_DBG_TXT_BASH}: [${BASH}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_BASHOPTS}: [${BASHOPTS:-NONE}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_TMPDIR}: [${TMPDIR:-NONE}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_BASH_VERSION}: [${BASH_VERSION}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_OSTYPE}: [${OSTYPE:-NONE}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_LC_ALL}: [${LC_ALL:-NONE}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_HOME}: [${HOME:-EMPTY}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_PATH}: [${PATH:-EMPTY}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_HOSTNAME}: [${HOSTNAME:-EMPTY}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_EUID}: [${EUID}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_UID}: [${UID}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_BASH_ARGV}: [${BASH_ARGV[*]:-NONE}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_STATUS}: [${last_status}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_BASH_LINENO}(1): [${BASH_LINENO[1]:-}:${FUNCNAME[1]:-NONE}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_BASH_LINENO}(2): [${BASH_LINENO[2]:-}:${FUNCNAME[2]:-NONE}]"
  bl64_msg_show_debug "${_BL64_DBG_TXT_BASH_LINENO}(3): [${BASH_LINENO[3]:-}:${FUNCNAME[3]:-NONE}]"

  return $last_status
}

#######################################
# Stop app  shell tracing
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_trace_stop() {
  [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_TRACE" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_ALL" ]] &&
    set +x &&
    bl64_msg_show_debug "[${FUNCNAME[1]}] ${_BL64_DBG_TXT_FUNCTION_STOP}"
  return 0
}

#######################################
# Start app  shell tracing if target is in scope
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_trace_start() {
  [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_TRACE" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_ALL" ]] &&
    bl64_msg_show_debug "[${FUNCNAME[1]}] ${_BL64_DBG_TXT_FUNCTION_START}" &&
    set -x
  return 0
}

#######################################
# Stop bashlib64 shell tracing
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_trace_stop() {
  [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_TRACE" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_ALL" ]] &&
    set +x &&
    bl64_msg_show_debug "[${FUNCNAME[1]}] ${_BL64_DBG_TXT_FUNCTION_STOP}"
  return 0
}

#######################################
# Start bashlib64 shell tracing if target is in scope
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_trace_start() {
  [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_TRACE" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_ALL" ]] &&
    bl64_msg_show_debug "[${FUNCNAME[1]}] ${_BL64_DBG_TXT_FUNCTION_START}" &&
    set -x
  return 0
}

#######################################
# Show bashlib64 task level debugging information
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_info() {
  local message="$1"

  [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_TASK" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_LIB_ALL" ]] &&
    bl64_msg_show_debug "[${FUNCNAME[1]}] $message"

  return 0
}

#######################################
# Show app task level debugging information
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_info() {
  local message="$1"

  [[ "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_TASK" || "$BL64_LIB_DEBUG" == "$BL64_DBG_TARGET_APP_ALL" ]] &&
    bl64_msg_show_debug "[${FUNCNAME[1]}] $message"

  return 0
}

#######################################
# Show bashlib64 task level variable values
#
# Arguments:
#   $@: variable names
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_vars() {
  local variable=''

  [[ "$BL64_LIB_DEBUG" != "$BL64_DBG_TARGET_LIB_TASK" && "$BL64_LIB_DEBUG" != "$BL64_DBG_TARGET_LIB_ALL" || "$#" == '0' ]] &&
    return 0

  for variable in "$@"; do
    eval "bl64_msg_show_debug \"[${FUNCNAME[1]}] ${_BL64_DBG_TXT_SHELL_VAR} ${variable}=\$${variable}\""
  done

  return 0
}

#######################################
# Show app task level variable values
#
# Arguments:
#   $@: variable names
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_vars() {
  local variable=''

  [[ "$BL64_LIB_DEBUG" != "$BL64_DBG_TARGET_APP_TASK" && "$BL64_LIB_DEBUG" != "$BL64_DBG_TARGET_APP_ALL" || "$#" == '0' ]] &&
    return 0

  for variable in "$@"; do
    eval "bl64_msg_show_debug \"[${FUNCNAME[1]}] ${_BL64_DBG_TXT_SHELL_VAR} ${variable}=\$${variable}\""
  done

  return 0
}
