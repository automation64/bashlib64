#######################################
# BashLib64 / Module / Setup / Display messages
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_msg_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_LOG_MODULE' &&
    bl64_msg_set_output "$BL64_VAR_DEFAULT" &&
    bl64_msg_app_enable_verbose &&
    BL64_MSG_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'msg'
}

#######################################
# Set verbosity level
#
# Arguments:
#   $1: target level. One of BL64_MSG_VERBOSE_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_msg_set_level() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local level="$1"

  bl64_check_parameter 'level' || return $?

  case "$level" in
    "$BL64_MSG_VERBOSE_NONE") bl64_msg_all_disable_verbose ;;
    "$BL64_MSG_VERBOSE_APP") bl64_msg_app_enable_verbose ;;
    "$BL64_MSG_VERBOSE_DETAIL") bl64_msg_app_enable_detail ;;
    "$BL64_MSG_VERBOSE_LIB") bl64_msg_app_detail_is_enabled ;;
    "$BL64_MSG_VERBOSE_ALL") bl64_msg_all_enable_verbose ;;
    *)
      bl64_check_alert_parameter_invalid 'BL64_MSG_VERBOSE' \
        "invalid value. Not one of: ${BL64_MSG_VERBOSE_NONE}|${BL64_MSG_VERBOSE_ALL}|${BL64_MSG_VERBOSE_APP}|${BL64_MSG_VERBOSE_DETAIL}|${BL64_MSG_VERBOSE_LIB}"
      return $?
      ;;
  esac
}

#######################################
# Set message format
#
# Arguments:
#   $1: format. One of BL64_MSG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_format() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local format="$1"
  local legacy_BL64_MSG_FORMAT_PLAIN='R'
  local legacy_BL64_MSG_FORMAT_HOST='H'
  local legacy_BL64_MSG_FORMAT_TIME='T'
  local legacy_BL64_MSG_FORMAT_CALLER='C'
  local legacy_BL64_MSG_FORMAT_FULL='F'

  bl64_check_parameter 'format' || return $?

  case "$format" in
    "$BL64_MSG_FORMAT_PLAIN" | "$legacy_BL64_MSG_FORMAT_PLAIN") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_PLAIN" ;;
    "$BL64_MSG_FORMAT_HOST" | "$legacy_BL64_MSG_FORMAT_HOST") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_HOST" ;;
    "$BL64_MSG_FORMAT_TIME" | "$legacy_BL64_MSG_FORMAT_TIME") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_TIME" ;;
    "$BL64_MSG_FORMAT_CALLER" | "$legacy_BL64_MSG_FORMAT_CALLER") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_CALLER" ;;
    "$BL64_MSG_FORMAT_FULL" | "$legacy_BL64_MSG_FORMAT_FULL") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_FULL" ;;
    "$BL64_MSG_FORMAT_TIME2" | "$BL64_MSG_FORMAT_FULL2" | "$BL64_MSG_FORMAT_SCRIPT" | "$BL64_MSG_FORMAT_SCRIPT2") BL64_MSG_FORMAT="$format" ;;
    *)
      bl64_check_alert_parameter_invalid 'BL64_MSG_FORMAT' 'invalid value. Not one of: BL64_MSG_FORMAT_*'
      return $?
      ;;
  esac
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_vars 'BL64_MSG_FORMAT'
  return 0
}

#######################################
# Set message display theme
#
# Arguments:
#   $1: theme name. One of BL64_MSG_THEME_ID_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_theme() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local theme="$1"

  bl64_check_parameter 'theme' || return $?

  case "$theme" in
    "$BL64_MSG_THEME_ID_ASCII_STD") BL64_MSG_THEME='BL64_MSG_THEME_ASCII_STD' ;;
    "$BL64_MSG_THEME_ID_ANSI_STD") BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD' ;;
    *)
      bl64_check_alert_parameter_invalid 'BL64_MSG_THEME' \
        "invalid value. Not one of: ${BL64_MSG_THEME_ID_ASCII_STD}|${BL64_MSG_THEME_ID_ANSI_STD}"
      return $?
      ;;
  esac
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_vars 'BL64_MSG_THEME'
  return 0
}

#######################################
# Set message output type
#
# * Will also setup the theme
# * If no theme is provided then the STD is used (ansi or ascii)
# * If no output is provided then the default is used.
# * Default output is ANSI if the script is interactive, otherwise ASCII
#
# Arguments:
#   $1: output type. One of BL64_MSG_OUTPUT_*. Default: BL64_MSG_OUTPUT_ANSI
#   $2: (optional) theme. Default: STD
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_output() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local output="${1:-}"
  local theme="${2:-${BL64_VAR_DEFAULT}}"
  local legacy_BL64_MSG_OUTPUT_ASCII='A'
  local legacy_BL64_MSG_OUTPUT_ANSI='N'

  if bl64_lib_var_is_default "$output"; then
    if bl64_lib_mode_cicd_is_enabled; then
      output="$BL64_MSG_OUTPUT_ASCII"
    else
      output="$BL64_MSG_OUTPUT_ANSI"
    fi
  else
    if bl64_lib_mode_cicd_is_enabled; then
      output="$BL64_MSG_OUTPUT_ASCII"
    fi
  fi

  case "$output" in
    "$BL64_MSG_OUTPUT_ASCII" | "$legacy_BL64_MSG_OUTPUT_ASCII")
      bl64_lib_var_is_default "$theme" && theme="$BL64_MSG_THEME_ID_ASCII_STD"
      BL64_MSG_LABEL="$output"
      BL64_MSG_OUTPUT="$output"
      ;;
    "$BL64_MSG_OUTPUT_ANSI" | "$legacy_BL64_MSG_OUTPUT_ANSI")
      bl64_lib_var_is_default "$theme" && theme="$BL64_MSG_THEME_ID_ANSI_STD"
      BL64_MSG_OUTPUT="$output"
      ;;
    "$BL64_MSG_OUTPUT_EMOJI")
      bl64_lib_var_is_default "$theme" && theme="$BL64_MSG_THEME_ID_ANSI_STD"
      BL64_MSG_LABEL="$output"
      BL64_MSG_OUTPUT="$output"
      ;;
    *)
      bl64_check_alert_parameter_invalid 'BL64_MSG_OUTPUT' \
        "invalid value. Not one of: ${BL64_MSG_OUTPUT_ASCII}|${BL64_MSG_OUTPUT_ANSI}|${BL64_MSG_OUTPUT_EMOJI}"
      return $?
      ;;
  esac
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_vars 'BL64_MSG_OUTPUT'
  bl64_msg_set_theme "$theme"
}

#
# Verbosity control
#

function bl64_msg_app_verbose_is_enabled {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_APP" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]
}

function bl64_msg_app_run_is_enabled {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  bl64_msg_app_detail_is_enabled && ! bl64_lib_mode_cicd_is_enabled
}

function bl64_msg_app_detail_is_enabled {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_LIB" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_DETAIL" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]
}

function bl64_msg_all_disable_verbose {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_NONE"
}

function bl64_msg_all_enable_verbose {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_ALL"
}

function bl64_msg_app_enable_verbose {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_APP"
}

function bl64_msg_app_enable_detail {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_DETAIL"
}

#
# Help attributes
#

function bl64_msg_help_usage_set() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local content="${1:-$BL64_VAR_DEFAULT}"
  BL64_MSG_HELP_USAGE="$content"
}

function bl64_msg_help_about_set() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local content="${1:-$BL64_VAR_DEFAULT}"
  BL64_MSG_HELP_ABOUT="$content"
}

function bl64_msg_help_description_set() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local content="${1:-$BL64_VAR_DEFAULT}"
  BL64_MSG_HELP_DESCRIPTION="$content"
}

function bl64_msg_help_parameters_set() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local content="${1:-$BL64_VAR_DEFAULT}"
  BL64_MSG_HELP_PARAMETERS="$content"
}
