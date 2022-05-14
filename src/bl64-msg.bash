#######################################
# BashLib64 / Module / Functions / Display messages
#
# Version: 1.7.0
#######################################

function bl64_msg_verbose_app_enabled { [[ "$BL64_LIB_VERBOSE" == "$BL64_MSG_VERBOSE_APP" || "$BL64_LIB_VERBOSE" == "$BL64_MSG_VERBOSE_LIB" ]]; }
function bl64_msg_verbose_lib_enabled { [[ "$BL64_LIB_VERBOSE" == "$BL64_MSG_VERBOSE_LIB" ]]; }

#######################################
# Display message helper
#
# Arguments:
#   $1: type of message
#   $2: message to show
# Outputs:
#   STDOUT: message
#   STDERR: message when type is error or warning
# Returns:
#   printf exit status
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function _bl64_msg_show() {
  local type="$1"
  local message="${2:-${BL64_LIB_DEFAULT}}"

  case "$BL64_MSG_FORMAT" in
  "$BL64_MSG_FORMAT_PLAIN")
    printf "%s: %s\n" \
      "$type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_HOST")
    printf "@%s %s: %s\n" \
      "$HOSTNAME" \
      "$type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_TIME")
    printf "[%(%d/%b/%Y-%H:%M:%S)T] %s: %s\n" \
      '-1' \
      "$type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_CALLER")
    printf "%s %s: %s\n" \
      "$BL64_SCRIPT_NAME" \
      "$type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_FULL")
    printf "%s@%s[%(%d/%b/%Y-%H:%M:%S)T] %s: %s\n" \
      "$BL64_SCRIPT_NAME" \
      "$HOSTNAME" \
      '-1' \
      "$type" \
      "$message"
    ;;
  *)
    bl64_msg_show_error "$_BL64_MSG_TXT_INVALID_FORMAT"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_MODULE_SETUP_INVALID
  esac
}

#######################################
# Show script usage information
#
# Arguments:
#   $1: script command line. Include all required and optional components
#   $2: full script usage description
#   $3: list of script commands
#   $4: list of script flags
#   $5: list of script parameters
# Outputs:
#   STDOUT: usage info
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_usage() {
  local usage="${1:-${BL64_LIB_DEFAULT}}"
  local description="${2:-${BL64_LIB_DEFAULT}}"
  local commands="${3:-${BL64_LIB_DEFAULT}}"
  local flags="${4:-${BL64_LIB_DEFAULT}}"
  local parameters="${5:-${BL64_LIB_DEFAULT}}"

  printf '\n%s: %s %s\n\n' "$_BL64_MSG_TXT_USAGE" "$BL64_SCRIPT_NAME" "$usage"

  if [[ "$description" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n\n' "$description"
  fi

  if [[ "$commands" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_COMMANDS" "$commands"
  fi

  if [[ "$flags" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_FLAGS" "$flags"
  fi

  if [[ "$parameters" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_PARAMETERS" "$parameters"
  fi

  return 0
}

#######################################
# Display error message
#
# Arguments:
#   $1: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_error() {
  local message="$1"

  _bl64_msg_show "$_BL64_MSG_TXT_ERROR" "$message" >&2
}

#######################################
# Display warning message
#
# Arguments:
#   $1: warning message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_warning() {
  local message="$1"

  _bl64_msg_show "$_BL64_MSG_TXT_WARNING" "$message" >&2
}

#######################################
# Display info message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_info() {
  local message="$1"

  bl64_msg_verbose_app_enabled || return 0

  _bl64_msg_show "$_BL64_MSG_TXT_INFO" "$message"
}

#######################################
# Display task message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_task() {
  local message="$1"

  bl64_msg_verbose_app_enabled || return 0

  _bl64_msg_show "$_BL64_MSG_TXT_TASK" "$message"
}

#######################################
# Display task message for bash64lib functions
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_lib_task() {
  local message="$1"

  bl64_msg_verbose_lib_enabled || return 0

  _bl64_msg_show "$_BL64_MSG_TXT_TASK" "$message"
}

#######################################
# Display debug message
#
# Arguments:formatting
#   $1: message
# Outputs:
#   STDOUT: None
#   STDERR: messageformatting
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_debug() {
  local message="$1"

  _bl64_msg_show "$_BL64_MSG_TXT_DEBUG" "$message" >&2
}

#######################################
# Display message. Plain output, no extra info.
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_text() {
  local message="$1"

  bl64_msg_verbose_app_enabled || return 0

  printf '%s\n' "$message"
}

#######################################
# Display batch process start message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_batch_start() {
  local message="$1"

  bl64_msg_verbose_app_enabled || return 0

  _bl64_msg_show "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_START}"
}

#######################################
# Display batch process complete message
#
# Arguments:
#   $1: process exit status
#   $2: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_batch_finish() {
  local status="$1"
  local message="${2-${BL64_LIB_DEFAULT}}"

  bl64_msg_verbose_app_enabled || return 0

  if ((status == 0)); then
    _bl64_msg_show "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_FINISH_OK}"
  else
    _bl64_msg_show "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_FINISH_ERROR}: exit-status-${status}"
  fi
}
