#######################################
# BashLib64 / Module / Setup / Write messages to logs
#
# Version: 1.0.0
#######################################

#######################################
# Initialize the log repository
#
# Arguments:
#   $1: full path to the log repository
#   $2: show log messages to STDOUT/STDERR?. 1: yes, 0: no
#   $3: log type. Use any of the constants $BL64_LOG_TYPE_*
#   $4: field separator character to be used on each log record
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function bl64_log_setup() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"
  local verbose="${2:-1}"
  local type="${3:-$BL64_LOG_TYPE_FILE}"
  local fs="${4:-:}"

  bl64_check_parameter "$path" || return $?

  # shellcheck disable=SC2086
  if [[ "$type" != "$BL64_LOG_TYPE_FILE" ]]; then
    bl64_msg_show_error "$_BL64_LOG_TXT_INVALID_TYPE"
    return $BL64_LIB_ERROR_MODULE_SETUP_INVALID
  fi

  # shellcheck disable=SC2086
  if [[ "$verbose" != '0' && "$verbose" != '1' ]]; then
    bl64_msg_show_error "$_BL64_LOG_TXT_INVALID_VERBOSE"
    return $BL64_LIB_ERROR_MODULE_SETUP_INVALID
  fi

  BL64_LOG_PATH="${path}"
  BL64_LOG_VERBOSE="${verbose}"
  BL64_LOG_TYPE="${type}"
  BL64_LOG_FS="${fs}"
  return 0
}
