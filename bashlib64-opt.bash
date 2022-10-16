#!/usr/bin/env bash
#######################################
# BashLib64 / Bash automation librbary
#
# Author: serdigital64 (https://github.com/serdigital64)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 7.2.0
#
# Copyright 2022 SerDigital64@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#######################################

#######################################
# BashLib64 / Module / Globals / Interact with Ansible CLI
#
# Version: 1.5.0
#######################################

# Optional module. Not enabled by default
export BL64_ANS_MODULE="$BL64_LIB_VAR_OFF"

export BL64_ANS_ENV_IGNORE=''

export BL64_ANS_VERSION_CORE=''

export BL64_ANS_CMD_ANSIBLE="$BL64_LIB_UNAVAILABLE"
export BL64_ANS_CMD_ANSIBLE_PLAYBOOK="$BL64_LIB_UNAVAILABLE"
export BL64_ANS_CMD_ANSIBLE_GALAXY="$BL64_LIB_UNAVAILABLE"

export BL64_ANS_PATH_USR_ANSIBLE=''
export BL64_ANS_PATH_USR_COLLECTIONS=''
export BL64_ANS_PATH_USR_CONFIG=''

export BL64_ANS_SET_VERBOSE=''
export BL64_ANS_SET_DIFF=''
export BL64_ANS_SET_DEBUG=''

#######################################
# BashLib64 / Module / Globals / Interact with AWS
#
# Version: 1.2.0
#######################################

# Optional module. Not enabled by default
export BL64_AWS_MODULE="$BL64_LIB_VAR_OFF"

export BL64_AWS_CMD_AWS="$BL64_LIB_UNAVAILABLE"

export BL64_AWS_DEF_SUFFIX_TOKEN=''
export BL64_AWS_DEF_SUFFIX_HOME=''
export BL64_AWS_DEF_SUFFIX_CACHE=''
export BL64_AWS_DEF_SUFFIX_CONFIG=''
export BL64_AWS_DEF_SUFFIX_CREDENTIALS=''

export BL64_AWS_CLI_MODE='0700'
export BL64_AWS_CLI_HOME=''
export BL64_AWS_CLI_CONFIG=''
export BL64_AWS_CLI_CREDENTIALS=''
export BL64_AWS_CLI_TOKEN=''

export BL64_AWS_SET_FORMAT_JSON=''
export BL64_AWS_SET_FORMAT_TEXT=''
export BL64_AWS_SET_FORMAT_TABLE=''
export BL64_AWS_SET_FORMAT_YAML=''
export BL64_AWS_SET_FORMAT_STREAM=''
export BL64_AWS_SET_DEBUG=''
export BL64_AWS_SET_OUPUT_NO_PAGER=''

export BL64_AWS_TXT_TOKEN_NOT_FOUND='unable to locate temporary access token file'

#######################################
# BashLib64 / Module / Globals / Interact with container engines
#
# Version: 1.1.0
#######################################

# Optional module. Not enabled by default
export BL64_CNT_MODULE="$BL64_LIB_VAR_OFF"

export BL64_CNT_CMD_PODMAN=''
export BL64_CNT_CMD_DOCKER=''

export _BL64_CNT_TXT_NO_CLI='unable to detect supported container engine'

#######################################
# BashLib64 / Module / Globals / Interact with GCP
#
# Version: 1.2.0
#######################################

# Optional module. Not enabled by default
export BL64_GCP_MODULE="$BL64_LIB_VAR_OFF"

export BL64_GCP_CMD_GCLOUD="$BL64_LIB_UNAVAILABLE"

export BL64_GCP_CONFIGURATION_NAME='bl64_gcp_configuration_private'
export BL64_GCP_CONFIGURATION_CREATED="$BL64_LIB_VAR_FALSE"

export BL64_GCP_SET_FORMAT_YAML=''
export BL64_GCP_SET_FORMAT_TEXT=''
export BL64_GCP_SET_FORMAT_JSON=''

#######################################
# BashLib64 / Module / Globals / Interact with HLM
#
# Version: 1.1.0
#######################################

# Optional module. Not enabled by default
export BL64_HLM_MODULE="$BL64_LIB_VAR_OFF"

export BL64_HLM_CMD_HELM="$BL64_LIB_UNAVAILABLE"

export BL64_HLM_SET_DEBUG=''
export BL64_HLM_SET_OUTPUT_TABLE=''
export BL64_HLM_SET_OUTPUT_JSON=''
export BL64_HLM_SET_OUTPUT_YAML=''

export BL64_HLM_RUN_TIMEOUT=''

#######################################
# BashLib64 / Module / Globals / Interact with Kubernetes
#
# Version: 1.1.0
#######################################

# Optional module. Not enabled by default
export BL64_K8S_MODULE="$BL64_LIB_VAR_OFF"

export BL64_K8S_CMD_KUBECTL="$BL64_LIB_UNAVAILABLE"

export BL64_K8S_SET_VERBOSE_NONE=''
export BL64_K8S_SET_VERBOSE_NORMAL=''
export BL64_K8S_SET_VERBOSE_DEBUG=''
export BL64_K8S_SET_OUTPUT_JSON=''
export BL64_K8S_SET_OUTPUT_YAML=''
export BL64_K8S_SET_OUTPUT_TXT=''

#######################################
# BashLib64 / Module / Setup / Interact with MongoDB
#
# Version: 1.1.0
#######################################

# Optional module. Not enabled by default
export BL64_MDB_MODULE="$BL64_LIB_VAR_OFF"

export BL64_MDB_CMD_MONGOSH="$BL64_LIB_UNAVAILABLE"
export BL64_MDB_CMD_MONGORESTORE="$BL64_LIB_UNAVAILABLE"
export BL64_MDB_CMD_MONGOEXPORT="$BL64_LIB_UNAVAILABLE"

export BL64_MDB_SET_VERBOSE=''
export BL64_MDB_SET_QUIET=''
export BL64_MDB_SET_NORC=''

export BL64_MDB_REPLICA_WRITE=''
export BL64_MDB_REPLICA_TIMEOUT=''

#######################################
# BashLib64 / Module / Globals / Interact with Terraform
#
# Version: 1.1.0
#######################################

# Optional module. Not enabled by default
export BL64_TF_MODULE="$BL64_LIB_VAR_OFF"

export BL64_TF_LOG_PATH=''
export BL64_TF_LOG_LEVEL=''

export BL64_TF_CMD_TERRAFORM="$BL64_LIB_UNAVAILABLE"

# Output export formats
export BL64_TF_OUTPUT_RAW='0'
export BL64_TF_OUTPUT_JSON='1'
export BL64_TF_OUTPUT_TEXT='2'

export BL64_TF_SET_LOG_TRACE=''
export BL64_TF_SET_LOG_DEBUG=''
export BL64_TF_SET_LOG_INFO=''
export BL64_TF_SET_LOG_WARN=''
export BL64_TF_SET_LOG_ERROR=''
export BL64_TF_SET_LOG_OFF=''

export BL64_TF_DEF_PATH_LOCK=''
export BL64_TF_DEF_PATH_RUNTIME=''

#######################################
# BashLib64 / Module / Setup / Interact with Ansible CLI
#
# Version: 1.4.0
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
#   $3: (optional) Ignore inherited shell environment? Default: BL64_LIB_VAR_ON
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
  local ansible_config="${2:-${BL64_LIB_DEFAULT}}"
  local env_ignore="${3:-${BL64_LIB_VAR_ON}}"

  bl64_ans_set_command "$ansible_bin" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE_GALAXY" &&
    bl64_check_command "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" &&
    bl64_ans_set_paths "$ansible_config" &&
    bl64_ans_set_options &&
    bl64_ans_set_version ||
    return $?

  BL64_ANS_MODULE="$BL64_LIB_VAR_ON"
  BL64_ANS_ENV_IGNORE="$env_ignore"

  return 0
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
  fi

  if [[ "$ansible_bin" != "$BL64_LIB_DEFAULT" ]]; then
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
  local config="${1:-${BL64_LIB_DEFAULT}}"
  local collections="${2:-${BL64_LIB_DEFAULT}}"
  local ansible="${3:-${BL64_LIB_DEFAULT}}"

  if [[ "$config" == "$BL64_LIB_DEFAULT" ]]; then
    BL64_ANS_PATH_USR_CONFIG=''
  else
    bl64_check_file "$config" || return $?
    BL64_ANS_PATH_USR_CONFIG="$config"
  fi

  if [[ "$ansible" == "$BL64_LIB_DEFAULT" ]]; then
    BL64_ANS_PATH_USR_ANSIBLE="${HOME}/.ansible"
  else
    BL64_ANS_PATH_USR_ANSIBLE="$ansible"
  fi

  if [[ "$collections" == "$BL64_LIB_DEFAULT" ]]; then
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

#######################################
# BashLib64 / Module / Functions / Interact with Ansible CLI
#
# Version: 1.5.0
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
#   command exit status
#######################################
function bl64_ans_run_ansible() {
  bl64_dbg_lib_show_function "$@"
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_ANS_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_enabled && debug="$BL64_ANS_SET_DEBUG"

  bl64_ans_blank_ansible

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
# * Trust noone. Use default config
#
# Arguments:
#   $1: command
#   $2: subcommand
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_ans_run_ansible_galaxy() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-${BL64_LIB_VAR_NULL}}"
  local subcommand="${2:-${BL64_LIB_VAR_NULL}}"
  local debug=' '

  bl64_check_module_setup "$BL64_ANS_MODULE" &&
    bl64_check_parameter 'command' &&
    bl64_check_parameter 'subcommand' ||
    return $?

  bl64_msg_lib_verbose_enabled && debug="$BL64_ANS_SET_VERBOSE"

  bl64_ans_blank_ansible

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
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_ANS_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_enabled && debug="$BL64_ANS_SET_DEBUG"

  bl64_ans_blank_ansible

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
function bl64_ans_blank_ansible() {
  bl64_dbg_lib_show_function

  if [[ "$BL64_ANS_ENV_IGNORE" == "$BL64_LIB_VAR_ON" ]]; then
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

#######################################
# BashLib64 / Module / Setup / Interact with AWS
#
# Version: 1.2.0
#######################################


#
# Module attributes getters
#

function bl64_aws_get_cli_config() {
  bl64_dbg_lib_show_function
  bl64_check_module_setup "$BL64_AWS_MODULE" || return $?
  echo "$BL64_AWS_CLI_CONFIG"
}

function bl64_aws_get_cli_credentials() {
  bl64_dbg_lib_show_function
  bl64_check_module_setup "$BL64_AWS_MODULE" || return $?
  echo "$BL64_AWS_CLI_CREDENTIALS"
}


#######################################
# Setup the bashlib64 module
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
function bl64_aws_setup() {
  bl64_dbg_lib_show_function "$@"
  local aws_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$aws_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$aws_bin" ||
      return $?
  fi

  bl64_aws_set_command "$aws_bin" &&
    bl64_aws_set_options &&
    bl64_aws_set_definitions &&
    bl64_check_command "$BL64_AWS_CMD_AWS" &&
    bl64_aws_set_paths &&
    BL64_AWS_MODULE="$BL64_LIB_VAR_ON"

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
function bl64_aws_set_command() {
  bl64_dbg_lib_show_function "$@"
  local aws_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$aws_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/aws' ]]; then
      aws_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/aws' ]]; then
      aws_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/aws' ]]; then
      aws_bin='/usr/local/bin'
    elif [[ -x '/opt/aws/bin/aws' ]]; then
      aws_bin='/opt/aws/bin'
    elif [[ -x '/usr/bin/aws' ]]; then
      aws_bin='/usr/bin'
    fi
  else
    [[ ! -x "${aws_bin}/aws" ]] && aws_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$aws_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${aws_bin}/aws" ]] && BL64_AWS_CMD_AWS="${aws_bin}/aws"
  fi

  bl64_dbg_lib_show_vars 'BL64_AWS_CMD_AWS'
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
function bl64_aws_set_options() {
  bl64_dbg_lib_show_function

  BL64_AWS_SET_FORMAT_JSON='--output json'
  BL64_AWS_SET_FORMAT_TEXT='--output text'
  BL64_AWS_SET_FORMAT_TABLE='--output table'
  BL64_AWS_SET_FORMAT_YAML='--output yaml'
  BL64_AWS_SET_FORMAT_STREAM='--output yaml-stream'
  BL64_AWS_SET_DEBUG='--debug'
  BL64_AWS_SET_OUPUT_NO_PAGER='--no-cli-pager'
  BL64_AWS_SET_OUPUT_NO_COLOR='--color off'
  BL64_AWS_SET_INPUT_NO_PROMPT='--no-cli-auto-prompt'

  return 0
}

#######################################
# Declare version specific definitions
#
# * Use to capture default file names, values, attributes, etc
# * Do not use to capture CLI flags. Use *_set_options instead
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_aws_set_definitions() {
  bl64_dbg_lib_show_function

  BL64_AWS_DEF_SUFFIX_TOKEN='json'
  BL64_AWS_DEF_SUFFIX_HOME='.aws'
  BL64_AWS_DEF_SUFFIX_CACHE='sso/cache'
  BL64_AWS_DEF_SUFFIX_CONFIG='cfg'
  BL64_AWS_DEF_SUFFIX_CREDENTIALS='secret'

  return 0
}

#######################################
# Set and prepare module paths
#
# * Global paths only
# * If preparation fails the whole module fails
#
# Arguments:
#   $1: configuration file name
#   $2: credential file name
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
# shellcheck disable=SC2120
function bl64_aws_set_paths() {
  bl64_dbg_lib_show_function "$@"
  local configuration="${1:-${BL64_SCRIPT_ID}}"
  local credentials="${2:-${BL64_SCRIPT_ID}}"
  local aws_home=''

  bl64_dbg_lib_show_info 'prepare AWS_HOME'
  bl64_check_home || return $?
  aws_home="${HOME}/${BL64_AWS_DEF_SUFFIX_HOME}"
  bl64_fs_create_dir "$BL64_AWS_CLI_MODE" "$BL64_LIB_DEFAULT" "$BL64_LIB_DEFAULT" "$aws_home" || return $?

  bl64_dbg_lib_show_info 'set configuration paths'
  BL64_AWS_CLI_HOME="$aws_home"
  BL64_AWS_CLI_CACHE="${BL64_AWS_CLI_HOME}/${BL64_AWS_DEF_SUFFIX_CACHE}"
  BL64_AWS_CLI_CONFIG="${BL64_AWS_CLI_HOME}/${configuration}.${BL64_AWS_DEF_SUFFIX_CONFIG}"
  BL64_AWS_CLI_CREDENTIALS="${BL64_AWS_CLI_HOME}/${credentials}.${BL64_AWS_DEF_SUFFIX_CREDENTIALS}"

  bl64_dbg_lib_show_vars 'BL64_AWS_CLI_HOME' 'BL64_AWS_CLI_CACHE' 'BL64_AWS_CLI_CONFIG' 'BL64_AWS_CLI_CREDENTIALS'
  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with AWS
#
# Version: 1.2.0
#######################################

#######################################
# Creates a SSO profile in the AWS CLI configuration file
#
# * Equivalent to aws configure sso
#
# Arguments:
#   $1: profile name
#   $2: start url
#   $3: region
#   $4: account id
#   $5: permission set
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_aws_cli_create_sso() {
  bl64_dbg_lib_show_function "$@"
  local profile="${1:-${BL64_LIB_DEFAULT}}"
  local start_url="${2:-${BL64_LIB_DEFAULT}}"
  local sso_region="${3:-${BL64_LIB_DEFAULT}}"
  local sso_account_id="${4:-${BL64_LIB_DEFAULT}}"
  local sso_role_name="${5:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'profile' &&
    bl64_check_parameter 'start_url' &&
    bl64_check_parameter 'sso_region' &&
    bl64_check_parameter 'sso_account_id' &&
    bl64_check_parameter 'sso_role_name' &&
    bl64_check_module_setup "$BL64_AWS_MODULE" ||
    return $?

  bl64_dbg_lib_show_info "create AWS CLI profile for AWS SSO login (${BL64_AWS_CLI_CONFIG})"
  printf '[profile %s]\n' "$profile" >"$BL64_AWS_CLI_CONFIG" &&
    printf 'sso_start_url = %s\n' "$start_url" >>"$BL64_AWS_CLI_CONFIG" &&
    printf 'sso_region = %s\n' "$sso_region" >>"$BL64_AWS_CLI_CONFIG" &&
    printf 'sso_account_id = %s\n' "$sso_account_id" >>"$BL64_AWS_CLI_CONFIG" &&
    printf 'sso_role_name = %s\n' "$sso_role_name" >>"$BL64_AWS_CLI_CONFIG"

}

#######################################
# Login to AWS using SSO
#
# * Equivalent to aws --profile X sso login
# * The SSO profile must be already created
# * SSO login requires a browser connection. The command will show the URL to open to get the one time code
#
# Arguments:
#   $1: profile name
# Outputs:
#   STDOUT: login process information
#   STDERR: command stderr
# Returns:
#   0: login ok
#   >0: failed to login
#######################################
function bl64_aws_sso_login() {
  bl64_dbg_lib_show_function "$@"
  local profile="${1:-${BL64_LIB_DEFAULT}}"

  bl64_aws_run_aws_profile \
    "$profile" \
    sso \
    login \
    --no-browser

}

#######################################
# Get current caller ARN
#
# Arguments:
#   $1: profile name
# Outputs:
#   STDOUT: ARN
#   STDERR: command stderr
# Returns:
#   0: got value ok
#   >0: failed to get
#######################################
function bl64_aws_sts_get_caller_arn() {
  bl64_dbg_lib_show_function "$@"
  local profile="${1:-${BL64_LIB_DEFAULT}}"

  # shellcheck disable=SC2086
  bl64_aws_run_aws_profile \
    "$profile" \
    $BL64_AWS_SET_FORMAT_TEXT \
    --query '[Arn]' \
    sts \
    get-caller-identity

}

#######################################
# Get file path to the SSO cached token
#
# * Token must first be generated by aws sso login
# * Token is saved in a fixed location, but with random file name
#
# Arguments:
#   $1: profile name
# Outputs:
#   STDOUT: token path
#   STDERR: command stderr
# Returns:
#   0: got value ok
#   >0: failed to get
#######################################
function bl64_aws_sso_get_token() {
  bl64_dbg_lib_show_function "$@"
  local start_url="${1:-}"
  local token_file=''

  bl64_check_module_setup "$BL64_AWS_MODULE" &&
    bl64_check_parameter 'start_url' &&
    bl64_check_directory "$BL64_AWS_CLI_CACHE" ||
    return $?

  bl64_dbg_lib_show_info "search for sso login token (${BL64_AWS_CLI_CACHE})"
  bl64_dbg_lib_trace_start
  token_file="$(bl64_fs_find_files \
    "$BL64_AWS_CLI_CACHE" \
    "*.${BL64_AWS_DEF_SUFFIX_TOKEN}" \
    "$start_url")"
  bl64_dbg_lib_trace_stop

  if [[ -n "$token_file" && -r "$token_file" ]]; then
    echo "$token_file"
  else
    bl64_msg_show_error "$BL64_AWS_TXT_TOKEN_NOT_FOUND"
    return $BL64_LIB_ERROR_TASK_FAILED
  fi

}

#######################################
# Command wrapper for aws cli with mandatory profile
#
# * profile entry must be previously generated
#
# Arguments:
#   $1: profile name
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_aws_run_aws_profile() {
  bl64_dbg_lib_show_function "$@"
  local profile="${1:-}"

  bl64_check_module_setup "$BL64_AWS_MODULE" &&
    bl64_check_parameter 'profile' &&
    bl64_check_file "$BL64_AWS_CLI_CONFIG" ||
    return $?

  shift
  bl64_aws_run_aws \
    --profile "$profile" \
    "$@"
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
function bl64_aws_run_aws() {
  bl64_dbg_lib_show_function "$@"
  local verbosity="$BL64_AWS_SET_OUPUT_NO_COLOR"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_AWS_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity=' '
  bl64_dbg_lib_command_enabled && verbosity="$BL64_AWS_SET_DEBUG"

  bl64_aws_blank_aws

  export AWS_CONFIG_FILE="$BL64_AWS_CLI_CONFIG"
  export AWS_SHARED_CREDENTIALS_FILE="$BL64_AWS_CLI_CREDENTIALS"
  bl64_dbg_lib_show_vars 'AWS_CONFIG_FILE' 'AWS_SHARED_CREDENTIALS_FILE'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_AWS_CMD_AWS" \
    $BL64_AWS_SET_INPUT_NO_PROMPT \
    $BL64_AWS_SET_OUPUT_NO_PAGER \
    $verbosity \
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
function bl64_aws_blank_aws() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited AWS_* shell variables'
  bl64_dbg_lib_trace_start
  unset AWS_PAGER
  unset AWS_PROFILE
  unset AWS_REGION
  unset AWS_CA_BUNDLE
  unset AWS_CONFIG_FILE
  unset AWS_DATA_PATH
  unset AWS_DEFAULT_OUTPUT
  unset AWS_DEFAULT_REGION
  unset AWS_MAX_ATTEMPTS
  unset AWS_RETRY_MODE
  unset AWS_ROLE_ARN
  unset AWS_SESSION_TOKEN
  unset AWS_ACCESS_KEY_ID
  unset AWS_CLI_AUTO_PROMPT
  unset AWS_CLI_FILE_ENCODING
  unset AWS_METADATA_SERVICE_TIMEOUT
  unset AWS_ROLE_SESSION_NAME
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SHARED_CREDENTIALS_FILE
  unset AWS_EC2_METADATA_DISABLED
  unset AWS_METADATA_SERVICE_NUM_ATTEMPTS
  unset AWS_WEB_IDENTITY_TOKEN_FILE
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# BashLib64 / Module / Setup / Interact with container engines
#
# Version: 1.4.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: required in order to use the module
# * Check for core commands, fail if not available
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
function bl64_cnt_setup() {
  bl64_dbg_lib_show_function

  bl64_cnt_set_command || return $?

  if [[ ! -x "$BL64_CNT_CMD_DOCKER" && ! -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_msg_show_error "$_BL64_CNT_TXT_NO_CLI (docker or podman)"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  else
    BL64_CNT_MODULE="$BL64_LIB_VAR_ON"
  fi

}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_cnt_set_command() {
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-*)
    BL64_CNT_CMD_PODMAN='/usr/bin/podman'
    BL64_CNT_CMD_DOCKER='/usr/bin/docker'
    ;;
  ${BL64_OS_MCOS}-*)
    # Podman is not available for MacOS
    BL64_CNT_CMD_PODMAN="$BL64_LIB_INCOMPATIBLE"
    # Docker is available using docker-desktop
    BL64_CNT_CMD_DOCKER='/usr/local/bin/docker'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Interact with container engines
#
# Version: 1.5.0
#######################################

#######################################
# Logins the container engine to a container registry. The password is stored in a regular file
#
# Arguments:
#   $1: user
#   $2: file
#   $3: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_login_file() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local file="$2"
  local registry="$3"

  bl64_check_parameter 'user' &&
    bl64_check_parameter 'file' &&
    bl64_check_parameter 'registry' &&
    bl64_check_file "$file" ||
    return $?

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_login "$user" "$BL64_LIB_DEFAULT" "$file" "$registry"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_login "$user" "$BL64_LIB_DEFAULT" "$file" "$registry"
  fi
}

#######################################
# Logins the container engine to a container. The password is passed as parameter
#
# Arguments:
#   $1: user
#   $2: password
#   $3: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_login() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local password="$2"
  local registry="$3"

  bl64_check_parameter 'user' &&
    bl64_check_parameter 'password' &&
    bl64_check_parameter 'registry' ||
    return $?

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_login "$user" "$password" "$BL64_LIB_DEFAULT" "$registry"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_login "$user" "$password" "$BL64_LIB_DEFAULT" "$registry"
  fi
}

#######################################
# Command wrapper: docker login
#
# Arguments:
#   $1: user
#   $2: password
#   $3: file
#   $4: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_login() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local password="$2"
  local file="$3"
  local registry="$4"

  _bl64_cnt_login_put_password "$password" "$file" |
    bl64_cnt_run_docker \
      login \
      --username "$user" \
      --password-stdin \
      "$registry"
}

#######################################
# Command wrapper: podman login
#
# Arguments:
#   $1: user
#   $2: password
#   $3: file
#   $4: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_login() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local password="$2"
  local file="$3"
  local registry="$4"

  _bl64_cnt_login_put_password "$password" "$file" |
    bl64_cnt_run_podman \
      login \
      --username "$user" \
      --password-stdin \
      "$registry"
}

#######################################
# Open a container image using sh
#
# * Ignores entrypointt
#
# Arguments:
#   $1: container
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_run_sh() {
  bl64_dbg_lib_show_function "$@"
  local container="$1"

  bl64_check_parameter 'container' || return $?

  bl64_cnt_run_interactive --entrypoint 'sh' "$container"
}

#######################################
# Runs a container image using interactive settings
#
# * Allows signals
# * Attaches tty
#
# Arguments:
#   $@: arguments are passes as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_run_interactive "$@"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_run_interactive "$@"
  fi
}

#######################################
# Command wrapper: podman run
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_podman \
    run \
    --rm \
    --interactive \
    --tty \
    "$@"
}

#######################################
# Command wrapper: docker run
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_docker \
    run \
    --rm \
    --interactive \
    --tty \
    "$@"

}

#######################################
# Command wrapper: podman
#
# * Provides debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_run_podman() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose='error'

  bl64_check_module_setup "$BL64_CNT_MODULE" &&
    bl64_check_command "$BL64_CNT_CMD_PODMAN" ||
    return $?

  bl64_dbg_lib_command_enabled && verbose='debug'
  bl64_dbg_runtime_show_paths

  bl64_dbg_lib_trace_start
  "$BL64_CNT_CMD_PODMAN" \
    --log-level "$verbose" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper: docker
#
# * Provides debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_run_docker() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose='error'
  local debug=' '

  bl64_check_module_setup "$BL64_CNT_MODULE" &&
    bl64_check_command "$BL64_CNT_CMD_DOCKER" ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose='debug'
    debug='--debug'
  fi
  bl64_dbg_runtime_show_paths

  bl64_dbg_lib_trace_start
  "$BL64_CNT_CMD_DOCKER" \
    --log-level "$verbose" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Builds a container source
#
# Arguments:
#   $1: build context. Format: full path
#   $2: dockerfile path. Format: relative to the build context
#   $3: tag to be applied to the resulting source. Format: docker tag
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_build() {
  bl64_dbg_lib_show_function "$@"
  local context="$1"
  local file="${2:-Dockerfile}"
  local tag="${3:-latest}"

  bl64_check_parameter 'context' &&
    bl64_check_directory "$context" &&
    bl64_check_file "${context}/${file}" ||
    return $?

  # shellcheck disable=SC2164
  cd "${context}"

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_build "$file" "$tag"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_build "$file" "$tag"
  fi
}

#######################################
# Command wrapper: docker build
#
# Arguments:
#   $1: context
#   $2: file
#   $3: tag
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_build() {
  bl64_dbg_lib_show_function "$@"
  local file="$1"
  local tag="$2"

  bl64_cnt_run_docker \
    build \
    --no-cache \
    --rm \
    --tag "$tag" \
    --file "$file" \
    .
}

#######################################
# Command wrapper: podman build
#
# Arguments:
#   $1: context
#   $2: file
#   $3: tag
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_build() {
  bl64_dbg_lib_show_function "$@"
  local file="$1"
  local tag="$2"

  bl64_cnt_run_podman \
    build \
    --no-cache \
    --rm \
    --tag "$tag" \
    --file "$file" \
    .
}

#######################################
# Push a local source to the target container registry
#
# * Image is already present in the local destination
#
# Arguments:
#   $1: source. Format: IMAGE:TAG
#   $2: destination. Format: REPOSITORY/IMAGE:TAG
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' ||
    return $?

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_push "$source" "$destination"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_push "$source" "$destination"
  fi
}

#######################################
# Command wrapper: docker push
#
# Arguments:
#   $1: source
#   $2: destination
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_cnt_run_docker \
    tag \
    "$source" \
    "$destination"

  bl64_cnt_run_docker \
    push \
    "$destination"
}

#######################################
# Command wrapper: podman push
#
# Arguments:
#   $1: source
#   $2: destination
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_cnt_run_podman \
    push \
    "localhost/${source}" \
    "$destination"
}

#######################################
# Pull a remote container image to the local registry
#
# Arguments:
#   $1: source. Format: [REPOSITORY/]IMAGE:TAG
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_check_parameter 'source' ||
    return $?

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_pull "$source"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_pull "$source"
  fi
}

#######################################
# Command wrapper: docker pull
#
# Arguments:
#   $1: source
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_cnt_run_docker \
    pull \
    "${source}"
}

#######################################
# Command wrapper: podman pull
#
# Arguments:
#   $1: source
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_cnt_run_podman \
    pull \
    "${source}"
}

function _bl64_cnt_login_put_password() {
  local password="$1"
  local file="$2"

  if [[ "$password" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n' "$password"
  elif [[ "$file" != "$BL64_LIB_DEFAULT" ]]; then
    "$BL64_OS_CMD_CAT" "$file"
  fi

}

#######################################
# Assigns a new name to an existing image
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' ||
    return $?

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_tag "$source" "$target"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_tag "$source" "$target"
  fi
}

#######################################
# Command wrapper: docker tag
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_cnt_run_docker \
    tag \
    "$source" \
    "$target"
}

#######################################
# Command wrapper: podman tag
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_cnt_run_podman \
    tag \
    "$source" \
    "$target"
}

#######################################
# Runs a container image
#
# Arguments:
#   $@: arguments are passes as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_run() {
  bl64_dbg_lib_show_function "$@"

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_run "$@"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_run "$@"
  fi
}

#######################################
# Command wrapper: podman run
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_run() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_podman \
    run \
    --rm \
    "$@"
}

#######################################
# Command wrapper: docker run
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_run() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_docker \
    run \
    --rm \
    "$@"

}

#######################################
# BashLib64 / Module / Setup / Interact with GCP
#
# Version: 1.2.1
#######################################

#######################################
# Setup the bashlib64 module
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
function bl64_gcp_setup() {
  bl64_dbg_lib_show_function "$@"
  local gcloud_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$gcloud_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$gcloud_bin" ||
      return $?
  fi

  bl64_gcp_set_command "$gcloud_bin" &&
    bl64_gcp_set_options &&
    bl64_check_command "$BL64_GCP_CMD_GCLOUD" &&
    BL64_GCP_MODULE="$BL64_LIB_VAR_ON"

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
function bl64_gcp_set_command() {
  bl64_dbg_lib_show_function "$@"
  local gcloud_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$gcloud_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/gcloud' ]]; then
      gcloud_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/gcloud' ]]; then
      gcloud_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/gcloud' ]]; then
      gcloud_bin='/usr/local/bin'
    elif [[ -x '/usr/bin/gcloud' ]]; then
      gcloud_bin='/usr/bin'
    fi
  else
    [[ ! -x "${gcloud_bin}/gcloud" ]] && gcloud_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$gcloud_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${gcloud_bin}/gcloud" ]] && BL64_GCP_CMD_GCLOUD="${gcloud_bin}/gcloud"
  fi

  bl64_dbg_lib_show_vars 'BL64_GCP_CMD_GCLOUD'
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
function bl64_gcp_set_options() {
  bl64_dbg_lib_show_function

  BL64_GCP_SET_FORMAT_YAML='--format yaml'
  BL64_GCP_SET_FORMAT_TEXT='--format text'
  BL64_GCP_SET_FORMAT_JSON='--format json'
}

#######################################
# BashLib64 / Module / Functions / Interact with GCP
#
# Version: 1.3.0
#######################################

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_gcp_run_gcloud() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local debug=' '
  local config=' '

  bl64_check_module_setup "$BL64_GCP_MODULE" ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    debug='--verbosity debug --log-http'
  else
    debug='--verbosity none --quiet'
  fi

  bl64_gcp_blank_gcloud

  [[ "$BL64_GCP_CONFIGURATION_CREATED" == "$BL64_LIB_VAR_TRUE" ]] && config="--configuration $BL64_GCP_CONFIGURATION_NAME"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_GCP_CMD_GCLOUD" \
    $debug \
    $config \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Login to GCP using a Service Account
#
# * key must be in json format
# * previous credentials are revoked
#
# Arguments:
#   $1: key file full path
#   $2: project id
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_gcp_login_sa() {
  bl64_dbg_lib_show_function "$@"
  local key_file="$1"
  local project="$2"

  bl64_check_parameter 'key_file' &&
    bl64_check_parameter 'project' &&
    bl64_check_file "$key_file" || return $?

  _bl64_gcp_configure

  bl64_dbg_lib_show_info 'remove previous credentials'
  bl64_gcp_run_gcloud \
    auth \
    revoke \
    --all

  bl64_dbg_lib_show_info 'login to gcp'
  bl64_gcp_run_gcloud \
    auth \
    activate-service-account \
    --key-file "$key_file" \
    --project "$project"
}

function _bl64_gcp_configure() {
  bl64_dbg_lib_show_function

  if [[ "$BL64_GCP_CONFIGURATION_CREATED" == "$BL64_LIB_VAR_FALSE" ]]; then

    bl64_dbg_lib_show_info 'create BL64_GCP_CONFIGURATION'
    bl64_gcp_run_gcloud \
      config \
      configurations \
      create "$BL64_GCP_CONFIGURATION_NAME" &&
      BL64_GCP_CONFIGURATION_CREATED="$BL64_LIB_VAR_TRUE"

  else
    :
  fi
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
function bl64_gcp_blank_gcloud() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited _* shell variables'
  bl64_dbg_lib_trace_start
  unset CLOUDSDK_CONFIG
  unset CLOUDSDK_ACTIVE_CONFIG_NAME

  unset CLOUDSDK_AUTH_ACCESS_TOKEN_FILE
  unset CLOUDSDK_AUTH_DISABLE_CREDENTIALS
  unset CLOUDSDK_AUTH_IMPERSONATE_SERVICE_ACCOUNT
  unset CLOUDSDK_AUTH_TOKEN_HOST

  unset CLOUDSDK_CORE_ACCOUNT
  unset CLOUDSDK_CORE_CONSOLE_LOG_FORMAT
  unset CLOUDSDK_CORE_CUSTOM_CA_CERTS_FILE
  unset CLOUDSDK_CORE_DEFAULT_REGIONAL_BACKEND_SERVICE
  unset CLOUDSDK_CORE_DISABLE_COLOR
  unset CLOUDSDK_CORE_DISABLE_FILE_LOGGING
  unset CLOUDSDK_CORE_DISABLE_PROMPTS
  unset CLOUDSDK_CORE_DISABLE_USAGE_REPORTING
  unset CLOUDSDK_CORE_ENABLE_FEATURE_FLAGS
  unset CLOUDSDK_CORE_LOG_HTTP
  unset CLOUDSDK_CORE_MAX_LOG_DAYS
  unset CLOUDSDK_CORE_PASS_CREDENTIALS_TO_GSUTIL
  unset CLOUDSDK_CORE_PROJECT
  unset CLOUDSDK_CORE_SHOW_STRUCTURED_LOGS
  unset CLOUDSDK_CORE_TRACE_TOKEN
  unset CLOUDSDK_CORE_USER_OUTPUT_ENABLED
  unset CLOUDSDK_CORE_VERBOSITY
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# BashLib64 / Module / Setup / Interact with HLM
#
# Version: 1.1.0
#######################################

#######################################
# Setup the bashlib64 module
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
function bl64_hlm_setup() {
  bl64_dbg_lib_show_function "$@"
  local helm_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$helm_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$helm_bin" ||
      return $?
  fi

  bl64_hlm_set_command "$helm_bin" &&
    bl64_check_command "$BL64_HLM_CMD_HELM" &&
    bl64_hlm_set_options &&
    bl64_hlm_set_runtime &&
    BL64_HLM_MODULE="$BL64_LIB_VAR_ON"

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
function bl64_hlm_set_command() {
  bl64_dbg_lib_show_function "$@"
  local helm_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$helm_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/helm' ]]; then
      helm_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/helm' ]]; then
      helm_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/helm' ]]; then
      helm_bin='/usr/local/bin'
    elif [[ -x '/opt/helm/bin/helm' ]]; then
      helm_bin='/opt/helm/bin'
    elif [[ -x '/usr/bin/helm' ]]; then
      helm_bin='/usr/bin'
    fi
  else
    [[ ! -x "${helm_bin}/helm" ]] && helm_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$helm_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${helm_bin}/helm" ]] && BL64_HLM_CMD_HELM="${helm_bin}/helm"
  fi

  bl64_dbg_lib_show_vars 'BL64_HLM_CMD_HELM'
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
function bl64_hlm_set_options() {
  bl64_dbg_lib_show_function

  BL64_HLM_SET_DEBUG='--debug'
  BL64_HLM_SET_OUTPUT_TABLE='--output table'
  BL64_HLM_SET_OUTPUT_JSON='--output json'
  BL64_HLM_SET_OUTPUT_YAML='--output yaml'
}

#######################################
# Set runtime variables
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_hlm_set_runtime() {
  bl64_dbg_lib_show_function

  # Command timeout
  BL64_HLM_RUN_TIMEOUT='5m0s'
}

#######################################
# BashLib64 / Module / Functions / Interact with HLM
#
# Version: 1.1.0
#######################################

#######################################
# Add a helm repository to the local host
#
# Arguments:
#   $1: repository name
#   $2: repository source
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_hlm_repo_add() {
  bl64_dbg_lib_show_function "$@"
  local repository="${1:-${BL64_LIB_DEFAULT}}"
  local source="${2:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'repository' &&
    bl64_check_parameter 'source' ||
    return $?

  bl64_dbg_app_show_info "add helm repository (${repository})"
  bl64_hlm_run_helm \
    repo add \
    "$repository" \
    "$source" ||
    return $?

  bl64_dbg_app_show_info "try to update repository from source (${source})"
  bl64_hlm_run_helm repo update "$repository"

  return 0
}

#######################################
# Upgrade or install and existing chart
#
# Arguments:
#   $1: full path to the kube/config file with cluster credentials
#   $2: target namespace
#   $3: chart name
#   $4: chart source
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_hlm_chart_upgrade() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_LIB_DEFAULT}}"
  local namespace="${2:-${BL64_LIB_DEFAULT}}"
  local chart="${3:-${BL64_LIB_DEFAULT}}"
  local source="${4:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'kubeconfig' &&
    bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'chart' &&
    bl64_check_parameter 'source' &&
    bl64_check_file "$kubeconfig" ||
    return $?

  shift
  shift
  shift
  shift

  bl64_hlm_run_helm \
    upgrade \
    "$chart" \
    "$source" \
    --kubeconfig="$kubeconfig" \
    --namespace "$namespace" \
    --timeout "$BL64_HLM_RUN_TIMEOUT" \
    --atomic \
    --cleanup-on-fail \
    --install \
    --wait \
    "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_hlm_run_helm() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_HLM_MODULE" ||
    return $?

  bl64_dbg_lib_command_enabled && verbosity="$BL64_HLM_SET_DEBUG"
  bl64_hlm_blank_helm

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_HLM_CMD_HELM" \
    $verbosity \
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
function bl64_hlm_blank_helm() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited HELM_* shell variables'
  bl64_dbg_lib_trace_start
  unset HELM_CACHE_HOME
  unset HELM_CONFIG_HOME
  unset HELM_DATA_HOME
  unset HELM_DEBUG
  unset HELM_DRIVER
  unset HELM_DRIVER_SQL_CONNECTION_STRING
  unset HELM_MAX_HISTORY
  unset HELM_NAMESPACE
  unset HELM_NO_PLUGINS
  unset HELM_PLUGINS
  unset HELM_REGISTRY_CONFIG
  unset HELM_REPOSITORY_CACHE
  unset HELM_REPOSITORY_CONFIG
  unset HELM_KUBEAPISERVER
  unset HELM_KUBECAFILE
  unset HELM_KUBEASGROUPS
  unset HELM_KUBEASUSER
  unset HELM_KUBECONTEXT
  unset HELM_KUBETOKEN
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# BashLib64 / Module / Setup / Interact with Kubernetes
#
# Version: 1.0.0
#######################################

#######################################
# Setup the bashlib64 module
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
function bl64_k8s_setup() {
  bl64_dbg_lib_show_function "$@"
  local kubectl_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$kubectl_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$kubectl_bin" ||
      return $?
  fi

  bl64_k8s_set_command "$kubectl_bin" &&
    bl64_k8s_set_options &&
    bl64_check_command "$BL64_K8S_CMD_KUBECTL" &&
    BL64_K8S_MODULE="$BL64_LIB_VAR_ON" ||
    return $?

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
function bl64_k8s_set_command() {
  bl64_dbg_lib_show_function "$@"
  local kubectl_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$kubectl_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/kubectl' ]]; then
      kubectl_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/kubectl' ]]; then
      kubectl_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/kubectl' ]]; then
      kubectl_bin='/usr/local/bin'
    elif [[ -x '/usr/bin/kubectl' ]]; then
      kubectl_bin='/usr/bin'
    fi
  else
    [[ ! -x "${kubectl_bin}/kubectl" ]] && kubectl_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$kubectl_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${kubectl_bin}/kubectl" ]] && BL64_K8S_CMD_KUBECTL="${kubectl_bin}/kubectl"
  fi

  bl64_dbg_lib_show_vars 'BL64_K8S_CMD_KUBECTL'
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
function bl64_k8s_set_options() {
  bl64_dbg_lib_show_function

  BL64_K8S_SET_VERBOSE_NONE='--v=0'
  BL64_K8S_SET_VERBOSE_NORMAL='--v=2'
  BL64_K8S_SET_VERBOSE_DEBUG='--v=4'
  BL64_K8S_SET_VERBOSE_TRACE='--v=6'

  BL64_K8S_SET_OUTPUT_JSON='--output=json'
  BL64_K8S_SET_OUTPUT_YAML='--output=yaml'
  BL64_K8S_SET_OUTPUT_TXT='--output=wide'
}

#######################################
# BashLib64 / Module / Functions / Interact with Kubernetes
#
# Version: 1.1.1
#######################################

#######################################
# Set label on resource
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: resource type
#   $3: resource name
#   $4: label name
#   $5: label value
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_label_set() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_LIB_VAR_NULL}}"
  local resource="${2:-${BL64_LIB_VAR_NULL}}"
  local name="${3:-${BL64_LIB_VAR_NULL}}"
  local key="${4:-${BL64_LIB_VAR_NULL}}"
  local value="${5:-${BL64_LIB_VAR_NULL}}"

  bl64_check_parameter 'resource' &&
    bl64_check_parameter 'name' &&
    bl64_check_parameter 'key' &&
    bl64_check_parameter 'value' ||
    return $?

  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    label \
    --overwrite \
    "$resource" \
    "$name" \
    "$key"="$value"
}

#######################################
# Create namespace
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: namespace name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_namespace_create() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_LIB_VAR_NULL}}"
  local namespace="${2:-${BL64_LIB_VAR_NULL}}"

  bl64_check_parameter 'namespace' ||
    return $?

  bl64_k8s_run_kubectl "$kubeconfig" create namespace "$namespace"
}

#######################################
# Apply updates to resources based on definition file
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: namespace where resources are
#   $3: full path to the resource definition file
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_resource_update() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_LIB_VAR_NULL}}"
  local namespace="${2:-${BL64_LIB_VAR_NULL}}"
  local definition="${3:-${BL64_LIB_VAR_NULL}}"

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'definition' &&
    bl64_check_file "$definition" ||
    return $?

  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    --namespace "$namespace" \
    apply \
    --force='false' \
    --force-conflicts='false' \
    --grace-period='-1' \
    --overwrite='true' \
    --validate='strict' \
    --wait='true' \
    --filename="$definition"

}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_k8s_run_kubectl() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-}"
  local verbosity="$BL64_K8S_SET_VERBOSE_NONE"

  bl64_check_parameters_none "$#" &&
    bl64_check_parameter 'kubeconfig' &&
    bl64_check_file "$kubeconfig" &&
    bl64_check_module_setup "$BL64_K8S_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_K8S_SET_VERBOSE_NORMAL"
  bl64_dbg_lib_command_enabled && verbosity="$BL64_K8S_SET_VERBOSE_TRACE"

  bl64_k8s_blank_kubectl
  shift

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_K8S_CMD_KUBECTL" \
    --kubeconfig="$kubeconfig" \
    $verbosity \
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
function bl64_k8s_blank_kubectl() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited HELM_* shell variables'
  bl64_dbg_lib_trace_start
  unset POD_NAMESPACE
  unset KUBECONFIG
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# BashLib64 / Module / Setup / Interact with MongoDB
#
# Version: 1.1.0
#######################################

#######################################
# Setup the bashlib64 module
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
function bl64_mdb_setup() {
  bl64_dbg_lib_show_function "$@"
  local mdb_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$mdb_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$mdb_bin" ||
      return $?
  fi

  bl64_mdb_set_command "$mdb_bin" &&
    bl64_check_command "$BL64_MDB_CMD_MONGOSH" &&
    bl64_check_command "$BL64_MDB_CMD_MONGORESTORE" &&
    bl64_check_command "$BL64_MDB_CMD_MONGOEXPORT" &&
    bl64_mdb_set_options &&
    bl64_mdb_set_runtime &&
    BL64_MDB_MODULE="$BL64_LIB_VAR_ON"

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
function bl64_mdb_set_command() {
  bl64_dbg_lib_show_function "$@"
  local mdb_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$mdb_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/mongosh' ]]; then
      mdb_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/mongosh' ]]; then
      mdb_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/mongosh' ]]; then
      mdb_bin='/usr/local/bin'
    elif [[ -x '/opt/mongosh/bin/mongosh' ]]; then
      mdb_bin='/opt/mongosh/bin'
    elif [[ -x '/usr/bin/mongosh' ]]; then
      mdb_bin='/usr/bin'
    fi
  else
    [[ ! -x "${mdb_bin}/mongosh" ]] && mdb_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$mdb_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${mdb_bin}/mongosh" ]] && BL64_MDB_CMD_MONGOSH="${mdb_bin}/mongosh"
    [[ -x "${mdb_bin}/mongorestore" ]] && BL64_MDB_CMD_MONGORESTORE="${mdb_bin}/mongorestore"
    [[ -x "${mdb_bin}/mongoexport" ]] && BL64_MDB_CMD_MONGOEXPORT="${mdb_bin}/mongoexport"
  fi

  bl64_dbg_lib_show_vars 'BL64_MDB_CMD_MONGOSH'
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
function bl64_mdb_set_options() {
  bl64_dbg_lib_show_function

  BL64_MDB_SET_VERBOSE='--verbose'
  BL64_MDB_SET_QUIET='--quiet'
  BL64_MDB_SET_NORC='--norc'
}

#######################################
# Set runtime variables
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_mdb_set_runtime() {
  bl64_dbg_lib_show_function

  # Write concern defaults
  BL64_MDB_REPLICA_WRITE='majority'
  BL64_MDB_REPLICA_TIMEOUT='1000'
}

#######################################
# BashLib64 / Module / Setup / Interact with MongoDB
#
# Version: 1.0.0
#######################################

#######################################
# Restore mongodb dump
#
# * Restore user must exist on authdb and have restore permissions on the target DB
#
# Arguments:
#   $1: full path to the dump file
#   $2: target db name
#   $3: authdb name
#   $4: restore user name
#   $5: restore user password
#   $6: host where mongodb is
#   $7: mongodb tcp port
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_mdb_dump_restore() {
  bl64_dbg_lib_show_function "$@"
  local dump="${1:-${BL64_LIB_DEFAULT}}"
  local db="${2:-${BL64_LIB_DEFAULT}}"
  local authdb="${3:-${BL64_LIB_DEFAULT}}"
  local user="${4:-${BL64_LIB_DEFAULT}}"
  local password="${5:-${BL64_LIB_DEFAULT}}"
  local host="${6:-${BL64_LIB_DEFAULT}}"
  local port="${7:-${BL64_LIB_DEFAULT}}"
  local include=' '

  bl64_check_parameter 'dump' &&
    bl64_check_directory "$dump" ||
    return $?

  [[ "$db" != "$BL64_LIB_DEFAULT" ]] && include="--nsInclude=${db}.*" && db="--db=${db}" || db=' '
  [[ "$user" != "$BL64_LIB_DEFAULT" ]] && user="--username=${user}" || user=' '
  [[ "$password" != "$BL64_LIB_DEFAULT" ]] && password="--password=${password}" || password=' '
  [[ "$host" != "$BL64_LIB_DEFAULT" ]] && host="--host=${host}" || host=' '
  [[ "$port" != "$BL64_LIB_DEFAULT" ]] && port="--port=${port}" || port=' '
  [[ "$authdb" != "$BL64_LIB_DEFAULT" ]] && authdb="--authenticationDatabase=${authdb}" || authdb=' '

  # shellcheck disable=SC2086
  bl64_mdb_run_mongorestore \
    --writeConcern="{ w: '${BL64_MDB_REPLICA_WRITE}', j: true, wtimeout: ${BL64_MDB_REPLICA_TIMEOUT} }" \
    --stopOnError \
    $db \
    $include \
    $user \
    $password \
    $host \
    $port \
    $authdb \
    --dir="$dump"

}

#######################################
# Grants role to use in target DB
#
# * You must have the grantRole action on a database to grant a role on that database.
#
# Arguments:
#   $1: connection URI
#   $2: role name
#   $3: user name
#   $4: db where user and role are. Default: admin.
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_mdb_role_grant() {
  bl64_dbg_lib_show_function "$@"
  local uri="${1:-${BL64_LIB_DEFAULT}}"
  local role="${2:-${BL64_LIB_DEFAULT}}"
  local user="${3:-${BL64_LIB_DEFAULT}}"
  local db="${4:-admin}"

  bl64_check_parameter 'uri' &&
    bl64_check_parameter 'role' &&
    bl64_check_parameter 'user' ||
    return $?

  printf 'db.grantRolesToUser(
      "%s",
      [ { role: "%s", db: "%s" } ],
      { w: "%s", j: true, wtimeout: %s }
    );\n' "$user" "$role" "$db" "$BL64_MDB_REPLICA_WRITE" "$BL64_MDB_REPLICA_TIMEOUT" |
    bl64_mdb_run_mongosh "$uri"

}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $1: connection URI
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_mdb_run_mongosh_eval() {
  bl64_dbg_lib_show_function "$@"
  local uri="${1:-}"
  local verbosity="$BL64_MDB_SET_QUIET"

  shift
  bl64_check_parameters_none "$#" &&
    bl64_check_parameter 'uri' &&
    bl64_check_module_setup "$BL64_MDB_MODULE" ||
    return $?

  bl64_dbg_lib_command_enabled && verbosity="$BL64_MDB_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_MDB_CMD_MONGOSH" \
    $verbosity \
    $BL64_MDB_SET_NORC \
    "$uri" \
    --eval="$*"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
# * Warning: if no command is providded the tool will stay waiting for input from STDIN
#
# Arguments:
#   $1: connection URI
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_mdb_run_mongosh() {
  bl64_dbg_lib_show_function "$@"
  local uri="${1:-${BL64_LIB_DEFAULT}}"
  local verbosity="$BL64_MDB_SET_QUIET"

  shift
  bl64_check_parameter 'uri' &&
    bl64_check_module_setup "$BL64_MDB_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_MDB_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_MDB_CMD_MONGOSH" \
    $verbosity \
    $BL64_MDB_SET_NORC \
    "$uri" \
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
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_mdb_run_mongorestore() {
  bl64_dbg_lib_show_function "$@"
  local verbosity="$BL64_MDB_SET_QUIET"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_MDB_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_MDB_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_MDB_CMD_MONGORESTORE" \
    $verbosity \
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
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_mdb_run_mongoexport() {
  bl64_dbg_lib_show_function "$@"
  local verbosity="$BL64_MDB_SET_QUIET"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_MDB_MODULE" ||
    return $?

  bl64_msg_lib_verbose_enabled && verbosity="$BL64_MDB_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_MDB_CMD_MONGOEXPORT" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# BashLib64 / Module / Setup / Interact with Terraform
#
# Version: 1.1.0
#######################################

#######################################
# Setup the bashlib64 module
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
function bl64_tf_setup() {
  bl64_dbg_lib_show_function "$@"
  local terraform_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$terraform_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$terraform_bin" ||
      return $?
  fi

  bl64_tf_set_command "$terraform_bin" &&
    bl64_check_command "$BL64_TF_CMD_TERRAFORM" &&
    bl64_tf_set_options &&
    bl64_tf_set_definitions &&
    BL64_TF_MODULE="$BL64_LIB_VAR_ON" ||
    return $?

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
function bl64_tf_set_command() {
  bl64_dbg_lib_show_function "$@"
  local terraform_bin="${1:-}"

  if [[ "$terraform_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/terraform' ]]; then
      terraform_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/terraform' ]]; then
      terraform_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/terraform' ]]; then
      terraform_bin='/usr/local/bin'
    elif [[ -x '/usr/bin/terraform' ]]; then
      terraform_bin='/usr/bin'
    fi
  else
    [[ ! -x "${terraform_bin}/terraform" ]] && terraform_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$terraform_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${terraform_bin}/terraform" ]] && BL64_TF_CMD_TERRAFORM="${terraform_bin}/terraform"
  fi

  bl64_dbg_lib_show_vars 'BL64_TF_CMD_TERRAFORM'
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
function bl64_tf_set_options() {
  bl64_dbg_lib_show_function

  # TF_LOG values
  BL64_TF_SET_LOG_TRACE='TRACE'
  BL64_TF_SET_LOG_DEBUG='DEBUG'
  BL64_TF_SET_LOG_INFO='INFO'
  BL64_TF_SET_LOG_WARN='WARN'
  BL64_TF_SET_LOG_ERROR='ERROR'
  BL64_TF_SET_LOG_OFF='OFF'
}

#######################################
# Create command sets for common options
#
# Arguments:
#   $1: full path to the log file
#   $2: log level. One of BL64_TF_SET_LOG_*
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_tf_log_set() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-$BL64_LIB_VAR_NULL}"
  local level="${2:-$BL64_TF_SET_LOG_INFO}"

  bl64_check_parameter 'path' &&
    bl64_check_module_setup "$BL64_TF_MODULE" ||
    return $?

  BL64_TF_LOG_PATH="$path"
  BL64_TF_LOG_LEVEL="$level"
}

#######################################
# Declare version specific definitions
#
# * Use to capture default file names, values, attributes, etc
# * Do not use to capture CLI flags. Use *_set_options instead
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_tf_set_definitions() {
  bl64_dbg_lib_show_function

  # Terraform configuration lock file name
  BL64_TF_DEF_PATH_LOCK='.terraform.lock.hcl'

  # Runtime directory created by terraform init
  BL64_TF_DEF_PATH_RUNTIME='.terraform'

  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with Terraform
#
# Version: 1.1.0
#######################################

#######################################
# Run terraform output
#
# Arguments:
#   $1: output format. One of BL64_TF_OUTPUT_*
#   $2: (optional) variable name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_tf_output_export() {
  bl64_dbg_lib_show_function "$@"
  local format="${1:-}"
  local variable="${2:-}"

  case "$format" in
  "$BL64_TF_OUTPUT_RAW") format='-raw' ;;
  "$BL64_TF_OUTPUT_JSON") format='-json' ;;
  "$BL64_TF_OUTPUT_TEXT") format='' ;;
  *) bl64_check_alert_undefined ;;
  esac

  # shellcheck disable=SC2086
  bl64_tf_run_terraform \
    output \
    -no-color \
    $format \
    "$variable"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_tf_run_terraform() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_TF_MODULE" ||
    return $?

  bl64_tf_blank_terraform

  export TF_LOG="$BL64_TF_LOG_LEVEL"
  export TF_LOG_PATH="$BL64_TF_LOG_PATH"
  bl64_dbg_lib_show_vars 'TF_LOG' 'TF_LOG_PATH'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_TF_CMD_TERRAFORM" \
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
function bl64_tf_blank_terraform() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited TF_* shell variables'
  bl64_dbg_lib_trace_start
  unset TF_LOG
  unset TF_LOG_PATH
  unset TF_CLI_CONFIG_FILE
  unset TF_LOG
  unset TF_LOG_PATH
  unset TF_IN_AUTOMATION
  unset TF_INPUT
  unset TF_DATA_DIR
  unset TF_PLUGIN_CACHE_DIR
  unset TF_REGISTRY_DISCOVERY_RETRY
  unset TF_REGISTRY_CLIENT_TIMEOUT
  bl64_dbg_lib_trace_stop

  return 0
}

