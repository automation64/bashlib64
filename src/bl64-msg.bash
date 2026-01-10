#######################################
# BashLib64 / Module / Functions / Display messages
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_msg_app_verbose_enabled {
  bl64_msg_show_deprecated 'bl64_msg_app_verbose_enabled' 'bl64_msg_app_verbose_is_enabled'
  bl64_msg_app_verbose_is_enabled
}
function bl64_msg_lib_verbose_enabled {
  bl64_msg_show_deprecated 'bl64_msg_lib_verbose_enabled' 'bl64_msg_app_detail_is_enabled'
  bl64_msg_app_detail_is_enabled
}
function bl64_msg_lib_enable_verbose {
  bl64_msg_show_deprecated 'bl64_msg_lib_enable_verbose' 'bl64_msg_app_enable_detail'
  bl64_msg_app_enable_detail
}
function bl64_msg_lib_verbose_is_enabled {
  bl64_msg_show_deprecated 'bl64_msg_lib_verbose_is_enabled' 'bl64_msg_app_detail_is_enabled'
  bl64_msg_app_detail_is_enabled
}
function bl64_msg_show_usage() {
  bl64_msg_show_deprecated 'bl64_msg_show_usage' 'bl64_msg_help_show'
  local usage="${1:-${BL64_VAR_NULL}}"
  local description="${2:-${BL64_VAR_DEFAULT}}"
  local commands="${3:-}"
  local flags="${4:-}"
  local parameters="${5:-}"

  bl64_msg_help_usage_set "$usage"
  bl64_msg_help_description_set "$description"
  bl64_msg_help_parameters_set \
    "${commands}
${flags}
${parameters}"
  bl64_msg_help_show
}

#
# Internal functions
#

function _bl64_msg_module_check_setup() {
  local module="${1:-}"
  local setup_status=''
  [[ -z "$module" ]] && return "$BL64_LIB_ERROR_PARAMETER_MISSING"
  _bl64_lib_module_is_imported "$module" || return $?

  setup_status="${!module}"
  if [[ "$setup_status" == "$BL64_VAR_OFF" ]]; then
    printf 'Error: required BashLib64 module is not setup. Call the bl64_<MODULE>_setup function before using the module (module-id: %s | function: %s)\n' \
      "${module}" \
      "${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NA}.${FUNCNAME[2]:-NONE}@${BASH_LINENO[2]:-NA}" \
      >&2
    return "$BL64_LIB_ERROR_MODULE_SETUP_MISSING"
  fi
  return 0
}

function _bl64_msg_alert_show_parameter() {
  local parameter="${1:-${BL64_VAR_DEFAULT}}"
  local message="${2:-${BL64_VAR_DEFAULT}}"
  local value="${3:-${BL64_VAR_DEFAULT}}"

  bl64_lib_var_is_default "$parameter" && parameter=''
  bl64_lib_var_is_default "$message" && message='Error: the requested operation was provided with an invalid parameter value'
  bl64_lib_var_is_default "$value" && value=''
  printf '%s (%s%scaller: %s)\n' \
    "$message" \
    "${parameter:+parameter: ${parameter} | }" \
    "${value:+value: ${value} | }" \
    "${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NA}.${FUNCNAME[2]:-NONE}@${BASH_LINENO[2]:-NA}" \
    >&2
  return "$BL64_LIB_ERROR_PARAMETER_INVALID"
}

#######################################
# Display message helper
#
# Arguments:
#   $1: style attribute
#   $2: type of message
#   $3: message to show
# Outputs:
#   STDOUT: message
#   STDERR: message when type is error or warning
# Returns:
#   printf exit status
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function _bl64_msg_print() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"

  _bl64_msg_module_check_setup 'BL64_MSG_MODULE' || return $?
  [[ -n "$attribute" && -n "$type" ]] || return "$BL64_LIB_ERROR_PARAMETER_MISSING"

  case "$BL64_MSG_OUTPUT" in
    "$BL64_MSG_OUTPUT_ASCII") _bl64_msg_format_ascii "$attribute" "$type" "$message" ;;
    "$BL64_MSG_OUTPUT_ANSI") _bl64_msg_format_ansi "$attribute" "$type" "$message" ;;
    "$BL64_MSG_OUTPUT_EMOJI") _bl64_msg_format_emoji "$attribute" "$type" "$message" ;;
    *) _bl64_msg_alert_show_parameter 'BL64_MSG_OUTPUT' "$BL64_VAR_DEFAULT" "$BL64_MSG_OUTPUT" ;;
  esac
}

function _bl64_msg_format_ansi() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local style=''
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'

  style="${BL64_MSG_THEME}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  # shellcheck disable=SC2059
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
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME2")
      printf "%b %b: %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_CALLER")
      printf "[%b] %b: %s${linefeed}" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT")
      printf "[%b] %b | %b: %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT2")
      printf "%b|%b|%b| %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL")
      printf "[%b] %b:%b | %b: %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL2")
      printf "%b|%b|%b|%b| %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    *) _bl64_msg_alert_show_parameter 'BL64_MSG_FORMAT' "$BL64_VAR_DEFAULT" "$BL64_MSG_FORMAT" ;;
  esac
}

function _bl64_msg_format_ascii() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local label=''
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'

  label="BL64_MSG_LABEL_${BL64_MSG_LABEL}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  # shellcheck disable=SC2059
  case "$BL64_MSG_FORMAT" in
    "$BL64_MSG_FORMAT_PLAIN")
      printf "%s %s${linefeed}" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_HOST")
      printf "[%s] %s %s${linefeed}" \
        "${HOSTNAME}" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME")
      printf "[${BL64_MSG_TIME_DMY_HMS_FULL}] %s %s${linefeed}" \
        '-1' \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME2")
      printf "${BL64_MSG_TIME_DMY_HMS_COMPACT} %s %s${linefeed}" \
        '-1' \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_CALLER")
      printf "[%s] %s %s${linefeed}" \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT")
      printf "[${BL64_MSG_TIME_DMY_HMS_FULL}] %s %s %s${linefeed}" \
        '-1' \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT2")
      printf "${BL64_MSG_TIME_DMY_HMS_COMPACT}|%s %s %s${linefeed}" \
        '-1' \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL")
      printf "[${BL64_MSG_TIME_DMY_HMS_FULL}] %s:%s %s %s${linefeed}" \
        '-1' \
        "$HOSTNAME" \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL2")
      printf "${BL64_MSG_TIME_DMY_HMS_COMPACT}|%s|%s %s %s${linefeed}" \
        '-1' \
        "$HOSTNAME" \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    *) _bl64_msg_alert_show_parameter 'BL64_MSG_FORMAT' "$BL64_VAR_DEFAULT" "$BL64_MSG_FORMAT" ;;
  esac
}

function _bl64_msg_format_emoji() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'
  local label=''

  label="BL64_MSG_LABEL_${BL64_MSG_LABEL}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  # shellcheck disable=SC2059
  case "$BL64_MSG_FORMAT" in
    "$BL64_MSG_FORMAT_PLAIN")
      printf "%b %s${linefeed}" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_HOST")
      printf "[%b] %b %s${linefeed}" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME")
      printf "[%b] %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME2")
      printf "%b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_CALLER")
      printf "[%b] %b %s${linefeed}" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT")
      printf "[%b] %b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT2")
      printf "%b|%b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL")
      printf "[%b] %b:%b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL2")
      printf "%b|%b|%b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    *) _bl64_msg_alert_show_parameter 'BL64_MSG_FORMAT' "$BL64_VAR_DEFAULT" "$BL64_MSG_FORMAT" ;;
  esac
}

#
# Public functions
#

#######################################
# Display check error message
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
function bl64_msg_show_check() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[2]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Error  ' "$message [task: ${FUNCNAME[2]:-main}@${BASH_LINENO[2]:-NA}.${FUNCNAME[3]:-main}@${BASH_LINENO[3]:-NA}]" >&2
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Error  ' "$message" >&2
}

#######################################
# Display application function error message
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
function bl64_msg_show_app_error() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Error  ' "$message [task: ${FUNCNAME[2]:-main}.${FUNCNAME[3]:-main}]" >&2
}

#######################################
# Display bashlib64 function error message
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
function bl64_msg_show_lib_error() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Error  ' "$message [task: ${FUNCNAME[2]:-main}.${FUNCNAME[3]:-main}]" >&2
}

#######################################
# Display fatal error message
#
# * Use before halting the script with exit
# Arguments:
#   $1: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_fatal() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Fatal  ' "$message" >&2
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_warning "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_WARNING" 'Warning' "$message" >&2
}

#######################################
# Display script initialization message
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
function bl64_msg_show_init() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_INIT" 'Init   ' "$message"
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_detail_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_INFO" 'Info   ' "$message"
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_PHASE}:${message}" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_PHASE" 'Phase  ' "${BL64_MSG_COSMETIC_PHASE_PREFIX2}  ${message}  ${BL64_MSG_COSMETIC_PHASE_SUFIX2}"
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_TASK}:${message}" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_TASK" 'Task   ' "$message"
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_SUBTASK}:${message}" &&
    bl64_msg_app_detail_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_SUBTASK" 'Subtask' "${BL64_MSG_COSMETIC_ARROW2} ${message}"
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBTASK}:${message}" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_LIBTASK" 'Task   ' "$message"
}

#######################################
# Display subtask message for bash64lib functions
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
function bl64_msg_show_lib_subtask() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBSUBTASK}:${message}" &&
    bl64_msg_app_detail_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_LIBSUBTASK" 'Subtask' "${BL64_MSG_COSMETIC_ARROW2} ${message}"
}

#######################################
# Display info message for bash64lib functions
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBINFO}:${message}" &&
    bl64_msg_app_detail_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_LIBINFO" 'Info   ' "$message"
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_is_enabled || return 0

  printf '%s\n' "$message"
}

#######################################
# Display batch process start message
#
# * Use in the main section of task oriented scripts to show start/end of batch process
#
# Arguments:
#   $2: batch short description
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_batch_start() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="${1:-$BL64_SCRIPT_ID}"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_BATCH}:${message}" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_BATCH" 'Process' "[${message}] started"
}

#######################################
# Display batch process complete message
#
# * Use in the main section of task oriented scripts to show start/end of batch process
# * Can be used as last command in shell script to both show result and return exit status
#
# Arguments:
#   $1: process exit status.
#   $2: batch short description. Default: BL64_SCRIPT_ID
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_batch_finish() {
  local -i status=$1
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="${2:-$BL64_SCRIPT_ID}"

  # shellcheck disable=SC2086
  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_BATCH}:${status}:${message}" &&
    bl64_msg_app_verbose_is_enabled ||
    return "$status"

  if ((status == 0)); then
    _bl64_msg_print "$BL64_MSG_TYPE_BATCHOK" 'Process' "[${message}] finished successfully"
  else
    _bl64_msg_print "$BL64_MSG_TYPE_BATCHERR" 'Process' "[${message}] finished with errors: exit-status-${status}"
  fi
  # shellcheck disable=SC2086
  return "$status"
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
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  _bl64_msg_print "$BL64_MSG_TYPE_INPUT" 'Input  ' "$message"
}

#######################################
# Show separator line
#
# Arguments:
#   $1: Prefix string. Default: none
#   $2: character used to build the line. Default: =
#   $3: separator length (without prefix). Default: 60
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_separator() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="${1:-$BL64_VAR_DEFAULT}"
  local separator="${2:-$BL64_VAR_DEFAULT}"
  local length="${3:-$BL64_VAR_DEFAULT}"
  local -i counter=0
  local output=''

  bl64_lib_var_is_default "$message" && message=''
  bl64_lib_var_is_default "$separator" && separator='='
  bl64_lib_var_is_default "$length" && length=60

  output="$(
    while true; do
      counter=$((counter + 1))
      printf '%c' "$separator"
      ((counter == length)) && break
    done
  )"

  _bl64_msg_print "$BL64_MSG_TYPE_SEPARATOR" '>>>>>>>' "${separator}${separator}[ ${message} ]${output}"
}

#######################################
# Display deprecation message
#
# Arguments:
#   $1: function_name
#   $2: function_replacement
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_deprecated() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local function_name="${1:-}"
  local function_replacement="${2:-non-available}"

  bl64_log_warning "${FUNCNAME[1]:-MAIN}" "legacy: ${function_name}" &&
    _bl64_msg_print "$BL64_MSG_TYPE_WARNING" 'Legacy ' "Function to be removed from future versions. Please upgrade. (${function_name} :replace-with: ${function_replacement})" >&2
}

#######################################
# Display setup information
#
# * Skip empty variables
#
# Arguments:
#   $1: (optional) message
#   $@: variable names
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_setup() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="${1:-$BL64_VAR_DEFAULT}"
  local variable=''

  bl64_msg_app_detail_is_enabled || return 0
  bl64_lib_var_is_default "$message" && message='Executing task with the following parameters'
  shift

  bl64_msg_show_info "$message"
  for variable in "$@"; do
    [[ -z "${!variable:-}" || ! -v "$variable" ]] && continue
    bl64_msg_show_info "${BL64_MSG_COSMETIC_TAB2}${variable}=${!variable}"
  done
}

#######################################
# Show help message
#
# Arguments:
#   NONE
# Outputs:
#   STDOUT: help message
#   STDERR: NONE
# Returns:
#   0: Always OK
#######################################
function bl64_msg_help_show() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  local current_format="$BL64_MSG_FORMAT"

  bl64_msg_set_format "$BL64_MSG_FORMAT_PLAIN"

  _bl64_msg_show_script
  if [[ "$BL64_MSG_HELP_USAGE" != "$BL64_VAR_DEFAULT" ]]; then
    _bl64_msg_print "$BL64_MSG_TYPE_HELP" 'Usage  ' "${BL64_SCRIPT_ID} ${BL64_MSG_HELP_USAGE}"
  fi

  _bl64_msg_show_about

  if [[ "$BL64_MSG_HELP_DESCRIPTION" != "$BL64_VAR_DEFAULT" ]]; then
    printf '\n%s\n' "$BL64_MSG_HELP_DESCRIPTION"
  fi

  if [[ "$BL64_MSG_HELP_PARAMETERS" != "$BL64_VAR_DEFAULT" ]]; then
    printf '\n%s\n' "$BL64_MSG_HELP_PARAMETERS"
  fi
  bl64_msg_set_format "$current_format"
  return 0
}

#######################################
# Display about the script message
#
# * bl64_msg_help_about_set must be run before
#
# Arguments:
#   None
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: Always ok
#######################################
function bl64_msg_show_about() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  bl64_msg_app_verbose_is_enabled || return 0
  _bl64_msg_show_script &&
    _bl64_msg_show_about
}

function _bl64_msg_show_script() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  _bl64_msg_print "$BL64_MSG_TYPE_HELP" 'Script ' "${BL64_SCRIPT_ID} v${BL64_SCRIPT_VERSION}"
}

function _bl64_msg_show_about() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  if [[ "$BL64_MSG_HELP_ABOUT" != "$BL64_VAR_DEFAULT" ]]; then
    _bl64_msg_print "$BL64_MSG_TYPE_HELP" 'About  ' "$BL64_MSG_HELP_ABOUT"
  fi
}
