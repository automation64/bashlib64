#######################################
# BashLib64 / Module / Functions / Interact with Ansible CLI
#
# Version: 1.0.0
#######################################

#######################################
# Install Ansible Collections
#
# Arguments:
#   $@: list of ansible collections to install
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_ans_collections_install() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local collection=''

  for collection in "$@"; do
    bl64_ans_run_ansible_galaxy collection install "$collection" || return $?
  done
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust noone. Use default config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_ans_run_ansible() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local debug=' '

  bl64_check_module_setup "$BL64_ANS_MODULE" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE" ||
    return $?

  bl64_msg_verbose_lib_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_enabled && debug="$BL64_ANS_SET_DEBUG"

  unset ANSIBLE_CONFIG
  "$BL64_ANS_CMD_ANSIBLE" \
    $debug \
    "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust noone. Use default config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_ans_run_ansible_galaxy() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local debug=' '

  bl64_check_module_setup "$BL64_ANS_MODULE" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE_GALAXY" ||
    return $?

  bl64_msg_verbose_lib_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_enabled && debug="$BL64_ANS_SET_DEBUG"

  unset ANSIBLE_CONFIG
  "$BL64_ANS_CMD_ANSIBLE_GALAXY" \
    $debug \
    "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust noone. Use default config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_ans_run_ansible_playbook() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local debug=' '

  bl64_check_module_setup "$BL64_ANS_MODULE" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" ||
    return $?

  bl64_msg_verbose_lib_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_enabled && debug="$BL64_ANS_SET_DEBUG"

  unset ANSIBLE_CONFIG
  "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" \
    $debug \
    "$@"
}
