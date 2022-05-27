#######################################
# BashLib64 / Module / Functions / Setup script run-time environment
#
# Version: 1.13.0
#######################################

#
# Main
#

# Do not inherit sensitive environment variables
unset MAIL
unset ENV
unset IFS

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

# Detect current OS
bl64_os_get_distro

# Verify lib compatibility
if [[ "$BL64_OS_DISTRO" == "$BL64_OS_UNK" || ("${BASH_VERSINFO[0]}" != '4' && "${BASH_VERSINFO[0]}" != '5') ]]; then
  printf '%s\n' "Fatal: BashLib64 is not supported in the current OS (distro:[${BL64_OS_DISTRO}] / bash:[${BASH_VERSION}] / uname:[$(uname -a))])" >&2
  # Warning: return and exit are not used to avoid terminating the shell when using source to load the lib
  false
else
  bl64_os_setup &&
    bl64_txt_setup &&
    bl64_fs_setup &&
    bl64_arc_setup &&
    bl64_iam_setup &&
    bl64_pkg_setup &&
    bl64_rbac_setup &&
    bl64_vcs_setup &&
    bl64_rxtx_setup

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

  # Capture script path
  BL64_SCRIPT_PATH="$(cd -- "${BASH_SOURCE[0]%/*}" >/dev/null 2>&1 && pwd)"

  # Enable command mode: the library can be used as a stand-alone script to run embeded functions
  if [[ "$BL64_LIB_CMD" == "$BL64_LIB_VAR_ON" ]]; then
    bl64_dbg_lib_show_info 'run bashlib64 in command mode'
    "$@"
  else
    bl64_dbg_lib_show_info 'run bashlib64 in source mode'
    :
  fi
fi
