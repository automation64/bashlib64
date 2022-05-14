#######################################
# BashLib64 / Module / Setup / Interact with Ansible CLI
#
# Version: 1.0.0
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
function bl64_ans_setup() {
  bl64_dbg_lib_show_function

  bl64_ans_set_command &&
    bl64_ans_set_options &&
    BL64_ANS_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize commands
#
# * If no values are providedprovied, detect commands in order or preference
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
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

  if [[ -z "$BL64_ANS_CMD_ANSIBLE" ]]; then
    if [[ -n "$HOME" && -x "${HOME}/.local/bin/ansible" ]]; then
      BL64_ANS_CMD_ANSIBLE="${HOME}/.local/bin/ansible"
    elif [[ -x '/usr/local/bin/ansible' ]]; then
      BL64_ANS_CMD_ANSIBLE='/usr/local/bin/ansible'
    elif [[ -x '/home/linuxbrew/.linuxbrew/bin/ansible' ]]; then
      BL64_ANS_CMD_ANSIBLE='/home/linuxbrew/.linuxbrew/bin/ansible'
    elif [[ -x '/opt/homebrew/bin/ansible' ]]; then
      BL64_ANS_CMD_ANSIBLE='/opt/homebrew/bin/ansible'
    elif [[ -x '/usr/bin/ansible' ]]; then
      BL64_ANS_CMD_ANSIBLE='/usr/bin/ansible'
    else
      BL64_ANS_CMD_ANSIBLE="$BL64_LIB_UNAVAILABLE"
    fi
  fi

  if [[ -z "$BL64_ANS_CMD_ANSIBLE_GALAXY" ]]; then
    if [[ -n "$HOME" && -x "${HOME}/.local/bin/ansible-galaxy" ]]; then
      BL64_ANS_CMD_ANSIBLE_GALAXY="${HOME}/.local/bin/ansible-galaxy"
    elif [[ -x '/usr/local/bin/ansible-galaxy' ]]; then
      BL64_ANS_CMD_ANSIBLE_GALAXY='/usr/local/bin/ansible-galaxy'
    elif [[ -x '/home/linuxbrew/.linuxbrew/bin/ansible-galaxy' ]]; then
      BL64_ANS_CMD_ANSIBLE_GALAXY='/home/linuxbrew/.linuxbrew/bin/ansible-galaxy'
    elif [[ -x '/opt/homebrew/bin/ansible-galaxy' ]]; then
      BL64_ANS_CMD_ANSIBLE_GALAXY='/opt/homebrew/bin/ansible-galaxy'
    elif [[ -x '/usr/bin/ansible-galaxy' ]]; then
      BL64_ANS_CMD_ANSIBLE_GALAXY='/usr/bin/ansible-galaxy'
    else
      BL64_ANS_CMD_ANSIBLE_GALAXY="$BL64_LIB_UNAVAILABLE"
    fi
  fi

  if [[ -z "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" ]]; then
    if [[ -n "$HOME" && -x "${HOME}/.local/bin/ansible-playbook" ]]; then
      BL64_ANS_CMD_ANSIBLE_PLAYBOOK="${HOME}/.local/bin/ansible-playbook"
    elif [[ -x '/usr/local/bin/ansible-playbook' ]]; then
      BL64_ANS_CMD_ANSIBLE_PLAYBOOK='/usr/local/bin/ansible-playbook'
    elif [[ -x '/home/linuxbrew/.linuxbrew/bin/ansible-playbook' ]]; then
      BL64_ANS_CMD_ANSIBLE_PLAYBOOK='/home/linuxbrew/.linuxbrew/bin/ansible-playbook'
    elif [[ -x '/opt/homebrew/bin/ansible-playbook' ]]; then
      BL64_ANS_CMD_ANSIBLE_PLAYBOOK='/opt/homebrew/bin/ansible-playbook'
    elif [[ -x '/usr/bin/ansible-playbook' ]]; then
      BL64_ANS_CMD_ANSIBLE_PLAYBOOK='/usr/bin/ansible-playbook'
    else
      BL64_ANS_CMD_ANSIBLE_PLAYBOOK="$BL64_LIB_UNAVAILABLE"
    fi
  fi

  return 0
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
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
  BL64_ANS_SET_VERBOSE='-v'
  BL64_ANS_SET_DIFF='--diff'
  BL64_ANS_SET_DEBUG='-vvvvv'
}
