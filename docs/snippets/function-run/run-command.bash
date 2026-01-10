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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_X_MODULE_X_run_X_COMMAND_X() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_X_MODULE_ID_X_MODULE' &&
    # optional # bl64_check_privilege_root &&
    bl64_check_command "$BL64_X_MODULE_ID_X_CMD_X_CMD_X" ||
    return $?

  # optional # bl64_msg_app_detail_is_enabled && verbosity='X_VERBOSE_FLAG_X'
  # optional # bl64_dbg_lib_command_is_enabled && verbosity='X_DEBUG_FLAG_X'

  # optional # bl64_X_MODULE_X_blank_ansible

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_X_MODULE_ID_X_CMD_X_CMD_X" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}
