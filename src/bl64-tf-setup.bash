#######################################
# BashLib64 / Module / Setup / Interact with Terraform
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
function bl64_tf_setup() {
  bl64_dbg_lib_show_function "$@"
  local terraform_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$terraform_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$terraform_bin" ||
      return $?
  fi

  bl64_tf_set_command "$terraform_bin" &&
    bl64_tf_set_options &&
    bl64_check_command "$BL64_TF_CMD_TERRAFORM" &&
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
  local path="${1:-$BL64_LIB_DEFAULT}"
  local level="${2:-$BL64_TF_SET_LOG_INFO}"

  bl64_check_parameter 'path' &&
    bl64_check_module_setup "$BL64_TF_MODULE" ||
    return $?

  BL64_TF_LOG_PATH="$path"
  BL64_TF_LOG_LEVEL="$level"
}
