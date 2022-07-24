#######################################
# BashLib64 / Module / Functions / Write messages to logs
#
# Version: 1.6.0
#######################################

#######################################
# Save a log record to the logs repository
#
# Arguments:
#   $1: name of the function, command or script name that is generating the message
#   $2: log message category. Use any of $BL64_LOG_CATEGORY_*
#   $4: message to be saved to the logs repository
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#   BL64_LIB_ERROR_MODULE_SETUP_MISSING
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function _bl64_log_register() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local category="$2"
  local payload="$3"

  bl64_check_module_setup "$BL64_LOG_MODULE" || return $?

  case "$BL64_LOG_TYPE" in
  "$BL64_LOG_TYPE_FILE")
    printf '%(%d%m%Y%H%M%S)T%s%s%s%s%s%s%s%s%s%s%s%s\n' \
      '-1' \
      "$BL64_LOG_FS" \
      "$HOSTNAME" \
      "$BL64_LOG_FS" \
      "$BL64_SCRIPT_ID" \
      "$BL64_LOG_FS" \
      "$BL64_SCRIPT_SID" \
      "$BL64_LOG_FS" \
      "${source}" \
      "$BL64_LOG_FS" \
      "$category" \
      "$BL64_LOG_FS" \
      "$payload" >>"$BL64_LOG_PATH"
    ;;
  *)
    bl64_msg_show_error "$_BL64_LOG_TXT_INVALID_TYPE"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_MODULE_SETUP_INVALID
    ;;
  esac
}

#######################################
# Save a single log record of type 'info' to the logs repository.
# Optionally display the message on STDOUT (BL64_LOG_VERBOSE='1')
#
# Arguments:
#   $1: message to be recorded
#   $2: name of the function, command or script name that is generating the message
# Outputs:
#   STDOUT: message (when BL64_LOG_VERBOSE='1')
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_info() {
  bl64_dbg_lib_show_function "$@"
  local payload="$1"
  local source="${2:-${FUNCNAME[1]:-NONE}}"

  if [[ -n "$BL64_LOG_VERBOSE" && "$BL64_LOG_VERBOSE" == '1' ]]; then
    bl64_msg_show_info "$payload"
  fi

  _bl64_log_register \
    "${source:-main}" \
    "$BL64_LOG_CATEGORY_INFO" \
    "$payload"
}

#######################################
# Save a single log record of type 'task' to the logs repository.
# Optionally display the message on STDOUT (BL64_LOG_VERBOSE='1')
#
# Arguments:
#   $1: message to be recorded
#   $2: name of the function, command or script name that is generating the message
# Outputs:
#   STDOUT: message (when BL64_LOG_VERBOSE='1')
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_task() {
  bl64_dbg_lib_show_function "$@"
  local payload="$1"
  local source="${2:-${FUNCNAME[1]:-NONE}}"

  if [[ -n "$BL64_LOG_VERBOSE" && "$BL64_LOG_VERBOSE" == '1' ]]; then
    bl64_msg_show_task "$payload"
  fi

  _bl64_log_register \
    "${source:-main}" \
    "$BL64_LOG_CATEGORY_TASK" \
    "$payload"
}

#######################################
# Save a single log record of type 'error' to the logs repository.
# Optionally display the message on STDERR (BL64_LOG_VERBOSE='1')
#
# Arguments:
#   $1: message to be recorded
#   $2: name of the function, command or script name that is generating the message
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when BL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_error() {
  bl64_dbg_lib_show_function "$@"
  local payload="$1"
  local source="${2:-${FUNCNAME[1]:-NONE}}"

  if [[ -n "$BL64_LOG_VERBOSE" && "$BL64_LOG_VERBOSE" == '1' ]]; then
    bl64_msg_show_error "$payload"
  fi

  _bl64_log_register \
    "${source:-main}" \
    "$BL64_LOG_CATEGORY_ERROR" \
    "$payload"
}

#######################################
# Save a single log record of type 'warning' to the logs repository.
# Optionally display the message on STDERR (BL64_LOG_VERBOSE='1')
#
# Arguments:
#   $1: message to be recorded
#   $2: name of the function, command or script name that is generating the message
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when BL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_warning() {
  bl64_dbg_lib_show_function "$@"
  local payload="$1"
  local source="${2:-${FUNCNAME[1]:-NONE}}"

  if [[ -n "$BL64_LOG_VERBOSE" && "$BL64_LOG_VERBOSE" == '1' ]]; then
    bl64_msg_show_warning "$payload"
  fi

  _bl64_log_register \
    "${source:-main}" \
    "$BL64_LOG_CATEGORY_WARNING" \
    "$payload"
}

#######################################
# Record a log stream and save it to the logs repository.
# Each line is saved as a different log record.
#
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
function bl64_log_record() {
  bl64_dbg_lib_show_function "$@"
  local tag="${1:-tag}"
  local source="${2:-${FUNCNAME[1]:-NONE}}"
  local input_log_line=''

  case "$BL64_LOG_TYPE" in
  "$BL64_LOG_TYPE_FILE")
    while read -r input_log_line; do
      _bl64_log_register \
        "${source:-main}" \
        "$BL64_LOG_CATEGORY_RECORD" \
        "${tag}${BL64_LOG_FS}${input_log_line}"
    done
    ;;
  *)
    bl64_msg_show_error "$_BL64_LOG_TXT_INVALID_TYPE"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_MODULE_SETUP_INVALID
    ;;
  esac
}
