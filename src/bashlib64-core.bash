#######################################
# BashLib64 / Prepare the script for using bl64 libraries
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bl64
# Version: 1.0.3
#######################################

#
# Main
#

set -o pipefail

if [[ "$BL64_LIB_STRICT" == '1' ]]; then
  unset -f unalias
  \unalias -a
  unset -f command
  unset MAIL
  unset ENV
  unset IFS
  set -u
  set -p
  set -e
fi

# shellcheck disable=SC2064
trap "$BL64_LIB_SIGNAL_HUP" 'SIGHUP'
# shellcheck disable=SC2064
trap "$BL64_LIB_SIGNAL_STOP" 'SIGINT'
# shellcheck disable=SC2064
trap "$BL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
# shellcheck disable=SC2064
trap "$BL64_LIB_SIGNAL_QUIT" 'SIGTERM'

export TERM="${TERM:-vt100}"

bl64_os_get_distro

case "$BL64_OS_DISTRO" in
UBUNTU-* | FEDORA-* | CENTOS-* | OL-* | DEBIAN-*)
  if [[ "$BL64_LIB_LANG" == '1' ]]; then
    LANG='C'
    LC_ALL='C'
    LANGUAGE='C'
  fi
  ;;
*)
  printf '%s\n' "Fatal: bl64 is not supported in the current OS" >&2
  exit 1
  ;;
esac

bl64_os_set_command
bl64_os_set_alias
:
