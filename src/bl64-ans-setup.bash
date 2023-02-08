#######################################
# BashLib64 / Module / Setup / Interact with Ansible CLI
#
# Version: 1.5.0
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
  bl64_dbg_lib_show_function "$@"
  local ansible_bin="${1:-${BL64_VAR_DEFAULT}}"
  local ansible_config="${2:-${BL64_VAR_DEFAULT}}"
  local env_ignore="${3:-${BL64_VAR_ON}}"

  bl64_ans_set_command "$ansible_bin" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE_GALAXY" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" &&
    bl64_ans_set_paths "$ansible_config" &&
    bl64_ans_set_options &&
    bl64_ans_set_version &&
    BL64_ANS_MODULE="$BL64_VAR_ON" &&
    BL64_ANS_ENV_IGNORE="$env_ignore" ||
    return $?

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
function bl64_ans_set_command() {
  bl64_dbg_lib_show_function
  local ansible_bin="$1"

  if [[ "$ansible_bin" == "$BL64_VAR_DEFAULT" ]]; then
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
  fi

  if [[ "$ansible_bin" != "$BL64_VAR_DEFAULT" ]]; then
    [[ -x "${ansible_bin}/ansible" ]] && BL64_ANS_CMD_ANSIBLE="${ansible_bin}/ansible"
    [[ -x "${ansible_bin}/ansible-galaxy" ]] && BL64_ANS_CMD_ANSIBLE_GALAXY="${ansible_bin}/ansible-galaxy"
    [[ -x "${ansible_bin}/ansible-playbook" ]] && BL64_ANS_CMD_ANSIBLE_PLAYBOOK="${ansible_bin}/ansible-playbook"
  fi

  bl64_dbg_lib_show_vars 'BL64_ANS_CMD_ANSIBLE' 'BL64_ANS_CMD_ANSIBLE_GALAXY' 'BL64_ANS_CMD_ANSIBLE_PLAYBOOK'
  return 0
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
  bl64_dbg_lib_show_function
  local config="${1:-${BL64_VAR_DEFAULT}}"
  local collections="${2:-${BL64_VAR_DEFAULT}}"
  local ansible="${3:-${BL64_VAR_DEFAULT}}"

  if [[ "$config" == "$BL64_VAR_DEFAULT" ]]; then
    BL64_ANS_PATH_USR_CONFIG=''
  else
    bl64_check_file "$config" || return $?
    BL64_ANS_PATH_USR_CONFIG="$config"
  fi

  if [[ "$ansible" == "$BL64_VAR_DEFAULT" ]]; then
    BL64_ANS_PATH_USR_ANSIBLE="${HOME}/.ansible"
  else
    BL64_ANS_PATH_USR_ANSIBLE="$ansible"
  fi

  if [[ "$collections" == "$BL64_VAR_DEFAULT" ]]; then
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
function bl64_ans_set_version() {
  bl64_dbg_lib_show_function
  local version=''

  bl64_dbg_lib_show_info "run ansible to obtain ansible-core version"
  version="$("$BL64_ANS_CMD_ANSIBLE" --version | bl64_txt_run_awk '/^ansible..core.*$/ { gsub( /\[|\]/, "" ); print $3 }')"

  if [[ -n "$version" ]]; then
    BL64_ANS_VERSION_CORE="$version"
  else
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  bl64_dbg_lib_show_vars 'BL64_ANS_VERSION_CORE'
  return 0
}
