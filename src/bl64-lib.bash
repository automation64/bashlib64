#######################################
# BashLib64 / Setup script run-time environment
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.8.0
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
  bl64_os_set_command
  bl64_os_set_options
  bl64_os_set_alias
  bl64_iam_set_command
  bl64_iam_set_alias
  bl64_pkb_set_command
  bl64_pkg_set_options
  bl64_pkb_set_alias
  bl64_rbac_set_command
  bl64_rbac_set_alias
  bl64_vcs_set_command
  bl64_vcs_set_options
  bl64_vcs_set_alias
  bl64_rxtx_set_command
  bl64_rxtx_set_options
  bl64_rxtx_set_alias
  bl64_py_set_command
  bl64_py_set_options

  # Set signal handlers
  # shellcheck disable=SC2064
  if [[ "$BL64_LIB_TRAPS" == "$BL64_LIB_VAR_ON" ]]; then
    trap "$BL64_LIB_SIGNAL_HUP" 'SIGHUP'
    trap "$BL64_LIB_SIGNAL_STOP" 'SIGINT'
    trap "$BL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
    trap "$BL64_LIB_SIGNAL_QUIT" 'SIGTERM'
    trap "$BL64_LIB_SIGNAL_DEBUG" 'DEBUG'
    trap "$BL64_LIB_SIGNAL_EXIT" 'EXIT'
    trap "$BL64_LIB_SIGNAL_ERR" 'ERR'
  fi

  # Enable command mode: the library can be used as a stand-alone script to run embeded functions
  if [[ "$BL64_LIB_CMD" == "$BL64_LIB_VAR_ON" ]]; then
    "$@"
  else
    :
  fi
fi
