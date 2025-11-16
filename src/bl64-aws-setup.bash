#######################################
# BashLib64 / Module / Setup / Interact with AWS
#######################################

#
# Module attributes getters
#

function bl64_aws_get_cli_config() {
  bl64_dbg_lib_show_function
  bl64_check_module 'BL64_AWS_MODULE' || return $?
  echo "$BL64_AWS_CLI_CONFIG"
}

function bl64_aws_get_cli_credentials() {
  bl64_dbg_lib_show_function
  bl64_check_module 'BL64_AWS_MODULE' || return $?
  echo "$BL64_AWS_CLI_CREDENTIALS"
}

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: CLI Path. Format: Full path. Default: $PATH
#   $2: AWS_HOME. Format: full path. Default: AWS CLI default
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_aws_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local aws_bin="${1:-${BL64_VAR_DEFAULT}}"
  local aws_home="${2:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_aws_set_command "$aws_bin" &&
    bl64_check_command "$BL64_AWS_CMD_AWS" &&
    _bl64_aws_set_options &&
    _bl64_aws_set_resources &&
    _bl64_aws_set_runtime "$aws_home" &&
    BL64_AWS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'aws'
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
function _bl64_aws_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_AWS_CMD_AWS="$(bl64_bsh_command_locate 'aws' '/opt/aws/bin' "$@")"
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
function _bl64_aws_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  {
    BL64_AWS_SET_FORMAT_JSON='--output json'
    BL64_AWS_SET_FORMAT_TEXT='--output text'
    BL64_AWS_SET_FORMAT_TABLE='--output table'
    BL64_AWS_SET_FORMAT_YAML='--output yaml'
    BL64_AWS_SET_FORMAT_STREAM='--output yaml-stream'
    BL64_AWS_SET_DEBUG='--debug'
    BL64_AWS_SET_OUPUT_NO_PAGER='--no-cli-pager'
    BL64_AWS_SET_OUPUT_NO_COLOR='--color off'
    BL64_AWS_SET_INPUT_NO_PROMPT='--no-cli-auto-prompt'
  }
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
function _bl64_aws_set_resources() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  {
    BL64_AWS_DEF_SUFFIX_TOKEN='json'
    BL64_AWS_DEF_SUFFIX_HOME='.aws'
    BL64_AWS_DEF_SUFFIX_CACHE='sso/cache'
    BL64_AWS_DEF_SUFFIX_CONFIG='cfg'
    BL64_AWS_DEF_SUFFIX_CREDENTIALS='secret'
  }
  return 0
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: setting errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function _bl64_aws_set_runtime() {
  bl64_dbg_lib_show_function "$@"
  local aws_home="$1"
  bl64_aws_set_home "$aws_home" &&
    bl64_aws_set_paths "$aws_home"
}

#######################################
# Set AWS_HOME
#
# * Use a different path to avoid inheriting or altering user's current setup
# * Home is created if not present. Current user and groups are used
#
# Arguments:
#   $1: Full path. Default: $HOME/.aws
# Outputs:
#   STDOUT: verbose operation
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
# shellcheck disable=SC2120
function bl64_aws_set_home() {
  bl64_dbg_lib_show_function "$@"
  local aws_home="${1:-$BL64_VAR_DEFAULT}"

  if bl64_lib_var_is_default "$aws_home"; then
    bl64_check_home || return $?
    aws_home="${HOME}/${BL64_AWS_DEF_SUFFIX_HOME}"
  fi
  bl64_msg_show_lib_subtask "prepare AWS CLI home (${aws_home})"
  bl64_fs_dir_create "$BL64_AWS_CLI_MODE" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$aws_home" &&
    BL64_AWS_CLI_HOME="$aws_home"
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

  bl64_dbg_lib_show_info 'set configuration paths'
  BL64_AWS_CLI_CACHE="${BL64_AWS_CLI_HOME}/${BL64_AWS_DEF_SUFFIX_CACHE}"
  BL64_AWS_CLI_CONFIG="${BL64_AWS_CLI_HOME}/${configuration}.${BL64_AWS_DEF_SUFFIX_CONFIG}"
  BL64_AWS_CLI_CREDENTIALS="${BL64_AWS_CLI_HOME}/${credentials}.${BL64_AWS_DEF_SUFFIX_CREDENTIALS}"

  bl64_dbg_lib_show_vars 'BL64_AWS_CLI_CACHE' 'BL64_AWS_CLI_CONFIG' 'BL64_AWS_CLI_CREDENTIALS'
  return 0
}

#######################################
# Set AWS region
#
# * Use anytime you neeto to change the target region
#
# Arguments:
#   $1: AWS region
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_set_region() {
  bl64_dbg_lib_show_function "$@"
  local region="${1:-}"
  bl64_check_parameter 'region' || return $?
  BL64_AWS_CLI_REGION="$region"
  bl64_msg_show_lib_subtask "set AWS region (${BL64_AWS_CLI_REGION})"
  return 0
}
