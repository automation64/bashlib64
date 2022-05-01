#######################################
# BashLib64 / Interact with container engines
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
#######################################

#######################################
# Runs a container image using interactive settings
#
# * Uses best match for container engine (docker, podman)
# * Allows signals
# * Attaches tty
#
# Arguments:
#   $@: arguments are passes as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_run_interactive "$@"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_run_interactive "$@"
  else
    bl64_msg_show_error "$_BL64_CNT_TXT_NO_CLI ($BL64_CNT_CMD_DOCKER. $BL64_CNT_CMD_PODMAN)"
    return $BL64_LIB_ERROR_APP_MISSING
  fi
}

#######################################
# Command wrapper: podman run
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_podman \
    run \
    --rm \
    --interactive \
    --tty \
    "$@"
}

#######################################
# Command wrapper: docker run
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_docker \
    run \
    --rm \
    --interactive \
    --tty \
    "$@"

}

#######################################
# Command wrapper: podman
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_run_podman() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_command "$BL64_CNT_CMD_PODMAN" || return $?

  "$BL64_CNT_CMD_PODMAN" "$@"
}

#######################################
# Command wrapper: docker
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_run_docker() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_command "$BL64_CNT_CMD_DOCKER" || return $?

  "$BL64_CNT_CMD_DOCKER" "$@"
}
