#!/bin/bash
#######################################
# X_APP_INFO_X
#
# Author: X_AUTHOR_ALIAS_X (X_AUTHOR_GIT_URL_X)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: X_PROJECT_GIT_URL_X
# Version: X_APP_VERSION_X
#######################################

source "${X_PATH_TO_LIB_X}/bashlib64.bash" || exit 1

readonly X_APP_NAMESPACE_X_X_EXPORT_RO_X=''
export X_APP_NAMESPACE_X_X_EXPORT_X=''

function X_APP_NAMESPACE_X_X_FUNCTION_COMMAND_X() {

  local flag="$1"
  local option="$2"
  local status=1

  return $status

}

function X_APP_NAMESPACE_X_check() {

  local result=1

  return $result

}

function X_APP_NAMESPACE_X_help() {

  bl64_msg_show_usage \
    'X_APP_NAME_CLI_X' \
    'X_APP_INFO_X' \
    'X_APP_COMMANDS_X' \
    'X_APP_FLAGS_X' \
    'X_APP_PARAMETERS_X'

}

#
# Main
#

declare X_APP_NAMESPACE_X_status=1
declare X_APP_NAMESPACE_X_command=''
declare X_APP_NAMESPACE_X_X_OPTION_X=''
declare X_APP_NAMESPACE_X_X_FLAG_X='0'
declare X_APP_NAMESPACE_X_option=''

(( $# == 0 )) && X_APP_NAMESPACE_X_help && exit 1
while getopts ':xy:zh' X_APP_NAMESPACE_X_option; do
  case "$X_APP_NAMESPACE_X_option" in
  x)
    X_APP_NAMESPACE_X_command='X_APP_NAMESPACE_X_X_FUNCTION_COMMAND_X'
    ;;
  y)
    X_APP_NAMESPACE_X_X_OPTION_X="$OPTARG"
    ;;
  z)
    X_APP_NAMESPACE_X_X_FLAG_X='1'
    ;;
  h)
    X_APP_NAMESPACE_X_help && exit
    ;;
  \?)
    X_APP_NAMESPACE_X_help && exit 1
    ;;
  esac
done
[[ -z "$X_APP_NAMESPACE_X_command" ]] && X_APP_NAMESPACE_X_help && exit 1
[[ -z "$X_APP_NAMESPACE_X_X_OPTION_X" ]] && X_APP_NAMESPACE_X_help && exit 1
X_APP_NAMESPACE_X_check || exit 1

"$X_APP_NAMESPACE_X_command" "$X_APP_NAMESPACE_X_X_FLAG_X" "$X_APP_NAMESPACE_X_X_OPTION_X"

X_APP_NAMESPACE_X_status=$?
exit $X_APP_NAMESPACE_X_status
