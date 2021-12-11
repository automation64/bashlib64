#!/bin/bash
#######################################
# Create the BashLib64 stand-alone distributable file
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
#######################################

source './.env' || exit 1
source "${DEVBL64_BIN}/bashlib64.bash" || exit 1

function devbl64_build_prod_build() {

  local status=1
  local project_bl64_file=''
  local project_bl64_lib="$DEVBL64_BUILD/bashlib64.bash"
  local project_bl64_modules='os fmt msg log check pkg'

  bl64_msg_show_task "creating stand-alone library: $project_bl64_lib"
  "$BL64_OS_CMD_CAT" "$DEVBL64_SRC/bl64-core.header" >"$project_bl64_lib"
  for project_bl64_file in $project_bl64_modules; do
    bl64_msg_show_task "adding module $project_bl64_file environment"
    bl64_fmt_strip_comments "${DEVBL64_SRC}/bl64-${project_bl64_file}.env" >>"$project_bl64_lib" || true
  done

  for project_bl64_file in $project_bl64_modules; do
    bl64_msg_show_task "adding module $project_bl64_file code"
    bl64_fmt_strip_comments "${DEVBL64_SRC}/bl64-${project_bl64_file}.bash" >>"$project_bl64_lib" || true
  done

  bl64_msg_show_task 'adding core'
  bl64_fmt_strip_comments "$DEVBL64_SRC/bl64-core.env" >>"$project_bl64_lib"
  bl64_fmt_strip_comments "$DEVBL64_SRC/bl64-core.bash" >>"$project_bl64_lib"
  status=$?

  return $status

}

function devbl64_build_prod_check() {

  :

}

function devbl64_build_prod_help() {
  bl64_msg_show_usage \
    '-b [-h]' \
    'Create the BashLib64 stand-alone distributable file' \
    '
    -b         : Build' '' ''
}

#
# Main
#

declare devbl64_build_prod_status=1
declare devbl64_build_prod_command=''
declare devbl64_build_prod_option=''

(($# == 0)) && devbl64_build_prod_help && exit 1
while getopts ':bh' devbl64_build_prod_option; do
  case "$devbl64_build_prod_option" in
  b)
    devbl64_build_prod_command='devbl64_build_prod_build'
    devbl64_build_prod_command_tag='build stand-alone library'
    ;;
  h)
    devbl64_build_prod_help && exit
    ;;
  \?)
    devbl64_build_prod_help && exit 1
    ;;
  esac
done
[[ -z "$devbl64_build_prod_command" ]] && devbl64_build_prod_help && exit 1
devbl64_build_prod_check || exit 1

bl64_msg_show_info "starting ${devbl64_build_prod_command_tag} process"
case "$devbl64_build_prod_command" in
'devbl64_build_prod_build') "$devbl64_build_prod_command";;
esac
devbl64_build_prod_status=$?

if ((devbl64_build_prod_status == 0)); then
  bl64_msg_show_info "${devbl64_build_prod_command_tag} process complete"
else
  bl64_msg_show_info "${devbl64_build_prod_command_tag} process complete with errors (error: $devbl64_build_prod_status)"
fi

exit $devbl64_build_prod_status
