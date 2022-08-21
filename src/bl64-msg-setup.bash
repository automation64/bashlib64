#######################################
# BashLib64 / Module / Setup / Display messages
#
# Version: 2.3.0
#######################################

#
# Verbosity control
#

function bl64_msg_app_verbose_enabled { [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_APP" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]; }
function bl64_msg_lib_verbose_enabled { [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_LIB" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]; }

function bl64_msg_all_disable_verbose { BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_NONE"; }
function bl64_msg_all_enable_verbose { BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_ALL"; }
function bl64_msg_lib_enable_verbose { BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_LIB"; }
function bl64_msg_app_enable_verbose { BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_APP"; }

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
  bl64_dbg_lib_show_function

  # Set default verbosity
  bl64_msg_app_enable_verbose

  bl64_msg_set_output "$BL64_MSG_OUTPUT_ANSI"

  BL64_MSG_MODULE="$BL64_LIB_VAR_ON"
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
  local level="$1"

  bl64_check_parameter 'level' || return $?

  case "$level" in
  "$BL64_MSG_VERBOSE_NONE") bl64_msg_all_disable_verbose ;;
  "$BL64_MSG_VERBOSE_APP") bl64_msg_app_enable_verbose ;;
  "$BL64_MSG_VERBOSE_LIB") bl64_msg_lib_enable_verbose ;;
  "$BL64_MSG_VERBOSE_ALL") bl64_msg_all_enable_verbose ;;
  *) bl64_check_alert_parameter_invalid ;;
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
  local format="$1"

  bl64_check_parameter 'format' || return $?

  case "$format" in
  "$BL64_MSG_FORMAT_PLAIN") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_PLAIN" ;;
  "$BL64_MSG_FORMAT_HOST") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_HOST" ;;
  "$BL64_MSG_FORMAT_TIME") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_TIME" ;;
  "$BL64_MSG_FORMAT_CALLER") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_CALLER" ;;
  "$BL64_MSG_FORMAT_FULL") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_FULL" ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# Set message display theme
#
# Arguments:
#   $1: theme name. One of BL64_MSG_THEME_* (variable name, not value)
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_theme() {
  local theme="$1"

  bl64_check_parameter 'theme' || return $?

  case "$theme" in
  'BL64_MSG_THEME_ASCII_STD') BL64_MSG_THEME='BL64_MSG_THEME_ASCII_STD' ;;
  'BL64_MSG_THEME_ANSI_STD') BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD' ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# Set message output type
#
# Arguments:
#   $1: output type. One of BL64_MSG_OUTPUT_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_output() {
  local output="$1"
  bl64_check_parameter 'output' || return $?

  case "$output" in
  "$BL64_MSG_OUTPUT_ASCII")
    BL64_MSG_OUTPUT="$output"
    BL64_MSG_THEME='BL64_MSG_THEME_ASCII_STD'
    ;;
  "$BL64_MSG_OUTPUT_ANSI")
    BL64_MSG_OUTPUT="$output"
    BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'
    ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}
