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
  _bl64_lib_function_deprecated 'bl64_ui_confirmation_ask' 'bl64_ui_ask_confirmation'
  bl64_ui_ask_confirmation "$@"
}

#
# Private functions
#

function _bl64_ui_is_confirmation_disabled() {
  bl64_dbg_lib_show_function
  if bl64_lib_flag_is_enabled "$BL64_UI_CFG_SKIP_CONFIRMATION"; then
    bl64_msg_show_text '** warning - confirmation verification disabled. The operation will continue without interruption **'
    return 0
  fi
  if bl64_lib_mode_cicd_is_enabled; then
    bl64_msg_show_text '** warning - confirmation verification disabled because CICD mode is enabled. The operation will continue without interruption **'
    return 0
  fi
  return 1
}

function _bl64_ui_harden_fzf() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset FZF_DEFAULT_COMMAND
  unset FZF_DEFAULT_OPTS
  unset FZF_DEFAULT_OPTS_FILE
  unset FZF_API_KEY
  bl64_dbg_lib_trace_stop

  return 0
}

function _bl64_ui_harden_less() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset LESSANSIENDCHARS
  unset LESSANSIMIDCHARS
  unset LESSANSIOSCALLOW
  unset LESSANSIOSCCHARS
  unset LESSBINFMT
  unset LESSCHARDEF
  unset LESSCHARSET
  unset LESSCLOSE
  unset LESSECHO
  unset LESSEDIT
  unset LESSGLOBALTAGS
  unset LESSHISTFILE
  unset LESSHISTSIZE
  unset LESSKEYIN
  unset LESSKEY
  unset LESSKEY_CONTENT
  unset LESSKEYIN_SYSTEM
  unset LESSKEY_SYSTEM
  unset LESSMETACHARS
  unset LESSMETAESCAPE
  unset LESSNOCONFIG
  unset LESSOPEN
  unset LESSSECURE_ALLOW
  unset LESSSEPARATOR
  unset LESSUTFBINFMT
  unset LESSUTFCHARDEF
  unset LESS_COLUMNS
  unset LESS_LINES
  unset LESS_DATA_DELAY
  unset LESS_IS_MORE
  unset LESS_OSC8_OPEN_xxx
  unset LESS_OSC8_OPEN_ANY
  unset LESS_OSC8_OPEN_NONE
  unset LESS_SHELL_LINES
  unset LESS_SIGUSR1
  unset LESS_TERMCAP_xx
  unset LESS_TERMINFO_xxxx
  unset LESS_TERMCAP_BRACKETED_PASTE_START
  unset LESS_TERMCAP_BRACKETED_PASTE_END
  unset LESS_TERMCAP_MOUSE_START
  unset LESS_TERMCAP_MOUSE_END
  unset LESS_TERMCAP_SUSPEND
  unset LESS_TERMCAP_RESUME
  unset LESS_UNSUPPORT

  export LESSSECURE='1'
  bl64_dbg_lib_trace_stop

  return 0
}

function _bl64_ui_harden_bat() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset BAT_THEME
  unset BAT_THEME_DARK
  unset BAT_THEME_LIGHT
  unset BAT_STYLE
  unset BAT_CONFIG_PATH
  export BAT_PAGER='builtin'
  bl64_dbg_lib_trace_stop

  return 0
}

#
# Public functions
#

#######################################
# Ask for confirmation
#
# Arguments:
#   $1: confirmation question
#   $2: confirmation value that needs to be match
# Channels:
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
  _bl64_ui_is_confirmation_disabled && return 0

  read -r -t "$BL64_UI_CFG_INPUT_TIMEOUT" input

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
# Channels:
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
    _bl64_ui_is_confirmation_disabled && return 0
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
# Channels:
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
# Channels:
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
    _bl64_ui_is_confirmation_disabled && return 0
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
# Channels:
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
# Channels:
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
# Channels:
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
# Channels:
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
# Channels:
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
# Channels:
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
# Channels:
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

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Channels:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_ui_run_bat() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_UI_MOD_SETUP' &&
    bl64_check_command "$BL64_UI_CMD_BAT" "$BL64_VAR_DEFAULT" 'bat' ||
    return $?

  _bl64_ui_harden_bat
  bl64_dbg_lib_trace_start
  "$BL64_UI_CMD_BAT" \
    --no-config \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Channels:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_ui_run_dialog() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_UI_MOD_SETUP' &&
    bl64_check_command "$BL64_UI_CMD_DIALOG" "$BL64_VAR_DEFAULT" 'dialog' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_UI_CMD_DIALOG" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Channels:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_ui_run_fzf() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_UI_MOD_SETUP' &&
    bl64_check_command "$BL64_UI_CMD_FZF" "$BL64_VAR_DEFAULT" 'fzf' ||
    return $?

  _bl64_ui_harden_fzf

  bl64_dbg_lib_trace_start
  "$BL64_UI_CMD_FZF" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Channels:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_ui_run_whiptail() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_UI_MOD_SETUP' &&
    bl64_check_command "$BL64_UI_CMD_WHIPTAIL" "$BL64_VAR_DEFAULT" 'whiptail' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_UI_CMD_WHIPTAIL" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Channels:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_ui_run_gum() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_UI_MOD_SETUP' &&
    bl64_check_command "$BL64_UI_CMD_GUM" "$BL64_VAR_DEFAULT" 'gum' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_UI_CMD_GUM" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Channels:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_ui_run_less() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_UI_MOD_SETUP' &&
    bl64_check_command "$BL64_UI_CMD_LESS" "$BL64_VAR_DEFAULT" 'less' ||
    return $?

  _bl64_ui_harden_less
  bl64_dbg_lib_trace_start
  "$BL64_UI_CMD_LESS" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Channels:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_ui_run_more() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_UI_MOD_SETUP' &&
    bl64_check_command "$BL64_UI_CMD_MORE" "$BL64_VAR_DEFAULT" 'more' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_UI_CMD_MORE" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Select one item from a list
#
# Arguments:
#   $@: list of items. Format: list of string
# Channels:
#   STDOUT: selected item
#   STDERR: command errors
# Returns:
#   0: item selected
#   >0: item not selected or error
#######################################
function bl64_ui_select_item() {
  bl64_dbg_lib_show_function "$@"
  # shellcheck disable=SC2034
  local item_list="${*:-}"
  local item=''
  local PS3="${_BL64_UI_TXT_SELECT_ITEM}: "
  local menu_options=()

  bl64_check_module 'BL64_UI_MOD_SETUP' &&
    bl64_check_parameter 'item_list' || return $?

  case "$BL64_UI_TUI" in
    "$BL64_UI_TUI_DIALOG")
      for item in "$@"; do
        menu_options+=("$item" "")
      done
      bl64_dbg_lib_show_comments 'redirection required to show selection via stdout'
      bl64_ui_run_dialog --menu "$_BL64_UI_TXT_SELECT_ITEM" 0 0 0 "${menu_options[@]}" 3>&1 1>&2 2>&3
      ;;
    "$BL64_UI_TUI_FZF")
      printf '%s\n' "$@" | bl64_ui_run_fzf
      ;;
    "$BL64_UI_TUI_WHIPTAIL")
      for item in "$@"; do
        menu_options+=("$item" "")
      done
      bl64_dbg_lib_show_comments 'redirection required to show selection via stdout'
      bl64_ui_run_whiptail --menu "$_BL64_UI_TXT_SELECT_ITEM" 0 0 0 "${menu_options[@]}" 3>&1 1>&2 2>&3
      ;;
    "$BL64_UI_TUI_GUM")
      bl64_ui_run_gum choose "$@"
      ;;
    "$BL64_UI_TUI_BASH")
      select item in "$@"; do
        if [[ -n "$item" ]]; then
          echo "$item"
          return 0
        fi
      done
      return "$BL64_LIB_ERROR_TASK_FAILED"
      ;;
    *) bl64_check_rise_parameter_invalid 'BL64_UI_TUI' ;;
  esac
}

#######################################
# Show content using a paging tool
#
# Arguments:
#   None
# Channels:
#   STDIN: content to show
#   STDOUT: user interaction
#   STDERR: command errors
# Returns:
#   0: pager finished ok
#   >0: pager error
#######################################
function bl64_ui_page() {
  bl64_dbg_lib_show_function
  case "$BL64_UI_PAGER" in
    "$BL64_UI_PAGER_BAT") bl64_ui_run_bat - ;;
    "$BL64_UI_PAGER_LESS") bl64_ui_run_less - ;;
    "$BL64_UI_PAGER_MORE") bl64_ui_run_more - ;;
    "$BL64_UI_PAGER_CAT") bl64_ui_run_cat ;;
    *) bl64_check_rise_parameter_invalid 'BL64_UI_PAGER' ;;
  esac
}
