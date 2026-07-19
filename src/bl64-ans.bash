#######################################
# BashLib64 / Module / Functions / Interact with Ansible CLI
#######################################

#
# Private functions
#

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
function bl64_ans_harden_ansible() {
  bl64_dbg_lib_show_function

  if bl64_lib_flag_is_enabled "$BL64_ANS_ENV_IGNORE"; then
    bl64_dbg_lib_show_info 'unset inherited ANSIBLE_* shell variables'
    bl64_dbg_lib_trace_start
    unset ANSIBLE_ACTION_PLUGINS
    unset ANSIBLE_AGNOSTIC_BECOME_PROMPT
    unset ANSIBLE_BECOME
    unset ANSIBLE_BECOME_ASK_PASS
    unset ANSIBLE_BECOME_PASSWORD_FILE
    unset ANSIBLE_BECOME_PLUGINS
    unset ANSIBLE_CACHE_PLUGIN
    unset ANSIBLE_CACHE_PLUGIN_CONNECTION
    unset ANSIBLE_CALLBACK_PLUGINS
    unset ANSIBLE_CALLBACKS_ENABLED
    unset ANSIBLE_CLICONF_PLUGINS
    unset ANSIBLE_COLLECTIONS_PATHS
    unset ANSIBLE_COLLECTIONS_SCAN_SYS_PATH
    unset ANSIBLE_CONFIG
    unset ANSIBLE_CONNECTION_PASSWORD_FILE
    unset ANSIBLE_CONNECTION_PATH
    unset ANSIBLE_CONNECTION_PLUGINS
    unset ANSIBLE_COW_PATH
    unset ANSIBLE_DEBUG
    unset ANSIBLE_DEPRECATION_WARNINGS
    unset ANSIBLE_DEVEL_WARNING
    unset ANSIBLE_DIFF_ALWAYS
    unset ANSIBLE_DISPLAY_ARGS_TO_STDOUT
    unset ANSIBLE_EXECUTABLE
    unset ANSIBLE_FACTS_MODULES
    unset ANSIBLE_FILTER_PLUGINS
    unset ANSIBLE_FORCE_COLOR
    unset ANSIBLE_GALAXY_CACHE_DIR
    unset ANSIBLE_GALAXY_DISABLE_GPG_VERIFY
    unset ANSIBLE_GALAXY_DISPLAY_PROGRESS
    unset ANSIBLE_GALAXY_GPG_KEYRING
    unset ANSIBLE_GALAXY_IGNORE
    unset ANSIBLE_GALAXY_IGNORE_SIGNATURE_STATUS_CODES
    unset ANSIBLE_GALAXY_SERVER
    unset ANSIBLE_GALAXY_SERVER_LIST
    unset ANSIBLE_GALAXY_TOKEN_PATH
    unset ANSIBLE_HOME
    unset ANSIBLE_HOST_KEY_CHECKING
    unset ANSIBLE_HTTPAPI_PLUGINS
    unset ANSIBLE_INVENTORY
    unset ANSIBLE_INVENTORY_PLUGINS
    unset ANSIBLE_JINJA2_EXTENSIONS
    unset ANSIBLE_KEEP_REMOTE_FILES
    unset ANSIBLE_LIBRARY
    unset ANSIBLE_LOAD_CALLBACK_PLUGINS
    unset ANSIBLE_LOCAL_TEMP
    unset ANSIBLE_LOG_FILTER
    unset ANSIBLE_LOG_PATH
    unset ANSIBLE_LOG_VERBOSITY
    unset ANSIBLE_LOOKUP_PLUGINS
    unset ANSIBLE_MODULE_ARGS
    unset ANSIBLE_MODULE_UTILS
    unset ANSIBLE_NETCONF_PLUGINS
    unset ANSIBLE_NO_LOG
    unset ANSIBLE_NO_TARGET_SYSLOG
    unset ANSIBLE_NOCOLOR
    unset ANSIBLE_PAGER
    unset ANSIBLE_PERSISTENT_CONTROL_PATH_DIR
    unset ANSIBLE_PIPELINING
    unset ANSIBLE_PLAYBOOK_DIR
    unset ANSIBLE_PRIVATE_KEY_FILE
    unset ANSIBLE_PYTHON_INTERPRETER
    unset ANSIBLE_RETRY_FILES_SAVE_PATH
    unset ANSIBLE_ROLES_PATH
    unset ANSIBLE_SSH_AGENT
    unset ANSIBLE_SSH_AGENT_EXECUTABLE
    unset ANSIBLE_SSH_CONTROL_PATH_DIR
    unset ANSIBLE_STDOUT_CALLBACK
    unset ANSIBLE_VAULT_PASSWORD_FILE
    unset ANSIBLE_VERBOSE_TO_STDERR
    unset ANSIBLE_VERBOSITY
    bl64_dbg_lib_trace_stop
  fi

  bl64_lib_var_is_set "$BL64_ANS_PATH_USR_COLLECTIONS" && export ANSIBLE_COLLECTIONS_PATHS="$BL64_ANS_PATH_USR_COLLECTIONS"
  bl64_lib_var_is_set "$BL64_ANS_PATH_USR_CONFIG" && export ANSIBLE_CONFIG="$BL64_ANS_PATH_USR_CONFIG"
  bl64_lib_var_is_set "$BL64_ANS_PATH_USR_HOME" && export ANSIBLE_HOME="$BL64_ANS_PATH_USR_HOME"
  bl64_lib_var_is_set "$BL64_ANS_PATH_USR_INVENTORY" && export ANSIBLE_INVENTORY="$BL64_ANS_PATH_USR_INVENTORY"
  bl64_lib_var_is_set "$BL64_ANS_PATH_USR_LOG" && export ANSIBLE_LOG_PATH="$BL64_ANS_PATH_USR_LOG"
  bl64_dbg_lib_show_vars 'ANSIBLE_HOME' 'ANSIBLE_CONFIG' 'ANSIBLE_COLLECTIONS_PATHS' 'ANSIBLE_INVENTORY' 'ANSIBLE_LOG_PATH'

  if bl64_lib_var_is_set "$BL64_ANS_PATH_USR_TMP"; then
    export ANSIBLE_CACHE_PLUGIN_CONNECTION="${BL64_ANS_PATH_USR_TMP}/cpc"
    export ANSIBLE_GALAXY_CACHE_DIR="${BL64_ANS_PATH_USR_TMP}/gc"
    export ANSIBLE_LOCAL_TEMP="${BL64_ANS_PATH_USR_TMP}/tmp"
    export ANSIBLE_PERSISTENT_CONTROL_PATH_DIR="${BL64_ANS_PATH_USR_TMP}/pc"
    export ANSIBLE_RETRY_FILES_SAVE_PATH="${BL64_ANS_PATH_USR_TMP}/rf"
    export ANSIBLE_SSH_CONTROL_PATH_DIR="${BL64_ANS_PATH_USR_TMP}/ssh"
    bl64_dbg_lib_show_vars \
      'ANSIBLE_CACHE_PLUGIN_CONNECTION' \
      'ANSIBLE_GALAXY_CACHE_DIR' \
      'ANSIBLE_LOCAL_TEMP' \
      'ANSIBLE_PERSISTENT_CONTROL_PATH_DIR' \
      'ANSIBLE_RETRY_FILES_SAVE_PATH' \
      'ANSIBLE_SSH_CONTROL_PATH_DIR'
  fi

  bl64_lib_var_is_set "$BL64_ANS_CFG_STDOUT_CALLBACK" && export ANSIBLE_STDOUT_CALLBACK="$BL64_ANS_CFG_STDOUT_CALLBACK"
  bl64_dbg_lib_show_vars 'ANSIBLE_STDOUT_CALLBACK'

  if bl64_lib_mode_cicd_is_enabled; then
    export ANSIBLE_BECOME_ASK_PASS='False'
    export ANSIBLE_GALAXY_DISPLAY_PROGRESS='False'
    export ANSIBLE_HOST_KEY_CHECKING='False'
    export ANSIBLE_NOCOLOR='True'
  fi
  if bl64_lib_var_is_set "$BL64_ANS_CFG_VERBOSITY"; then
    export ANSIBLE_VERBOSITY="$BL64_ANS_CFG_VERBOSITY"
  else
    bl64_msg_app_detail_is_enabled && export ANSIBLE_VERBOSITY='1'
  fi
  bl64_dbg_lib_command_is_enabled && export ANSIBLE_DEBUG='True'

  return 0
}

#
# Public functions
#

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

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_ANS_MODULE' ||
    return $?

  bl64_ans_harden_ansible

  bl64_dbg_lib_trace_start
  "$BL64_ANS_CMD_ANSIBLE" \
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

  bl64_check_module 'BL64_ANS_MODULE' &&
    bl64_check_parameter 'command' &&
    bl64_check_parameter 'subcommand' &&
    shift 2 ||
    return $?

  bl64_ans_harden_ansible

  bl64_dbg_lib_trace_start
  "$BL64_ANS_CMD_ANSIBLE_GALAXY" \
    "$command" \
    "$subcommand" \
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

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_ANS_MODULE' ||
    return $?

  bl64_ans_harden_ansible

  bl64_dbg_lib_trace_start
  "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" \
    "$@"
  bl64_dbg_lib_trace_stop
}
