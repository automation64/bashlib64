#######################################
# BashLib64 / Module / Functions / User Interface
#######################################

#######################################
# Ask for confirmation
#
# * Use to confirm dangerous operations
#
# Arguments:
#   $1: confirmation question
#   $2: confirmation value that needs to be match
# Outputs:
#   STDOUT: user interaction
#   STDERR: command stderr
# Returns:
#   0: confirmed
#   >0: not confirmed
#######################################
function bl64_ui_ask_confirmation() {
  bl64_dbg_lib_show_function "$@"
  local question="${1:-Please type in the confirmation message to proceed}"
  local confirmation="${2:-confirm-operation}"
  local input=''

  bl64_msg_show_input "${question} [${confirmation}]: "
  read -r -t "$BL64_UI_READ_TIMEOUT" input

  if [[ "$input" != "$confirmation" ]]; then
    bl64_msg_show_error 'confirmation verification failed'
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  fi

  return 0
}
