#######################################
# BashLib64 / Module / Functions / Interact with Ansible CLI
#
# Version: 1.2.0
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
    bl64_ans_run_ansible_galaxy \
      collection \
      install \
      --upgrade \
      "$collection" ||
      return $?
  done
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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

  bl64_check_module_setup "$BL64_ANS_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_enabled && debug="$BL64_ANS_SET_DEBUG"

  unset ANSIBLE_CONFIG
  unset ANSIBLE_COLLECTIONS
  bl64_dbg_lib_show_info "extra args: [${debug}]"
  # shellcheck disable=SC2086
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

  bl64_check_module_setup "$BL64_ANS_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && debug="$BL64_ANS_SET_VERBOSE"

  unset ANSIBLE_CONFIG
  unset ANSIBLE_COLLECTIONS
  bl64_dbg_lib_show_info "extra args: [${debug}]"
  # shellcheck disable=SC2086
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

  bl64_check_module_setup "$BL64_ANS_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_enabled && debug="$BL64_ANS_SET_DEBUG"

  unset ANSIBLE_CONFIG
  unset ANSIBLE_COLLECTIONS
  bl64_dbg_lib_show_info "extra args: [${debug}]"
  # shellcheck disable=SC2086
  "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" \
    $debug \
    "$@"
}
