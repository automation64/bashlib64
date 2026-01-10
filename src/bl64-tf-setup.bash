#######################################
# BashLib64 / Module / Setup / Interact with Terraform
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
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local terraform_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_tf_set_command "$terraform_bin" &&
    _bl64_tf_set_version &&
    _bl64_tf_set_options &&
    _bl64_tf_set_resources &&
    BL64_TF_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'tf'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: detection errors
# Returns:
#   0: command detected
#   >0: failed to detect command
#######################################
function _bl64_tf_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_TF_CMD_TERRAFORM="$(bl64_bsh_command_locate 'terraform' "$@")"
  BL64_TF_CMD_TOFU="$(bl64_bsh_command_locate 'tofu' "$@")"
  if [[ -z "$BL64_TF_CMD_TERRAFORM" && -z "$BL64_TF_CMD_TOFU" ]]; then
    bl64_msg_show_lib_error 'failed to detect terraform or tofu command. Please install it and try again.'
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi
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
function _bl64_tf_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  BL64_TF_SET_LOG_TRACE='TRACE' &&
    BL64_TF_SET_LOG_DEBUG='DEBUG' &&
    BL64_TF_SET_LOG_INFO='INFO' &&
    BL64_TF_SET_LOG_WARN='WARN' &&
    BL64_TF_SET_LOG_ERROR='ERROR' &&
    BL64_TF_SET_LOG_OFF='OFF'
}

#######################################
# Set logging configuration
#
# Arguments:
#   $1: full path to the log file. Default: STDERR
#   $2: log level. One of BL64_TF_SET_LOG_*. Default: INFO
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_tf_log_set() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-$BL64_VAR_DEFAULT}"
  local level="${2:-$BL64_TF_SET_LOG_INFO}"

  bl64_check_module 'BL64_TF_MODULE' ||
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
function _bl64_tf_set_resources() {
  bl64_dbg_lib_show_function

  # Terraform configuration lock file name
  # shellcheck disable=SC2034
  BL64_TF_DEF_PATH_LOCK='.terraform.lock.hcl'

  # Runtime directory created by terraform init
  # shellcheck disable=SC2034
  BL64_TF_DEF_PATH_RUNTIME='.terraform'

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
function _bl64_tf_set_version() {
  bl64_dbg_lib_show_function
  local cli_version=''

  if [[ -n "$BL64_TF_CMD_TERRAFORM" ]]; then
    cli_version="$("$BL64_TF_CMD_TERRAFORM" --version | bl64_txt_run_awk '/^Terraform v[0-9.]+$/ { gsub( /v/, "" ); print $2 }')"
  else
    cli_version="$("$BL64_TF_CMD_TOFU" --version | bl64_txt_run_awk '/^OpenTofu v[0-9.]+$/ { gsub( /v/, "" ); print $2 }')"
  fi
  bl64_dbg_lib_show_vars 'cli_version'

  if [[ -n "$cli_version" ]]; then
    # shellcheck disable=SC2034
    BL64_TF_VERSION_CLI="$cli_version"
  else
    bl64_msg_show_lib_error 'failed to get CLI version'
    return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
  fi

  bl64_dbg_lib_show_vars 'BL64_TF_VERSION_CLI'
  return 0
}
