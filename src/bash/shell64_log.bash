#!/bin/bash
#######################################
# Bash library / Shell64 / Log messages
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/shell64
# Version: 1.0.0
#######################################

#
# Exported Constants
#

declare -gx SHELL64_LOG_TYPE_FILE='F'
declare -gx SHELL64_LOG_CATEGORY_INFO='info'
declare -gx SHELL64_LOG_CATEGORY_TASK='task'
declare -gx SHELL64_LOG_CATEGORY_DEBUG='debug'
declare -gx SHELL64_LOG_CATEGORY_WARNING='warning'
declare -gx SHELL64_LOG_CATEGORY_ERROR='error'
declare -gx SHELL64_LOG_CATEGORY_RECORD='record'

#
# Exported Variables
#

declare -gx SHELL64_LOG_VERBOSE="${SHELL64_LOG_VERBOSE:-1}"
declare -gx SHELL64_LOG_FS="${SHELL64_LOG_FS:-:}"
declare -gx SHELL64_LOG_PATH="${SHELL64_LOG_PATH:-/dev/null}"
declare -gx SHELL64_LOG_TYPE="${SHELL64_LOG_TYPE:-$SHELL64_LOG_TYPE_FILE}"

#
# Internal Variables
#

#
# Internal Functions
#

#######################################
# Save a log record to the logs repository
#
# Globals:
#   SHELL64_LOG_TYPE
#   SHELL64_LOG_TYPE_FILE
#   SHELL64_LOG_FS
#   SHELL64_SCRIPT_NAME
#   SHELL64_SCRIPT_SID
#   SHELL64_LOG_PATH
#   SHELL64_LOG_CATEGORY_INFO
#   SHELL64_LOG_CATEGORY_TASK
#   SHELL64_LOG_CATEGORY_DEBUG
#   SHELL64_LOG_CATEGORY_WARNING
#   SHELL64_LOG_CATEGORY_ERROR
#   SHELL64_LOG_CATEGORY_RECORD
# Arguments:
#   $1: name of the function, command or script name that is generating the message
#   $2: log message category. Use any of $SHELL64_LOG_CATEGORY_*
#   $4: message to be saved to the logs repository
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function _shell64_log_register() {

  local source="$1"
  local category="$2"
  local payload="$3"

  case "$SHELL64_LOG_TYPE" in
  "$SHELL64_LOG_TYPE_FILE")
    printf '%(%d%m%Y%H%M%S)T%s%s%s%s%s%s%s%s%s%s%s%s\n' \
      '-1' \
      "$SHELL64_LOG_FS" \
      "$HOSTNAME" \
      "$SHELL64_LOG_FS" \
      "$SHELL64_SCRIPT_NAME" \
      "$SHELL64_LOG_FS" \
      "$SHELL64_SCRIPT_SID" \
      "$SHELL64_LOG_FS" \
      "${source}" \
      "$SHELL64_LOG_FS" \
      "$category" \
      "$SHELL64_LOG_FS" \
      "$payload" >>"$SHELL64_LOG_PATH"
    ;;
  esac

}

#
# Exported Functions
#

#######################################
# Initialize the log repository
#
# Globals:
#   SHELL64_LOG_PATH
#   SHELL64_LOG_VERBOSE
#   SHELL64_LOG_TYPE
#   SHELL64_LOG_FS
# Arguments:
#   $1: full path to the log repository
#   $2: show log messages to STDOUT/STDERR?. 1: yes, 0: no
#   $3: log type. Use any of the constants $SHELL64_LOG_TYPE_*
#   $4: field separator character to be used on each log record
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function shell64_log_setup() {

  SHELL64_LOG_PATH="${1:-$SHELL64_LOG_PATH}"
  SHELL64_LOG_VERBOSE="${2:-$SHELL64_LOG_VERBOSE}"
  SHELL64_LOG_TYPE="${3:-$SHELL64_LOG_TYPE}"
  SHELL64_LOG_FS="${4:-$SHELL64_LOG_FS}"

  return 0

}

#######################################
# Save a single log record of type 'info' to the logs repository.
# Optionally display the message on STDOUT (SHELL64_LOG_VERBOSE='1')
#
# Globals:
#   SHELL64_LOG_VERBOSE
#   SHELL64_LOG_CATEGORY_INFO
# Arguments:
#   $1: message to be recorded
#   $2: name of the function, command or script name that is generating the message
# Outputs:
#   STDOUT: message (when SHELL64_LOG_VERBOSE='1')
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function shell64_log_info() {

  local payload="$1"
  local source="${2:-${FUNCNAME[1]}}"

  if [[ -n "$SHELL64_LOG_VERBOSE" && "$SHELL64_LOG_VERBOSE" == '1' ]]; then
    shell64_msg_show_info "$payload"
  fi

  _shell64_log_register \
    "${source:-main}" \
    "$SHELL64_LOG_CATEGORY_INFO" \
    "$payload"

}

#######################################
# Save a single log record of type 'task' to the logs repository.
# Optionally display the message on STDOUT (SHELL64_LOG_VERBOSE='1')
#
# Globals:
#   SHELL64_LOG_VERBOSE
#   SHELL64_LOG_CATEGORY_TASK
# Arguments:
#   $1: message to be recorded
#   $2: name of the function, command or script name that is generating the message
# Outputs:
#   STDOUT: message (when SHELL64_LOG_VERBOSE='1')
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function shell64_log_task() {

  local payload="$1"
  local source="${2:-${FUNCNAME[1]}}"

  if [[ -n "$SHELL64_LOG_VERBOSE" && "$SHELL64_LOG_VERBOSE" == '1' ]]; then
    shell64_msg_show_task "$payload"
  fi

  _shell64_log_register \
    "${source:-main}" \
    "$SHELL64_LOG_CATEGORY_TASK" \
    "$payload"

}

#######################################
# Save a single log record of type 'error' to the logs repository.
# Optionally display the message on STDERR (SHELL64_LOG_VERBOSE='1')
#
# Globals:
#   SHELL64_LOG_VERBOSE
#   SHELL64_LOG_CATEGORY_ERROR
# Arguments:
#   $1: message to be recorded
#   $2: name of the function, command or script name that is generating the message
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when SHELL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function shell64_log_error() {

  local payload="$1"
  local source="${2:-${FUNCNAME[1]}}"

  if [[ -n "$SHELL64_LOG_VERBOSE" && "$SHELL64_LOG_VERBOSE" == '1' ]]; then
    shell64_msg_show_error "$payload"
  fi

  _shell64_log_register \
    "${source:-main}" \
    "$SHELL64_LOG_CATEGORY_ERROR" \
    "$payload"

}

#######################################
# Save a single log record of type 'warning' to the logs repository.
# Optionally display the message on STDERR (SHELL64_LOG_VERBOSE='1')
#
# Globals:
#   SHELL64_LOG_VERBOSE
#   SHELL64_LOG_CATEGORY_WARNING
# Arguments:
#   $1: message to be recorded
#   $2: name of the function, command or script name that is generating the message
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when SHELL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function shell64_log_warning() {

  local payload="$1"
  local source="${2:-${FUNCNAME[1]}}"

  if [[ -n "$SHELL64_LOG_VERBOSE" && "$SHELL64_LOG_VERBOSE" == '1' ]]; then
    shell64_msg_show_warning "$payload"
  fi

  _shell64_log_register \
    "${source:-main}" \
    "$SHELL64_LOG_CATEGORY_WARNING" \
    "$payload"

}

#######################################
# Record a log stream and save it to the logs repository.
# Each line is saved as a different log record.
#
# Globals:
#   SHELL64_LOG_TYPE
#   SHELL64_LOG_TYPE_FILE
#   SHELL64_LOG_CATEGORY_RECORD
#   SHELL64_LOG_FS
# Arguments:
#   $1: short alphanumeric string to identify the log stream
#   $2: name of the function, command or script name that is generating the stream
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: stream successfully saved
#   >0: failed to save the stream
#######################################
function shell64_log_record() {

  local tag="${1:-tag}"
  local source="${2:-${FUNCNAME[1]}}"
  local input_log_line=''

  case "$SHELL64_LOG_TYPE" in
  "$SHELL64_LOG_TYPE_FILE")
    while read -r input_log_line; do
      _shell64_log_register \
        "${source:-main}" \
        "$SHELL64_LOG_CATEGORY_RECORD" \
        "${tag}${SHELL64_LOG_FS}${input_log_line}"
    done
    ;;
  esac

}
