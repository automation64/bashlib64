#######################################
# BashLib64 / Module / Functions / Interact with Terraform
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_tf_log_set() {
  _bl64_lib_function_deprecated 'bl64_tf_log_set' 'bl64_tf_set_logging'
  bl64_tf_set_logging "$@"
}

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
function _bl64_tf_harden_terraform() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited TF_* shell variables'
  bl64_dbg_lib_trace_start
  unset TF_CLI_CONFIG_FILE
  unset TF_DATA_DIR
  unset TF_INPUT
  unset TF_PLUGIN_CACHE_DIR
  unset TF_REGISTRY_CLIENT_TIMEOUT
  unset TF_REGISTRY_DISCOVERY_RETRY

  export TF_IN_AUTOMATION='ON'
  export TF_LOG_PATH="$BL64_TF_PATH_LOG"
  export TF_LOG="$BL64_TF_CFG_LOG_LEVEL"
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_tf_harden_tofu() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited shell variables'
  bl64_dbg_lib_trace_start
  unset TF_CLI_ARGS
  unset TF_CLI_CONFIG_FILE
  unset TF_DATA_DIR
  unset TF_ENCRYPTION
  unset TF_INPUT
  unset TF_LOG_CORE
  unset TF_LOG_PROVIDER
  unset TF_PLUGIN_CACHE_DIR
  unset TF_PROVIDER_DOWNLOAD_RETRY
  unset TF_REGISTRY_CLIENT_TIMEOUT
  unset TF_REGISTRY_DISCOVERY_RETRY
  unset TF_STATE_PERSIST_INTERVAL
  unset TF_WORKSPACE
  unset TOFU_CPU_PROFILE

  export TF_IN_AUTOMATION='ON'
  export TF_LOG_PATH="$BL64_TF_PATH_LOG"
  export TF_LOG="$BL64_TF_CFG_LOG_LEVEL"
  bl64_dbg_lib_trace_stop

  return 0
}

#
# Public functions
#

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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_tf_output_export() {
  bl64_dbg_lib_show_function "$@"
  local format="${1:-}"
  local variable="${2:-}"

  case "$format" in
    "$BL64_TF_OUTPUT_RAW") format='-raw' ;;
    "$BL64_TF_OUTPUT_JSON") format='-json' ;;
    "$BL64_TF_OUTPUT_TEXT") format='' ;;
    *) bl64_check_rise_task_undefined ;;
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_tf_run_terraform() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TF_MODULE' &&
    _bl64_tf_harden_terraform
  return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_TF_CMD_TERRAFORM" \
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_tf_run_tofu() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TF_MODULE' &&
    _bl64_tf_harden_tofu ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TF_CMD_TOFU" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Set logging configuration
#
# * Path is not checked for existence as the tool will automatically create it
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
function bl64_tf_set_logging() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-$BL64_VAR_DEFAULT}"
  local level="${2:-$BL64_TF_SET_LOG_INFO}"

  ! bl64_lib_var_is_default "$path" && BL64_TF_PATH_LOG="$path"
  ! bl64_lib_var_is_default "$level" && BL64_TF_CFG_LOG_LEVEL="$level"
  return 0
}

#######################################
# Set runtime paths
#
# * Path is not checked for existence as the tool will automatically create it
#
# Arguments:
#   $1: (optional) plugin cache
# Outputs:
#   STDOUT: None
#   STDERR: requirement error
# Returns:
#   0: set ok
#   >0: set failed
#######################################
function bl64_tf_set_paths() {
  bl64_dbg_lib_show_function "$@"
  local plugin_cache="${1:-$BL64_VAR_DEFAULT}"
  # shellcheck disable=SC2034
  ! bl64_lib_var_is_default "$plugin_cache" && BL64_TF_PATH_PLUGIN_CACHE="$plugin_cache"
  return 0
}
