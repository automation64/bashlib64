#######################################
# BashLib64 / Setup script run-time environment
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.7.0
#######################################

#
# Main
#

# Set strict mode for enhanced security
if [[ "$BL64_LIB_STRICT" == '1' ]]; then
  set -u
  set -p
fi

# Set signal handlers
# shellcheck disable=SC2064
trap "$BL64_LIB_SIGNAL_HUP" 'SIGHUP'
# shellcheck disable=SC2064
trap "$BL64_LIB_SIGNAL_STOP" 'SIGINT'
# shellcheck disable=SC2064
trap "$BL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
# shellcheck disable=SC2064
trap "$BL64_LIB_SIGNAL_QUIT" 'SIGTERM'

# Normalize terminal settings
export TERM="${TERM:-vt100}"

# Normalize locales to C
if [[ "$BL64_LIB_LANG" == '1' ]]; then
  export LANG='C'
  export LC_ALL='C'
  export LANGUAGE='C'
fi

# Detect current OS
bl64_os_get_distro

# Verify lib compatibility
if [[ "$BL64_OS_DISTRO" == "$BL64_OS_UNK" || ("${BASH_VERSINFO[0]}" != '4' && "${BASH_VERSINFO[0]}" != '5') ]]; then
  printf '%s\n' "Fatal: BashLib64 is not supported in the current OS (distro:[${BL64_OS_DISTRO}] / bash:[${BASH_VERSION}] / uname:[$(uname -a))])" >&2
  false
else
  # Load commands and aliases
  bl64_os_set_command
  bl64_os_set_options
  bl64_os_set_alias
  bl64_iam_set_command
  bl64_iam_set_alias
  bl64_pkb_set_command
  bl64_pkb_set_alias
  bl64_rbac_set_command
  bl64_rbac_set_alias
  bl64_vcs_set_command
  bl64_vcs_set_alias
  bl64_rxtx_set_command
  bl64_rxtx_set_alias
  bl64_py_set_command
  bl64_py_set_options

  # Enable command mode: the library can be used as a stand-alone script to run embeded functions
  if [[ "$BL64_LIB_CMD" == "$BL64_LIB_VAR_ON" ]]; then
    "$@"
  else
    :
  fi
fi
