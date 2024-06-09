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
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
  bl64_dbg_lib_show_function "$@"
  local aws_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  bl64_lib_module_imported 'BL64_CHECK_MODULE' &&
    bl64_lib_module_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    bl64_lib_module_imported 'BL64_MSG_MODULE' &&
    bl64_lib_module_imported 'BL64_FS_MODULE' &&
    _bl64_aws_set_command "$aws_bin" &&
    _bl64_aws_set_options &&
    _bl64_aws_set_resources &&
    bl64_check_command "$BL64_AWS_CMD_AWS" &&
    bl64_aws_set_paths &&
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
  local aws_bin="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$aws_bin" == "$BL64_VAR_DEFAULT" ]]; then
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
    else
      bl64_check_alert_resource_not_found 'aws-cli'
      return $?
    fi
  fi

  bl64_check_directory "$aws_bin" || return $?
  [[ -x "${aws_bin}/aws" ]] && BL64_AWS_CMD_AWS="${aws_bin}/aws"

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
  bl64_dbg_lib_show_function
  bl64_aws_set_paths
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
  bl64_fs_create_dir "$BL64_AWS_CLI_MODE" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$aws_home" || return $?

  bl64_dbg_lib_show_info 'set configuration paths'
  BL64_AWS_CLI_HOME="$aws_home"
  BL64_AWS_CLI_CACHE="${BL64_AWS_CLI_HOME}/${BL64_AWS_DEF_SUFFIX_CACHE}"
  BL64_AWS_CLI_CONFIG="${BL64_AWS_CLI_HOME}/${configuration}.${BL64_AWS_DEF_SUFFIX_CONFIG}"
  BL64_AWS_CLI_CREDENTIALS="${BL64_AWS_CLI_HOME}/${credentials}.${BL64_AWS_DEF_SUFFIX_CREDENTIALS}"

  bl64_dbg_lib_show_vars 'BL64_AWS_CLI_HOME' 'BL64_AWS_CLI_CACHE' 'BL64_AWS_CLI_CONFIG' 'BL64_AWS_CLI_CREDENTIALS'
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
  bl64_dbg_lib_show_vars 'BL64_AWS_CLI_REGION'
  return 0
}

#######################################
# Set profile credential information
#
# * CLI access mode will be set to use the target profile
# * The profile must be already configure, no check is done to verify it
#
# Arguments:
#   $1: Profile name
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_set_access_profile() {
  bl64_dbg_lib_show_function "$@"
  local profile_name="${1:-}"
  bl64_check_parameter 'profile_name' || return $?
  BL64_AWS_ACCESS_PROFILE="$profile_name"
  BL64_AWS_ACCESS_MODE="$BL64_AWS_ACCESS_MODE_PROFILE"
  bl64_dbg_lib_show_vars 'BL64_AWS_ACCESS_MODE' 'BL64_AWS_ACCESS_PROFILE'
  return 0
}

#######################################
# Set sso credential information
#
# * CLI access mode will be set to use the target SSO profile
# * The profile must be already configure, no check is done to verify it
#
# Arguments:
#   $1: Profile name
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_set_access_sso() {
  bl64_dbg_lib_show_function "$@"
  local profile_name="${1:-}"
  bl64_check_parameter 'profile_name' || return $?
  BL64_AWS_ACCESS_PROFILE="$profile_name"
  BL64_AWS_ACCESS_MODE="$BL64_AWS_ACCESS_MODE_SSO"
  bl64_dbg_lib_show_vars 'BL64_AWS_ACCESS_MODE' 'BL64_AWS_ACCESS_PROFILE'
  return 0
}

#######################################
# Set Key credential information
#
# * CLI access mode will be set to use IAM API Keys
#
# Arguments:
#   $1: Key ID
#   $2: Key Secret
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_set_access_key() {
  bl64_dbg_lib_show_function "$@"
  local key_id="${1:-}"
  local key_secret="${2:-}"
  bl64_check_parameter 'key_id' &&
    bl64_check_parameter 'key_secret' || return $?
  BL64_AWS_ACCESS_KEY_ID="$key_id"
  BL64_AWS_ACCESS_KEY_SECRET="$key_secret"
  BL64_AWS_ACCESS_MODE="$BL64_AWS_ACCESS_MODE_KEY"
  bl64_dbg_lib_show_vars 'BL64_AWS_ACCESS_MODE' 'BL64_AWS_ACCESS_KEY_ID'
  return 0
}

#######################################
# Set session token credential information
#
# * CLI access mode will be set to use session token
#
# Arguments:
#   $1: Key ID
#   $2: Key Secret
#   $3: Token
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_set_access_token() {
  bl64_dbg_lib_show_function "$@"
  local key_id="${1:-}"
  local key_secret="${2:-}"
  local token="${3:-}"
  bl64_check_parameter 'key_id' &&
    bl64_check_parameter 'key_secret' &&
    bl64_check_parameter 'token' || return $?
  BL64_AWS_ACCESS_KEY_ID="$key_id"
  BL64_AWS_ACCESS_KEY_SECRET="$key_secret"
  BL64_AWS_ACCESS_KEY_TOKEN="$token"
  BL64_AWS_ACCESS_MODE="$BL64_AWS_ACCESS_MODE_TOKEN"
  bl64_dbg_lib_show_vars 'BL64_AWS_ACCESS_MODE' 'BL64_AWS_ACCESS_KEY_ID' 'BL64_AWS_ACCESS_KEY_TOKEN'
  return 0
}
