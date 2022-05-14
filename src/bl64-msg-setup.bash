#######################################
# BashLib64 / Module / Setup / Display messages
#
# Version: 1.1.0
#######################################

#######################################
# Setup the message library
#
# Arguments:
#   $1: define message format. One of BL64_MSG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function bl64_msg_setup() {
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
    return $BL64_LIB_ERROR_MODULE_SETUP_INVALID
  fi

  BL64_MSG_FORMAT="$format"
}
