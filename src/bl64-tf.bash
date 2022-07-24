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
