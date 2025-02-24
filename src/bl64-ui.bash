#######################################
# BashLib64 / Module / Functions / User Interface
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_ui_ask_confirmation() {
  bl64_msg_show_deprecated 'bl64_ui_ask_confirmation' 'bl64_ui_confirmation_ask'
  bl64_ui_confirmation_ask "$@"
}

#
# Private functions
#

#
# Public functions
#

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
function bl64_ui_confirmation_ask() {
  bl64_dbg_lib_show_function "$@"
  local question="${1:-Please type in the confirmation message to proceed}"
  local confirmation="${2:-confirm-operation}"
  local input=''

  bl64_msg_show_input "${question} [${confirmation}]: "
  read -r -t "$BL64_UI_CONFIRMATION_TIMEOUT" input

  if [[ "$input" != "$confirmation" ]]; then
    bl64_msg_show_error 'confirmation verification failed'
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  fi

  return 0
}

#######################################
# Build a separator line with optional payload
#
# * Separator format: payload + \n
#
# Arguments:
#   $1: Separator payload. Format: string
# Outputs:
#   STDOUT: separator line
#   STDERR: grep Error message
# Returns:
#   printf exit status
#######################################
function bl64_ui_separator_show() {
  bl64_dbg_lib_show_function "$@"
  local payload="${1:-}"

  printf '%s\n' "$payload"
}
