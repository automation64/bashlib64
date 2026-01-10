#######################################
# BashLib64 / Module / Setup / Interact with Ansible CLI
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: required in order to use the module
# * Check for core commands, fail if not available
#
# Arguments:
#   $1: (optional) Full path where commands are
#   $2: (optional) Full path to the ansible configuration file
#   $3: (optional) Ignore inherited shell environment? Default: BL64_VAR_ON
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_ans_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local ansible_bin="${1:-${BL64_VAR_DEFAULT}}"
  local ansible_config="${2:-${BL64_VAR_DEFAULT}}"
  local env_ignore="${3:-${BL64_VAR_ON}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_XSV_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_PY_MODULE' &&
    _bl64_ans_set_command "$ansible_bin" &&
    _bl64_ans_set_runtime "$ansible_config" &&
    _bl64_ans_set_options &&
    _bl64_ans_set_version &&
    BL64_ANS_ENV_IGNORE="$env_ignore" &&
    BL64_ANS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'ans'
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
function _bl64_ans_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_ANS_CMD_ANSIBLE="$(bl64_bsh_command_import 'ansible' '/opt/ansible/bin' "${HOME}/.local/bin" "$@")" &&
    BL64_ANS_CMD_ANSIBLE_GALAXY="$(bl64_bsh_command_import 'ansible-galaxy' '/opt/ansible/bin' "${HOME}/.local/bin" "$@")" &&
    BL64_ANS_CMD_ANSIBLE_PLAYBOOK="$(bl64_bsh_command_import 'ansible-playbook' '/opt/ansible/bin' "${HOME}/.local/bin" "$@")"
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
function _bl64_ans_set_options() {
  bl64_dbg_lib_show_function
  BL64_ANS_SET_VERBOSE='-v'
  BL64_ANS_SET_DIFF='--diff'
  BL64_ANS_SET_DEBUG='-vvvvv'
}

#######################################
# Set runtime defaults
#
# Arguments:
#   $1: path to ansible_config
# Outputs:
#   STDOUT: None
#   STDERR: setting errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function _bl64_ans_set_runtime() {
  bl64_dbg_lib_show_function "$@"
  local config="$1"
  bl64_ans_set_paths "$config"
}

#######################################
# Set and prepare module paths
#
# * Global paths only
# * If preparation fails the whole module fails
#
# Arguments:
#   $1: path to ansible_config
#   $2: path to ansible collections
#   $3: path to ansible workdir
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
function bl64_ans_set_paths() {
  bl64_dbg_lib_show_function "$@"
  local config="${1:-${BL64_VAR_DEFAULT}}"
  local collections="${2:-${BL64_VAR_DEFAULT}}"
  local ansible="${3:-${BL64_VAR_DEFAULT}}"

  if bl64_lib_var_is_default "$config"; then
    BL64_ANS_PATH_USR_CONFIG=''
  else
    bl64_check_file "$config" || return $?
    BL64_ANS_PATH_USR_CONFIG="$config"
  fi

  if bl64_lib_var_is_default "$ansible"; then
    BL64_ANS_PATH_USR_ANSIBLE="${HOME}/.ansible"
  else
    BL64_ANS_PATH_USR_ANSIBLE="$ansible"
  fi

  # shellcheck disable=SC2034
  if bl64_lib_var_is_default "$collections"; then
    BL64_ANS_PATH_USR_COLLECTIONS="${BL64_ANS_PATH_USR_ANSIBLE}/collections/ansible_collections"
  else
    bl64_check_directory "$collections" || return $?
    BL64_ANS_PATH_USR_COLLECTIONS="$ansible"
  fi

  bl64_dbg_lib_show_vars 'BL64_ANS_PATH_USR_CONFIG' 'BL64_ANS_PATH_USR_ANSIBLE' 'BL64_ANS_PATH_USR_COLLECTIONS'
  return 0
}

#######################################
# Identify and set module components versions
#
# * Version information is stored in module global variables
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: command errors
# Returns:
#   0: version set ok
#   >0: command error
#######################################
function _bl64_ans_set_version() {
  bl64_dbg_lib_show_function
  local cli_version=''

  bl64_dbg_lib_show_info "run ansible to obtain ansible-core version (${BL64_ANS_CMD_ANSIBLE} --version)"
  cli_version="$("$BL64_ANS_CMD_ANSIBLE" --version | bl64_txt_run_awk '/^ansible..core.*$/ { gsub( /\[|\]/, "" ); print $3 }')"
  bl64_dbg_lib_show_vars 'cli_version'

  if [[ -n "$cli_version" ]]; then
    # shellcheck disable=SC2034
    BL64_ANS_VERSION_CORE="$cli_version"
  else
    bl64_msg_show_lib_error "'failed to get CLI version' (${BL64_ANS_CMD_ANSIBLE} --version)"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
  fi

  bl64_dbg_lib_show_vars 'BL64_ANS_VERSION_CORE'
  return 0
}
