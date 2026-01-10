#######################################
# BashLib64 / Module / Functions / Show shell debugging information
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_dbg_app_show_variables() {
  bl64_msg_show_deprecated 'bl64_dbg_app_show_variables' 'bl64_dbg_app_show_globals'
  bl64_dbg_app_show_globals "$@"
}
function bl64_dbg_lib_show_variables() {
  bl64_msg_show_deprecated 'bl64_dbg_lib_show_variables' 'bl64_dbg_lib_show_globals'
  bl64_dbg_lib_show_globals "$@"
}
function bl64_dbg_app_task_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_task_enabled' 'bl64_dbg_app_task_is_enabled'
  bl64_dbg_app_task_is_enabled
}
function bl64_dbg_lib_task_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_task_enabled' 'bl64_dbg_lib_task_is_enabled'
  bl64_dbg_lib_task_is_enabled
}
function bl64_dbg_app_command_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_command_enabled' 'bl64_dbg_app_command_is_enabled'
  bl64_dbg_app_command_is_enabled
}
function bl64_dbg_lib_command_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_command_enabled' 'bl64_dbg_lib_command_is_enabled'
  bl64_dbg_lib_command_is_enabled
}
function bl64_dbg_app_trace_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_trace_enabled' 'bl64_dbg_app_trace_is_enabled'
  bl64_dbg_app_trace_is_enabled
}
function bl64_dbg_lib_trace_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_trace_enabled' 'bl64_dbg_lib_trace_is_enabled'
  bl64_dbg_lib_trace_is_enabled
}
function bl64_dbg_app_custom_1_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_custom_1_enabled' 'bl64_dbg_app_custom_1_is_enabled'
  bl64_dbg_app_custom_1_is_enabled
}
function bl64_dbg_app_custom_2_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_custom_2_enabled' 'bl64_dbg_app_custom_2_is_enabled'
  bl64_dbg_app_custom_2_is_enabled
}
function bl64_dbg_app_custom_3_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_custom_3_enabled' 'bl64_dbg_app_custom_3_is_enabled'
  bl64_dbg_app_custom_3_is_enabled
}
function bl64_dbg_lib_check_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_check_enabled' '_bl64_dbg_lib_check_is_enabled'
  _bl64_dbg_lib_check_is_enabled
}
function bl64_dbg_lib_log_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_log_enabled' '_bl64_dbg_lib_log_is_enabled'
  _bl64_dbg_lib_log_is_enabled
}
function bl64_dbg_lib_msg_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_msg_enabled' '_bl64_dbg_lib_msg_is_enabled'
  _bl64_dbg_lib_msg_is_enabled
}

#
# Internal functions
#

function _bl64_dbg_show() {
  local message="$1"
  printf '%s: %s\n' '[Debug]' "$message" >&2
}

function _bl64_dbg_dryrun_show() {
  local message="$1"
  printf '%s: %s\n' '[Dry-Run]' "$message"
}

#
# Public functions
#

#######################################
# Show runtime info
#
# * Saves the last exit status so the function will not disrupt the error flow
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
  local label="${_BL64_DBG_TXT_LABEL_BASH_RUNTIME}"
  bl64_dbg_app_command_is_enabled || return "$last_status"

  _bl64_dbg_show "${label} Bash / Interpreter path: [${BASH}]"
  _bl64_dbg_show "${label} Bash / ShOpt Options: [${BASHOPTS:-NONE}]"
  _bl64_dbg_show "${label} Bash / Set -o Options: [${SHELLOPTS:-NONE}]"
  _bl64_dbg_show "${label} Bash / Version: [${BASH_VERSION}]"
  _bl64_dbg_show "${label} Bash / Detected OS: [${OSTYPE:-NONE}]"
  _bl64_dbg_show "${label} Shell / Locale setting: [${LC_ALL:-NONE}]"
  _bl64_dbg_show "${label} Shell / Hostname: [${HOSTNAME:-EMPTY}]"
  _bl64_dbg_show "${label} Script / User ID: [${EUID}]"
  _bl64_dbg_show "${label} Script / Effective User ID: [${UID}]"
  _bl64_dbg_show "${label} Script / Arguments: [${BASH_ARGV[*]:-NONE}]"
  _bl64_dbg_show "${label} Script / Last executed command: [${BASH_COMMAND:-NONE}]"
  _bl64_dbg_show "${label} Script / Last exit status: [${last_status}]"

  bl64_dbg_runtime_show_paths
  bl64_dbg_runtime_show_callstack
  bl64_dbg_runtime_show_bashlib64

  # shellcheck disable=SC2248
  return "$last_status"
}

#######################################
# Show BashLib64 runtime information
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: bl64 runtime info
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show_bashlib64() {
  local label='[bl64-runtime]'
  bl64_dbg_app_task_is_enabled || bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${label} BL64_SCRIPT_NAME: [${BL64_SCRIPT_NAME:-NOTSET}]"
  _bl64_dbg_show "${label} BL64_SCRIPT_SID: [${BL64_SCRIPT_SID:-NOTSET}]"
  _bl64_dbg_show "${label} BL64_SCRIPT_ID: [${BL64_SCRIPT_ID:-NOTSET}]"
  _bl64_dbg_show "${label} BL64_SCRIPT_VERSION: [${BL64_SCRIPT_VERSION:-NOTSET}]"
}

#######################################
# Show runtime call stack
#
# * Show previous 3 functions from the current caller
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: callstack
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show_callstack() {
  local label="${_BL64_DBG_TXT_LABEL_BASH_RUNTIME}"
  bl64_dbg_app_task_is_enabled || bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${label} ${_BL64_DBG_TXT_CALLSTACK}(2): [${BASH_SOURCE[1]:-NONE}:${FUNCNAME[2]:-NONE}:${BASH_LINENO[2]:-0}]"
  _bl64_dbg_show "${label} ${_BL64_DBG_TXT_CALLSTACK}(3): [${BASH_SOURCE[2]:-NONE}:${FUNCNAME[3]:-NONE}:${BASH_LINENO[3]:-0}]"
  _bl64_dbg_show "${label} ${_BL64_DBG_TXT_CALLSTACK}(4): [${BASH_SOURCE[3]:-NONE}:${FUNCNAME[4]:-NONE}:${BASH_LINENO[4]:-0}]"
  _bl64_dbg_show "${label} ${_BL64_DBG_TXT_CALLSTACK}(5): [${BASH_SOURCE[4]:-NONE}:${FUNCNAME[5]:-NONE}:${BASH_LINENO[5]:-0}]"
}

#######################################
# Show runtime paths
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: callstack
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show_paths() {
  local label="${_BL64_DBG_TXT_LABEL_BASH_RUNTIME}"
  bl64_dbg_app_task_is_enabled || bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${label} Initial script path (BL64_SCRIPT_PATH): [${BL64_SCRIPT_PATH:-EMPTY}]"
  _bl64_dbg_show "${label} Home directory (HOME): [${HOME:-EMPTY}]"
  _bl64_dbg_show "${label} Search path (PATH): [${PATH:-EMPTY}]"
  _bl64_dbg_show "${label} Current cd working directory (PWD): [${PWD:-EMPTY}]"
  _bl64_dbg_show "${label} Previous cd working directory (OLDPWD): [${OLDPWD:-EMPTY}]"
  _bl64_dbg_show "${label} Current working directory (pwd command): [$(pwd)]"
  _bl64_dbg_show "${label} Temporary path (TMPDIR): [${TMPDIR:-NONE}]"
}

#######################################
# Stop app  shell tracing
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   exit status from previous command
#######################################
function bl64_dbg_app_trace_stop() {
  local -i state=$?
  bl64_dbg_app_trace_is_enabled || return "$state"
  set +x
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"
  return "$state"
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
  bl64_dbg_app_trace_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
  set -x
  return 0
}

#######################################
# Stop bashlib64 shell tracing
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   Saved exit status
#######################################
function bl64_dbg_lib_trace_stop() {
  local -i state=$?
  bl64_dbg_lib_trace_is_enabled || return "$state"

  set +x
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"

  return "$state"
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
  bl64_dbg_lib_trace_is_enabled || return 0

  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
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
  bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_INFO}: ${*}"
  return 0
}

#######################################
# Show app task level debugging information
#
# Arguments:
#   $@: messages
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_info() {
  bl64_dbg_app_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_INFO}: ${*}"
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
  local value=''
  bl64_dbg_lib_task_is_enabled || return 0

  for variable in "$@"; do
    if [[ ! -v "$variable" ]]; then
      value='**UNSET**'
    else
      value="${!variable}"
    fi

    _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_SHELL_VAR}: [${variable}=${value}]"
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
  local value=''
  bl64_dbg_app_task_is_enabled || return 0

  for variable in "$@"; do
    if [[ ! -v "$variable" ]]; then
      value='**UNSET**'
    else
      value="${!variable}"
    fi

    _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_SHELL_VAR}: [${variable}=${!variable}]"
  done

  return 0
}

#######################################
# Show bashlib64 function name and parameters
#
# Arguments:
#   $@: parameters
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2120
function bl64_dbg_lib_show_function() {
  bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_FUNCTION} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CALL} parameters: ${*}"
  return 0
}

#######################################
# Show app function name and parameters
#
# Arguments:
#   $@: parameters
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2120
function bl64_dbg_app_show_function() {
  bl64_dbg_app_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_FUNCTION} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CALL} parameters: (${*})"
  return 0
}

#######################################
# Stop bashlib64 external command tracing
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   Saved exit status
#######################################
function bl64_dbg_lib_command_trace_stop() {
  local -i state=$?
  bl64_dbg_lib_task_is_enabled || return "$state"

  set +x
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"

  return "$state"
}

#######################################
# Start bashlib64 external command tracing if target is in scope
#
# * Use in functions: bl64_*_run_*
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_command_trace_start() {
  bl64_dbg_lib_task_is_enabled || return 0

  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
  set -x

  return 0
}

#######################################
# Show developer comments in bashlib64 functions
#
# Arguments:
#   $1: comments
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_comments() {
  bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_COMMENTS}: ${*}"
  return 0
}

#######################################
# Show developer comments in app functions
#
# Arguments:
#   $@: comments
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_comments() {
  bl64_dbg_app_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_COMMENTS}: ${*}"
  return 0
}

#######################################
# Show non BL64 global variables and attributes
#
# Arguments:
#   None
# Outputs:
#   STDOUT: declare -p output
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_globals() {
  bl64_dbg_app_task_is_enabled || return 0
  local filter='^declare .*BL64_.*=.*'

  IFS=$'\n'
  for variable in $(declare -p); do
    unset IFS
    [[ "$variable" =~ $filter || "$variable" =~ "declare -- filter=" ]] && continue
    _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_BASH_VARIABLE} ${variable}"
  done
  return 0
}

#######################################
# Show BL64 global variables and attributes
#
# Arguments:
#   None
# Outputs:
#   STDOUT: declare -p output
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_globals() {
  bl64_dbg_lib_task_is_enabled || return 0
  local filter='^declare .*BL64_.*=.*'

  IFS=$'\n'
  for variable in $(declare -p); do
    unset IFS
    [[ ! "$variable" =~ $filter || "$variable" =~ "declare -- filter=" ]] && continue
    _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_BASH_VARIABLE} ${variable}"
  done
  return 0
}

#######################################
# Show app level dryrun information
#
# Arguments:
#   $@: messages
# Outputs:
#   STDOUT: Dryrun message
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_dryrun_show() {
  bl64_dbg_app_dryrun_is_enabled || return 0
  _bl64_dbg_dryrun_show "$@"
  return 0
}

#######################################
# Show lib level dryrun information
#
# Arguments:
#   $@: messages
# Outputs:
#   STDOUT: Dryrun message
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_dryrun_show() {
  bl64_dbg_lib_dryrun_is_enabled || return 0
  _bl64_dbg_dryrun_show "$@"
  return 0
}
