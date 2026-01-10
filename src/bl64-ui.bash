#######################################
# BashLib64 / Module / Functions / User Interface
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_ui_confirmation_ask() {
  bl64_msg_show_deprecated 'bl64_ui_confirmation_ask' 'bl64_ui_ask_confirmation'
  bl64_ui_ask_confirmation "$@"
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
  local question="${1:-please type in the confirmation message to proceed}"
  local confirmation="${2:-confirm}"
  local input=''

  bl64_msg_show_input "${question} [${confirmation}]: "
  read -r -t "$BL64_UI_CONFIRMATION_TIMEOUT" input

  input="${input#"${input%%[![:space:]]*}"}"
  input="${input%"${input##*[![:space:]]}"}"
  [[ "$input" == "$confirmation" ]] && return 0

  bl64_msg_show_warning 'Confirmation verification failed. The operation will be cancelled.'
  return "$BL64_LIB_ERROR_PARAMETER_INVALID"
}

#######################################
# Ask configuration to proceed, in a yes/no format
#
# Arguments:
#   $1: question to ask
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: user answered yes
#   1: user answered no
#######################################
function bl64_ui_ask_proceed() {
  local question="${1:-Do you want to proceed?}"
  local input=''

  while true; do
    bl64_msg_show_input "${question} [y/n]: "
    read -r input
    case "$input" in
    [Yy]*) return 0 ;;
    [Nn]*) bl64_msg_show_warning 'User requested not to proceed. No further action will be taken.' && return 1 ;;
    *) bl64_msg_show_lib_error "Invalid input. Please answer y or n." ;;
    esac
  done
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

#######################################
# Ask a yes/no question
#
# Arguments:
#   $1: question to ask
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: user answered yes
#   1: user answered no
#######################################
function bl64_ui_ask_yesno() {
  local question="${1:-are you sure?}"
  local input=''

  while true; do
    bl64_msg_show_input "${question} [y/n]: "
    read -r input
    case "$input" in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) bl64_msg_show_lib_error "Invalid input. Please answer y or n." ;;
    esac
  done
}

#######################################
# Ask for general input (any type)
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: success
#######################################
function bl64_ui_ask_input_free() {
  local prompt="${1:-enter input:}"
  local input=''

  bl64_msg_show_input "${prompt} "
  read -r input
  echo "$input"
}

#######################################
# Ask for integer input
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid integer
#   1: invalid input
#######################################
function bl64_ui_ask_input_integer() {
  local prompt="${1:-enter an integer:}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^-?[0-9]+$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid integer."
    fi
  done
}

#######################################
# Ask for float input
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid float
#   1: invalid input
#######################################
function bl64_ui_ask_input_decimal() {
  local prompt="${1:-enter a float (e.g., 9.9):}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid decimal."
    fi
  done
}

#######################################
# Ask for string input
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid string
#######################################
function bl64_ui_ask_input_string() {
  local prompt="${1:-enter a string:}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ -n "$input" ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a non-empty string."
    fi
  done
}

#######################################
# Ask for semantic version input
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid semantic version
#   1: invalid input
#######################################
function bl64_ui_ask_input_semver() {
  local prompt="${1:-enter a semantic version (e.g., 1.0.0):}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid semantic version (e.g., 1.0.0)."
    fi
  done
}

#######################################
# Ask for time input (HH:MM format)
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid time
#   1: invalid input
#######################################
function bl64_ui_ask_input_time() {
  local prompt="${1:-enter time (HH:MM):}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^([01]?[0-9]|2[0-3]):[0-5][0-9]$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid time (HH:MM)."
    fi
  done
}

#######################################
# Ask for date input (DD-MM-YYYY format)
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid date
#   1: invalid input
#######################################
function bl64_ui_ask_input_date() {
  local prompt="${1:-enter date (DD-MM-YYYY):}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[0-2])-[0-9]{4}$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid date (DD-MM-YYYY)."
    fi
  done
}
