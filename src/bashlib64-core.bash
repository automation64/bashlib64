#!/bin/bash
#######################################
# BashLib64 / Prepare the script for using bl64 libraries
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bl64
# Version: 1.0.2
#######################################

[[ -n "$BL64_LIB_DEBUG" && "$BL64_LIB_DEBUG" == '1' ]] && set -x

declare -gx LANG
declare -gx LC_ALL
declare -gx LANGUAGE
declare -gx BL64_LIB="${BL64_LIB:-${0%%/*}}"
declare -gx BL64_LIB_DEBUG="${BL64_LIB_DEBUG:-0}"
declare -gx BL64_LIB_STRICT="${BL64_LIB_STRICT:-1}"
declare -gx BL64_LIB_LANG="${BL64_LIB_LANG:-1}"
declare -gx BL64_LIB_SIGNAL_HUP="${BL64_LIB_SIGNAL_HUP:--}"
declare -gx BL64_LIB_SIGNAL_STOP="${BL64_LIB_SIGNAL_STOP:--}"
declare -gx BL64_LIB_SIGNAL_QUIT="${BL64_LIB_SIGNAL_QUIT:--}"
declare -gx BL64_SCRIPT_NAME="${BL64_SCRIPT_NAME:-${0##*/}}"
declare -gx BL64_SCRIPT_SID="${BASHPID}"
declare -gx BL64_LIB_VAR_NULL='__s64__'
declare -gx BL64_LIB_VAR_TBD='TBD'

if [[ ! -r "$BL64_LIB/bashlib64.bash" ]]; then
  printf '%s\n' "Fatal: unable to identify bashlib64.bash base path. Please set the BL64_LIB variable." >&2
  exit 1
fi

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

declare -gx TERM="${TERM:-vt100}"

# shellcheck disable=SC1091
. "$BL64_LIB/bl64_os.bash"

bl64_os_get_distro

case $BL64_OS_DISTRO in
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

# shellcheck disable=SC1091
. "$BL64_LIB/bl64_msg.bash"
# shellcheck disable=SC1091
. "$BL64_LIB/bl64_log.bash"

:
