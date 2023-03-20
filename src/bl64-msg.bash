#######################################
# BashLib64 / Module / Functions / Display messages
#
# Version: 3.5.0
#######################################

#######################################
# Display message helper
#
# Arguments:
#   $1: stetic attribute
#   $2: type of message
#   $2: message to show
# Outputs:
#   STDOUT: message
#   STDERR: message when type is error or warning
# Returns:
#   printf exit status
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function _bl64_msg_show() {
  bl64_dbg_lib_show_function "@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"

  [[ -n "$attribute" && -n "$type" && -n "$message" ]] || return $BL64_LIB_ERROR_PARAMETER_MISSING

  case "$BL64_MSG_OUTPUT" in
  "$BL64_MSG_OUTPUT_ASCII") _bl64_msg_show_ascii "$attribute" "$type" "$message" ;;
  "$BL64_MSG_OUTPUT_ANSI") _bl64_msg_show_ansi "$attribute" "$type" "$message" ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

function _bl64_msg_show_ansi() {
  bl64_dbg_lib_show_function "@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local style=''
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'

  [[ -n "$attribute" && -n "$type" && -n "$message" ]] || return $BL64_LIB_ERROR_PARAMETER_MISSING
  style="${BL64_MSG_THEME}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  case "$BL64_MSG_FORMAT" in
  "$BL64_MSG_FORMAT_PLAIN")
    printf "%b: %s${linefeed}" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_HOST")
    printf "[%b] %b: %s${linefeed}" \
      "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_TIME")
    printf "[%b] %b: %s${linefeed}" \
      "\e[${!style_fmttime}m$(printf '%(%d/%b/%Y-%H:%M:%S-UTC%z)T' '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_CALLER")
    printf "[%b] %b: %s${linefeed}" \
      "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_FULL")
    printf "[%b] %b:%b | %b: %s${linefeed}" \
      "\e[${!style_fmttime}m$(printf '%(%d/%b/%Y-%H:%M:%S-UTC%z)T' '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

function _bl64_msg_show_ascii() {
  bl64_dbg_lib_show_function "@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local style=''
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'

  [[ -n "$attribute" && -n "$type" && -n "$message" ]] || return $BL64_LIB_ERROR_PARAMETER_MISSING
  style="${BL64_MSG_THEME}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  case "$BL64_MSG_FORMAT" in
  "$BL64_MSG_FORMAT_PLAIN")
    printf "%s: %s${linefeed}" \
      "${!style} $type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_HOST")
    printf "[%s] %s: %s${linefeed}" \
      "${HOSTNAME}" \
      "${!style} $type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_TIME")
    printf "[%(%d/%b/%Y-%H:%M:%S-UTC%z)T] %s: %s${linefeed}" \
      '-1' \
      "${!style} $type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_CALLER")
    printf "[%s] %s: %s${linefeed}" \
      "$BL64_SCRIPT_ID" \
      "${!style} $type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_FULL")
    printf "[%(%d/%b/%Y-%H:%M:%S-UTC%z)T] %s:%s | %s: %s${linefeed}" \
      '-1' \
      "$HOSTNAME" \
      "$BL64_SCRIPT_ID" \
      "${!style} $type" \
      "$message"
    ;;
  *) bl64_check_alert_parameter_invalid ;;
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
  bl64_dbg_lib_show_function "@"
  local usage="${1:-${BL64_VAR_NULL}}"
  local description="${2:-${BL64_VAR_DEFAULT}}"
  local commands="${3:-${BL64_VAR_DEFAULT}}"
  local flags="${4:-${BL64_VAR_DEFAULT}}"
  local parameters="${5:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'usage' || return $?

  printf '\n%s: %s %s\n\n' "$_BL64_MSG_TXT_USAGE" "$BL64_SCRIPT_ID" "$usage"

  if [[ "$description" != "$BL64_VAR_DEFAULT" ]]; then
    printf '%s\n\n' "$description"
  fi

  if [[ "$commands" != "$BL64_VAR_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_COMMANDS" "$commands"
  fi

  if [[ "$flags" != "$BL64_VAR_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_FLAGS" "$flags"
  fi

  if [[ "$parameters" != "$BL64_VAR_DEFAULT" ]]; then
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
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_show "$BL64_MSG_TYPE_ERROR" "$_BL64_MSG_TXT_ERROR" "$message" >&2
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
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_warning "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_show "$BL64_MSG_TYPE_WARNING" "$_BL64_MSG_TXT_WARNING" "$message" >&2
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
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_INFO" "$_BL64_MSG_TXT_INFO" "$message"
}

#######################################
# Display phase message
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
function bl64_msg_show_phase() {
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_PHASE}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_PHASE" "$_BL64_MSG_TXT_PHASE" "${BL64_MSG_COSMETIC_PHASE_PREFIX} ${message} ${BL64_MSG_COSMETIC_PHASE_SUFIX}"
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
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_TASK}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_TASK" "$_BL64_MSG_TXT_TASK" "$message"
}

#######################################
# Display subtask message
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
function bl64_msg_show_subtask() {
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_SUBTASK}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_SUBTASK" "$_BL64_MSG_TXT_SUBTASK" "${BL64_MSG_COSMETIC_ARROW2} ${message}"
}

#######################################
# Display task message for bash64lib functions
bl64_dbg_lib_show_function "@"
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
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBTASK}:${message}" &&
    bl64_msg_lib_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_LIBTASK" "$_BL64_MSG_TXT_TASK" "$message"
}

#######################################
# Display info message for bash64lib functions
bl64_dbg_lib_show_function "@"
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
function bl64_msg_show_lib_info() {
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBINFO}:${message}" &&
    bl64_msg_lib_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_LIBINFO" "$_BL64_MSG_TXT_INFO" "$message"
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
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_enabled || return 0

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
  bl64_dbg_lib_show_function "@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_BATCH}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_BATCH" "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_START}"
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
  bl64_dbg_lib_show_function "@"
  local status="$1"
  local message="${2-${BL64_VAR_DEFAULT}}"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_BATCH}:${status}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  if ((status == 0)); then
    _bl64_msg_show "$BL64_MSG_TYPE_BATCHOK" "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_FINISH_OK}"
  else
    _bl64_msg_show "$BL64_MSG_TYPE_BATCHERR" "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_FINISH_ERROR}: exit-status-${status}"
  fi
}

#######################################
# Display user input message
#
# * Used exclusively by the io module to show messages for user input from stdin
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
function bl64_msg_show_input() {
  bl64_dbg_lib_show_function "@"
  local message="$1"

  _bl64_msg_show "$BL64_MSG_TYPE_INPUT" "$_BL64_MSG_TXT_INPUT" "$message"
}
