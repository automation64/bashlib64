#######################################
# BashLib64 / Module / Setup / User Interface
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Channels:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_ui_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local search_paths=("${@:-}")

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MOD_SETUP' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MOD_SETUP' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MOD_SETUP' &&
    _bl64_ui_set_command "${search_paths[@]}" &&
    BL64_UI_MOD_SETUP="$BL64_VAR_ON"
  bl64_check_rise_module_setup 'ui'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
# * All commands are optional, no error if not found
#
# Arguments:
#   None
# Channels:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_ui_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_UI_CMD_BAT="$(bl64_bsh_command_locate 'bat' "$@")"
  BL64_UI_CMD_DIALOG="$(bl64_bsh_command_locate 'dialog' "$@")"
  BL64_UI_CMD_FZF="$(bl64_bsh_command_locate 'fzf' "$@")"
  BL64_UI_CMD_GUM="$(bl64_bsh_command_locate 'gum' "$@")"
  BL64_UI_CMD_LESS="$(bl64_bsh_command_locate 'less')"
  BL64_UI_CMD_MORE="$(bl64_bsh_command_locate 'more')"
  BL64_UI_CMD_WHIPTAIL="$(bl64_bsh_command_locate 'whiptail' "$@")"

  if [[ -x "${BL64_UI_CMD_BAT}" ]]; then
    BL64_UI_PAGER="${BL64_UI_PAGER_BAT}"
  elif [[ -x "${BL64_UI_CMD_LESS}" ]]; then
    BL64_UI_PAGER="${BL64_UI_PAGER_LESS}"
  elif [[ -x "${BL64_UI_CMD_MORE}" ]]; then
    BL64_UI_PAGER="${BL64_UI_PAGER_MORE}"
  else
    BL64_UI_PAGER="${BL64_UI_PAGER_CAT}"
  fi

  if [[ -x "${BL64_UI_CMD_FZF}" ]]; then
    BL64_UI_TUI="${BL64_UI_TUI_FZF}"
  elif [[ -x "${BL64_UI_CMD_GUM}" ]]; then
    BL64_UI_TUI="${BL64_UI_TUI_GUM}"
  elif [[ -x "${BL64_UI_CMD_WHIPTAIL}" ]]; then
    BL64_UI_TUI="${BL64_UI_TUI_WHIPTAIL}"
  elif [[ -x "${BL64_UI_CMD_DIALOG}" ]]; then
    BL64_UI_TUI="${BL64_UI_TUI_DIALOG}"
  else
    BL64_UI_TUI="${BL64_UI_TUI_BASH}"
  fi

  bl64_dbg_lib_show_vars 'BL64_UI_PAGER' 'BL64_UI_TUI'
  return 0
}
