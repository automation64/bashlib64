#######################################
# BashLib64 / Module / Functions / Write messages to logs
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_log_set_runtime() {
  bl64_msg_show_deprecated 'bl64_log_set_runtime' 'bl64_log_set_target'
  bl64_log_set_target "$1" "$BL64_LOG_TYPE_MULTIPLE"
}

#
# Private functions
#

#######################################
# Save a log record to the logs repository
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: log message category. Use any of $BL64_LOG_CATEGORY_*
#   $3: message
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
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local source="$1"
  local category="$2"
  local payload="$3"

  [[ "$BL64_LOG_MODULE" == "$BL64_VAR_OFF" ]] && return 0
  [[ -z "$source" || -z "$category" || -z "$payload" ]] && return "$BL64_LIB_ERROR_PARAMETER_MISSING"

  case "$BL64_LOG_FORMAT" in
  "$BL64_LOG_FORMAT_CSV")
    printf '%(%FT%TZ%z)T%s%s%s%s%s%s%s%s%s%s%s%s\n' \
      '-1' \
      "$BL64_LOG_FS" \
      "$BL64_SCRIPT_SID" \
      "$BL64_LOG_FS" \
      "$HOSTNAME" \
      "$BL64_LOG_FS" \
      "$BL64_SCRIPT_ID" \
      "$BL64_LOG_FS" \
      "${source}" \
      "$BL64_LOG_FS" \
      "$category" \
      "$BL64_LOG_FS" \
      "$payload" >>"$BL64_LOG_DESTINATION"
    ;;
  *) return "$BL64_LIB_ERROR_MODULE_SETUP_INVALID" ;;
  esac
}

#
# Public functions
#

#######################################
# Save a single log record of type 'info' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: message (when BL64_LOG_VERBOSE='1')
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_info() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_ERROR" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_WARNING" ]] &&
    return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_INFO" \
    "$payload"
}

#######################################
# Save a single log record of type 'error' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when BL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_error() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ]] && return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_ERROR" \
    "$payload"
}

#######################################
# Save a single log record of type 'warning' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when BL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_warning() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_ERROR" ]] &&
    return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_WARNING" \
    "$payload"
}
