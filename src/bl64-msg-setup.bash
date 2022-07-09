#######################################
# BashLib64 / Module / Setup / Display messages
#
# Version: 2.0.0
#######################################

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
function bl64_msg_setup_format() {
  local format="$1"

  bl64_check_parameter 'format' || return $?

  # shellcheck disable=SC2086
  if [[ 
    "$format" != "$BL64_MSG_FORMAT_PLAIN" &&
    "$format" != "$BL64_MSG_FORMAT_HOST" &&
    "$format" != "$BL64_MSG_FORMAT_TIME" &&
    "$format" != "$BL64_MSG_FORMAT_CALLER" &&
    "$format" != "$BL64_MSG_FORMAT_FULL" ]] \
    ; then
    bl64_msg_show_error "$_BL64_MSG_TXT_INVALID_FORMAT"
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  fi

  BL64_MSG_FORMAT="$format"
}

#######################################
# Set message display theme
#
# Arguments:
#   $1: theme name. One of BL64_MSG_THEME_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_setup_theme() {
  local theme="$1"

  bl64_check_parameter 'theme' || return $?

  if [[
    "$theme" != 'BL64_MSG_THEME_ASCII_STD' &&
    "$theme" != 'BL64_MSG_THEME_ANSI_STD' ]] \
    ; then
    bl64_msg_show_error "$_BL64_MSG_TXT_INVALID_THEME"
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  fi

  BL64_MSG_THEME="$theme"

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
function bl64_msg_setup_output() {

  local output="$1"
  bl64_check_parameter 'output' || return $?

  case "$output" in
  "$BL64_MSG_OUTPUT_ASCII")
    BL64_MSG_OUTPUT="$output"
    declare -g -n BL64_MSG_THEME='BL64_MSG_THEME_ASCII_STD'
    ;;
  "$BL64_MSG_OUTPUT_ANSI")
    BL64_MSG_OUTPUT="$output"
    declare -g -n BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'
    ;;
  *)
    bl64_msg_show_error "$_BL64_MSG_TXT_INVALID_OUTPUT"
    return $BL64_LIB_ERROR_PARAMETER_INVALID
    ;;
  esac

}
