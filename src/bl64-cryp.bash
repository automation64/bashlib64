#######################################
# BashLib64 / Module / Functions / Cryptography tools
#######################################

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_gpg() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=''

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_GPG" || return $?

  bl64_msg_lib_verbose_enabled && verbosity='--verbose'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_CRYP_CMD_GPG" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_openssl() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_OPENSSL" || return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_CRYP_CMD_OPENSSL" \
    "$@"
  bl64_dbg_lib_trace_stop
}
