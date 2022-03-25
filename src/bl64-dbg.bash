#######################################
# BashLib64 / Show shell debugging information
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
#######################################

#######################################
# Enable shell function tracing
#
# Arguments:
#   $1: function name
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_function_start() { set +x
  local name="$1"

  [[ "$BL64_LIB_DEBUG" != "$BL64_DBG_TARGET_FNC" ]] && return
  [[ "${FUNCNAME[1]}" != "$name" ]] && return

  bl64_msg_show_debug "[${name}] start tracing function"
  bl64_msg_show_debug "[${name}] function source: line:${BASH_LINENO[1]}@file:${BASH_SOURCE[1]}"
  bl64_msg_show_debug "[${name}] function caller: ${FUNCNAME[2]}@line:${BASH_LINENO[2]}@file:${BASH_SOURCE[2]}"
  set -x

  return
}

#######################################
# Disable shell function tracing
#
# Arguments:
#   $1: function name
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_function_stop() {
  local name="$1"

  [[ "$BL64_LIB_DEBUG" != "$BL64_DBG_TARGET_FNC" ]] && return
  [[ "${FUNCNAME[1]}" != "$name" ]] && return
  set +x
  bl64_msg_show_debug "[${name}] stop tracing function"

  return
}
