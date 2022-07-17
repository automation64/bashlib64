#######################################
# BashLib64 / Module / Functions / Interact with AWS
#
# Version: 1.0.0
#######################################

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

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_AWS_MODULE" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_AWS_CMD_AWS" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}
