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
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be sourced at the end' && return 21
  bl64_dbg_lib_show_function "$@"
  local terraform_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_tf_set_command "$terraform_bin" &&
    bl64_check_command "$BL64_TF_CMD_TERRAFORM" &&
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
  local terraform_bin="$1"

  if [[ "$terraform_bin" == "$BL64_VAR_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/terraform' ]]; then
      terraform_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/terraform' ]]; then
      terraform_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/terraform' ]]; then
      terraform_bin='/usr/local/bin'
    elif [[ -x '/usr/bin/terraform' ]]; then
      terraform_bin='/usr/bin'
    else
      bl64_check_alert_resource_not_found 'terraform'
      return $?
    fi
  fi

  bl64_check_directory "$terraform_bin" || return $?
  [[ -x "${terraform_bin}/terraform" ]] && BL64_TF_CMD_TERRAFORM="${terraform_bin}/terraform"

  bl64_dbg_lib_show_vars 'BL64_TF_CMD_TERRAFORM'
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

  bl64_dbg_lib_show_info "run terraforn to obtain ansible-core version"
  cli_version="$("$BL64_TF_CMD_TERRAFORM" --version | bl64_txt_run_awk '/^Terraform v[0-9.]+$/ { gsub( /v/, "" ); print $2 }')"
  bl64_dbg_lib_show_vars 'cli_version'

  if [[ -n "$cli_version" ]]; then
    # shellcheck disable=SC2034
    BL64_TF_VERSION_CLI="$cli_version"
  else
    bl64_msg_show_error "failed to get terraform CLI version (${BL64_TF_CMD_TERRAFORM} --version)"
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  bl64_dbg_lib_show_vars 'BL64_TF_VERSION_CLI'
  return 0
}
