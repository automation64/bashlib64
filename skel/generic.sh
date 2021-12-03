#!/bin/bash
#######################################
# X_CODE_PURPOSE_X
#
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
# Returns:
#   0: successfull execution
#   >0: error
#
# Author: X_AUTHOR_ALIAS_X (X_AUTHOR_GIT_URL_X)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: X_PROJECT_GIT_URL_X
# Version: X_CODE_VERSION_X
#######################################

#
# Imports
#

SHELL64_LIB='X_SHELL64_LIB_LOCATION_X'
source "${SHELL64_LIB}/shell64.bash"

#
# Exports
#

declare -xr X_NAMESPACE_SCRIPT_X_X_EXPORT_RO_X=''
declare -x X_NAMESPACE_SCRIPT_X_X_EXPORT_X=''

#
# Functions
#

function X_NAMESPACE_SCRIPT_X_X_FUNCTION_COMMAND_X() {

  local flag="$1"
  local option="$2"
  local status=1

  return $status

}

#######################################
# Check requirements and prerequisites
#
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Failed check description
# Returns:
#   0: check ok
#   1: requirements not met
#######################################
function X_NAMESPACE_SCRIPT_X_check() {

  local result=1

  return $result

}

#######################################
# Show script usage description
#
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Command line format and description
# Returns:
#   0
#######################################
function X_NAMESPACE_SCRIPT_X_help() {

  shell64_msg_show_usage \
    'X_CODE_PURPOSE_CLI_X' \
    'X_CODE_PURPOSE_X' \
    'X_CODE_PURPOSE_COMMANDSX' \
    'X_CODE_PURPOSE_FLAGSX' \
    'X_CODE_PURPOSE_PARAMETERSX'

}

#
# Main
#

declare X_NAMESPACE_SCRIPT_X_status=1
declare X_NAMESPACE_SCRIPT_X_command=''
declare X_NAMESPACE_SCRIPT_X_X_OPTION_X=''
declare X_NAMESPACE_SCRIPT_X_X_FLAG_X='0'
declare X_NAMESPACE_SCRIPT_X_option=''

(( $# == 0 )) && X_NAMESPACE_SCRIPT_X_help && exit 1
while getopts ':xy:zh' X_NAMESPACE_SCRIPT_X_option; do
  case "$X_NAMESPACE_SCRIPT_X_option" in
  x)
    X_NAMESPACE_SCRIPT_X_command='X_NAMESPACE_SCRIPT_X_X_FUNCTION_COMMAND_X'
    ;;
  y)
    X_NAMESPACE_SCRIPT_X_X_OPTION_X="$OPTARG"
    ;;
  z)
    X_NAMESPACE_SCRIPT_X_X_FLAG_X='1'
    ;;
  h)
    X_NAMESPACE_SCRIPT_X_help && exit
    ;;
  \?)
    X_NAMESPACE_SCRIPT_X_help && exit 1
    ;;
  esac
done
[[ -z "$X_NAMESPACE_SCRIPT_X_command" ]] && X_NAMESPACE_SCRIPT_X_help && exit 1
[[ -z "$X_NAMESPACE_SCRIPT_X_X_OPTION_X" ]] && X_NAMESPACE_SCRIPT_X_help && exit 1
X_NAMESPACE_SCRIPT_X_check || exit 1

"$X_NAMESPACE_SCRIPT_X_command" "$X_NAMESPACE_SCRIPT_X_X_FLAG_X" "$X_NAMESPACE_SCRIPT_X_X_OPTION_X"

X_NAMESPACE_SCRIPT_X_status=$?
exit $X_NAMESPACE_SCRIPT_X_status
