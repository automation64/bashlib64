#######################################
# BashLib64 / Module / Setup / Interact with container engines
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: required in order to use the module
# * Check for core commands, fail if not available
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_cnt_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local command_location="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_cnt_set_command "$command_location" &&
    _bl64_cnt_set_options &&
    BL64_CNT_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'cnt'
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_cnt_set_command() {
  bl64_dbg_lib_show_function "$@"
  local command_location="$1"

  _bl64_cnt_set_command_podman "$command_location" &&
    _bl64_cnt_set_command_docker "$command_location" ||
    return $?

  bl64_dbg_lib_show_comments 'detect and set current container driver'
  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    BL64_CNT_DRIVER="$BL64_CNT_DRIVER_DOCKER"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    BL64_CNT_DRIVER="$BL64_CNT_DRIVER_PODMAN"
  else
    bl64_msg_show_lib_error "unable to find a container manager CLI location (${BL64_CNT_CMD_DOCKER}, ${BL64_CNT_CMD_PODMAN})"
    return "$BL64_LIB_ERROR_APP_MISSING"
  fi
  bl64_dbg_lib_show_vars 'BL64_CNT_DRIVER'

  return 0
}

function _bl64_cnt_set_command_docker() {
  bl64_dbg_lib_show_function "$@"
  BL64_CNT_CMD_DOCKER="$(bl64_bsh_command_locate 'docker' "${HOME}/.rd/bin" "$@")"
  return 0
}

function _bl64_cnt_set_command_podman() {
  bl64_dbg_lib_show_function "$@"
  BL64_CNT_CMD_PODMAN="$(bl64_bsh_command_locate 'podman' "$@")"
  return 0
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_cnt_set_options() {
  bl64_dbg_lib_show_function

  #
  # Standard CLI flags
  #
  # * Common to both podman and docker
  #

  # shellcheck disable=SC2034
  BL64_CNT_SET_DEBUG='--debug' &&
    BL64_CNT_SET_ENTRYPOINT='--entrypoint' &&
    BL64_CNT_SET_FILE='--file' &&
    BL64_CNT_SET_FILTER='--filter' &&
    BL64_CNT_SET_INTERACTIVE='--interactive' &&
    BL64_CNT_SET_LOG_LEVEL='--log-level' &&
    BL64_CNT_SET_NO_CACHE='--no-cache' &&
    BL64_CNT_SET_PASSWORD_STDIN='--password-stdin' &&
    BL64_CNT_SET_PASSWORD='--password' &&
    BL64_CNT_SET_QUIET='--quiet' &&
    BL64_CNT_SET_RM='--rm' &&
    BL64_CNT_SET_TAG='--tag' &&
    BL64_CNT_SET_TTY='--tty' &&
    BL64_CNT_SET_USERNAME='--username' &&
    BL64_CNT_SET_VERSION='version'

  #
  # Common parameter values
  #
  # * Common to both podman and docker
  #

  # shellcheck disable=SC2034
  BL64_CNT_SET_FILTER_ID='{{.ID}}' &&
    BL64_CNT_SET_FILTER_NAME='{{.Names}}' &&
    BL64_CNT_SET_LOG_LEVEL_DEBUG='debug' &&
    BL64_CNT_SET_LOG_LEVEL_ERROR='error' &&
    BL64_CNT_SET_LOG_LEVEL_INFO='info' &&
    BL64_CNT_SET_STATUS_RUNNING='running'

  return 0
}
