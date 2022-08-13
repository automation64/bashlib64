#######################################
# BashLib64 / Module / Functions / Setup script run-time environment
#
# Version: 2.2.0
#######################################

#
# Main
#

# Do not inherit sensitive environment variables
unset MAIL
unset ENV
unset IFS
unset TMPDIR

# Normalize terminal settings
TERM="${TERM:-vt100}"

# Normalize locales to C
if [[ "$BL64_LIB_LANG" == '1' ]]; then
  LANG='C'
  LC_ALL='C'
  LANGUAGE='C'
fi

# Set strict mode for enhanced security
if [[ "$BL64_LIB_STRICT" == '1' ]]; then
  set -o 'nounset'
  set -o 'privileged'
fi

# Ensure pipeline exit status is failed when any cmd fails
set -o 'pipefail'

# Enable error processing
set -o 'errtrace'
set -o 'functrace'

# Disable fast-fail. Developer must implement error handling (check for exit status)
set +o 'errexit'

# Reset bash set options to defaults
set -o 'braceexpand'
set -o 'hashall'
set +o 'allexport'
set +o 'histexpand'
set +o 'history'
set +o 'ignoreeof'
set +o 'monitor'
set +o 'noclobber'
set +o 'noglob'
set +o 'nolog'
set +o 'notify'
set +o 'onecmd'
set +o 'posix'

# Do not set/unset - Breaks bats-core
# set -o 'keyword'
# set -o 'noexec'

# Initialize mandatory modules
bl64_dbg_setup &&
  bl64_msg_setup &&
  bl64_bsh_setup &&
  bl64_os_setup &&
  bl64_txt_setup &&
  bl64_fs_setup &&
  bl64_arc_setup &&
  bl64_iam_setup &&
  bl64_pkg_setup &&
  bl64_rbac_setup &&
  bl64_vcs_setup &&
  bl64_rxtx_setup ||
  return $?

# Set signal handlers
# shellcheck disable=SC2064
if [[ "$BL64_LIB_TRAPS" == "$BL64_LIB_VAR_ON" ]]; then
  bl64_dbg_lib_show_info 'enable traps'
  trap "$BL64_LIB_SIGNAL_HUP" 'SIGHUP'
  trap "$BL64_LIB_SIGNAL_STOP" 'SIGINT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGTERM'
  trap "$BL64_LIB_SIGNAL_DEBUG" 'DEBUG'
  trap "$BL64_LIB_SIGNAL_EXIT" 'EXIT'
  trap "$BL64_LIB_SIGNAL_ERR" 'ERR'
fi

# Set default umask
bl64_fs_set_umask "$BL64_LIB_UMASK" || return $?

# Set script identity
bl64_bsh_script_set_identity

# Enable command mode: the library can be used as a stand-alone script to run embeded functions
if [[ "$BL64_LIB_CMD" == "$BL64_LIB_VAR_ON" ]]; then
  bl64_dbg_lib_show_info 'run bashlib64 in command mode'
  "$@"
else
  bl64_dbg_lib_show_info 'run bashlib64 in source mode'
  :
fi
