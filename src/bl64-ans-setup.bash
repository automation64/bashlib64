#######################################
# BashLib64 / Module / Setup / Interact with Ansible CLI
#
# Version: 1.3.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: required in order to use the module
# * Check for core commands, fail if not available
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_ans_setup() {
  bl64_dbg_lib_show_function "$@"
  local ansible_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$ansible_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$ansible_bin" ||
    return $?
  fi

  bl64_ans_set_command "$ansible_bin" &&
    bl64_ans_set_options &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE_GALAXY" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" &&
    BL64_ANS_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_ans_set_command() {
  bl64_dbg_lib_show_function
  local ansible_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$ansible_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -n "$BL64_PY_VENV_PATH" && -x "${BL64_PY_VENV_PATH}/bin/ansible" ]]; then
      ansible_bin="${BL64_PY_VENV_PATH}/bin"
    elif [[ -n "$HOME" && -x "${HOME}/.local/bin/ansible" ]]; then
      ansible_bin="${HOME}/.local/bin"
    elif [[ -x '/usr/local/bin/ansible' ]]; then
      ansible_bin='/usr/local/bin'
    elif [[ -x '/home/linuxbrew/.linuxbrew/bin/ansible' ]]; then
      ansible_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/ansible' ]]; then
      ansible_bin='/opt/homebrew/bin'
    elif [[ -x '/opt/ansible/bin/ansible' ]]; then
      ansible_bin='/opt/ansible/bin'
    elif [[ -x '/usr/bin/ansible' ]]; then
      ansible_bin='/usr/bin'
    fi
  else
    [[ ! -x "${ansible_bin}/ansible" ]] && ansible_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$ansible_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${ansible_bin}/ansible" ]] && BL64_ANS_CMD_ANSIBLE="${ansible_bin}/ansible"
    [[ -x "${ansible_bin}/ansible-galaxy" ]] && BL64_ANS_CMD_ANSIBLE_GALAXY="${ansible_bin}/ansible-galaxy"
    [[ -x "${ansible_bin}/ansible-playbook" ]] && BL64_ANS_CMD_ANSIBLE_PLAYBOOK="${ansible_bin}/ansible-playbook"
  fi

  # Publish common paths
  BL64_ANS_PATH_USR_ANSIBLE="${HOME}/.ansible"
  BL64_ANS_PATH_USR_COLLECTIONS="${BL64_ANS_PATH_USR_ANSIBLE}/collections/ansible_collections"

  bl64_dbg_lib_show_vars 'BL64_ANS_CMD_ANSIBLE' 'BL64_ANS_CMD_ANSIBLE_GALAXY' 'BL64_ANS_CMD_ANSIBLE_PLAYBOOK' 'BL64_ANS_PATH_USR_ANSIBLE' 'BL64_ANS_PATH_USR_COLLECTIONS'
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_ans_set_options() {
  bl64_dbg_lib_show_function

  BL64_ANS_SET_VERBOSE='-v'
  BL64_ANS_SET_DIFF='--diff'
  BL64_ANS_SET_DEBUG='-vvvvv'
}
