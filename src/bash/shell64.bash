#!/bin/bash
#######################################
# Bash library / Shell64 / Prepare the script for using shell64 libraries
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/shell64
# Version: 1.0.1
#######################################

[[ -n "$SHELL64_LIB_DEBUG" && "$SHELL64_LIB_DEBUG" == '1' ]] && set -x

declare -gx LANG
declare -gx LC_ALL
declare -gx LANGUAGE
declare -gx SHELL64_LIB="${SHELL64_LIB:-${0%%/*}}"
declare -gx SHELL64_LIB_DEBUG="${SHELL64_LIB_DEBUG:-0}"
declare -gx SHELL64_LIB_STRICT="${SHELL64_LIB_STRICT:-1}"
declare -gx SHELL64_LIB_LANG="${SHELL64_LIB_LANG:-1}"
declare -gx SHELL64_LIB_SIGNAL_HUP="${SHELL64_LIB_SIGNAL_HUP:--}"
declare -gx SHELL64_LIB_SIGNAL_STOP="${SHELL64_LIB_SIGNAL_STOP:--}"
declare -gx SHELL64_LIB_SIGNAL_QUIT="${SHELL64_LIB_SIGNAL_QUIT:--}"
declare -gx SHELL64_SCRIPT_NAME="${SHELL64_SCRIPT_NAME:-${0##*/}}"
declare -gx SHELL64_SCRIPT_SID="${BASHPID}"
declare -gx SHELL64_LIB_VAR_NULL='__s64__'
declare -gx SHELL64_LIB_VAR_TBD='TBD'

if [[ ! -r "$SHELL64_LIB/shell64.bash" ]]; then
  printf '%s\n' "Fatal: unable to identify shell64.bash base path. Please set the SHELL64_LIB variable." >&2
  exit 1
fi

set -o pipefail

if [[ "$SHELL64_LIB_STRICT" == '1' ]]; then
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
trap "$SHELL64_LIB_SIGNAL_HUP" 'SIGHUP'
# shellcheck disable=SC2064
trap "$SHELL64_LIB_SIGNAL_STOP" 'SIGINT'
# shellcheck disable=SC2064
trap "$SHELL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
# shellcheck disable=SC2064
trap "$SHELL64_LIB_SIGNAL_QUIT" 'SIGTERM'

declare -gx TERM="${TERM:-vt100}"

# shellcheck disable=SC1091
. "$SHELL64_LIB/shell64_os.bash"

shell64_os_get_distro

case $SHELL64_OS_DISTRO in
UBUNTU-* | FEDORA-* | CENTOS-* | OL-* | DEBIAN-*)
  if [[ "$SHELL64_LIB_LANG" == '1' ]]; then
    LANG='C'
    LC_ALL='C'
    LANGUAGE='C'
  fi
  ;;
*)
  printf '%s\n' "Fatal: shell64 is not supported in the current OS" >&2
  exit 1
  ;;
esac

shell64_os_set_command
shell64_os_set_alias

# shellcheck disable=SC1091
. "$SHELL64_LIB/shell64_msg.bash"
# shellcheck disable=SC1091
. "$SHELL64_LIB/shell64_log.bash"

:
