#######################################
# BashLib64 / Module / Functions / Interact with Ansible CLI
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_ans_collections_install() {
  bl64_dbg_lib_show_function "$@"
  local collection=''

  bl64_check_parameters_none "$#" || return $?

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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_ans_run_ansible() {
  bl64_dbg_lib_show_function "$@"
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_ANS_MODULE' ||
    return $?

  bl64_msg_app_detail_is_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_is_enabled && debug="$BL64_ANS_SET_DEBUG"

  _bl64_ans_harden_ansible

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ANS_CMD_ANSIBLE" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Use default config
#
# Arguments:
#   $1: command
#   $2: subcommand
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_ans_run_ansible_galaxy() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-${BL64_VAR_NULL}}"
  local subcommand="${2:-${BL64_VAR_NULL}}"
  local debug=' '

  bl64_check_module 'BL64_ANS_MODULE' &&
    bl64_check_parameter 'command' &&
    bl64_check_parameter 'subcommand' ||
    return $?

  bl64_msg_app_detail_is_enabled && debug="$BL64_ANS_SET_VERBOSE"

  _bl64_ans_harden_ansible

  shift
  shift
  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ANS_CMD_ANSIBLE_GALAXY" \
    "$command" \
    "$subcommand" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Use default config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_ans_run_ansible_playbook() {
  bl64_dbg_lib_show_function "$@"
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_ANS_MODULE' ||
    return $?

  bl64_msg_app_detail_is_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_is_enabled && debug="$BL64_ANS_SET_DEBUG"

  _bl64_ans_harden_ansible

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_ans_harden_ansible() {
  bl64_dbg_lib_show_function

  if [[ "$BL64_ANS_ENV_IGNORE" == "$BL64_VAR_ON" ]]; then
    bl64_dbg_lib_show_info 'unset inherited ANSIBLE_* shell variables'
    bl64_dbg_lib_trace_start
    unset ANSIBLE_CACHE_PLUGIN_CONNECTION
    unset ANSIBLE_COLLECTIONS_PATHS
    unset ANSIBLE_CONFIG
    unset ANSIBLE_GALAXY_CACHE_DIR
    unset ANSIBLE_GALAXY_TOKEN_PATH
    unset ANSIBLE_INVENTORY
    unset ANSIBLE_LOCAL_TEMP
    unset ANSIBLE_LOG_PATH
    unset ANSIBLE_PERSISTENT_CONTROL_PATH_DIR
    unset ANSIBLE_PLAYBOOK_DIR
    unset ANSIBLE_PRIVATE_KEY_FILE
    unset ANSIBLE_ROLES_PATH
    unset ANSIBLE_SSH_CONTROL_PATH_DIR
    unset ANSIBLE_VAULT_PASSWORD_FILE
    unset ANSIBLE_RETRY_FILES_SAVE_PATH
    bl64_dbg_lib_trace_stop
  fi

  [[ -n "$BL64_ANS_PATH_USR_CONFIG" ]] && export ANSIBLE_CONFIG="$BL64_ANS_PATH_USR_CONFIG"

  return 0
}
