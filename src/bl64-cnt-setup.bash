#######################################
# BashLib64 / Module / Setup / Interact with container engines
#
# Version: 1.8.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: required in order to use the module
# * Check for core commands, fail if not available
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_cnt_setup() {
  bl64_dbg_lib_show_function
  local -i status=0

  _bl64_cnt_set_command &&
    _bl64_cnt_set_options &&
    bl64_cnt_set_paths
  status=$?
  if ((status == 0)); then
    if [[ ! -x "$BL64_CNT_CMD_DOCKER" && ! -x "$BL64_CNT_CMD_PODMAN" ]]; then
      bl64_msg_show_error "unable to find a container manager (${BL64_CNT_CMD_DOCKER}, ${BL64_CNT_CMD_PODMAN})"
      status=$BL64_LIB_ERROR_APP_MISSING
    else
      BL64_CNT_MODULE="$BL64_VAR_ON"
    fi
  fi

  ((status == 0))
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
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-*)
    BL64_CNT_CMD_PODMAN='/usr/bin/podman'
    BL64_CNT_CMD_DOCKER='/usr/bin/docker'
    ;;
  ${BL64_OS_MCOS}-*)
    # Podman is not available for MacOS
    BL64_CNT_CMD_PODMAN="$BL64_VAR_INCOMPATIBLE"
    # Docker is available using docker-desktop
    BL64_CNT_CMD_DOCKER='/usr/local/bin/docker'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
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

  BL64_CNT_SET_DOCKER_VERSION='version'
  BL64_CNT_SET_DOCKER_QUIET='--quiet'
  BL64_CNT_SET_DOCKER_FILTER='--filter'

  BL64_CNT_SET_PODMAN_VERSION='version'
  BL64_CNT_SET_PODMAN_QUIET='--quier'
  BL64_CNT_SET_PODMAN_FILTER='--filter'

  return 0
}

#######################################
# Set and prepare module paths
#
# * Global paths only
# * If preparation fails the whole module fails
#
# Arguments:
#   $1: configuration file name
#   $2: credential file name
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
# shellcheck disable=SC2120
function bl64_cnt_set_paths() {
  bl64_dbg_lib_show_function "$@"

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-*)
    BL64_CNT_PATH_DOCKER_SOCKET='/var/run/docker.sock'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_CNT_PATH_DOCKER_SOCKET='/var/run/docker.sock'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac

  bl64_dbg_lib_show_vars 'BL64_CNT_PATH_DOCKER_SOCKET'
  return 0
}
