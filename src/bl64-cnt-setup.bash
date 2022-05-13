#######################################
# BashLib64 / Module / Setup / Interact with container engines
#
# Version: 1.3.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
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

  bl64_cnt_set_command
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_cnt_set_command() {
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-*)
    BL64_CNT_CMD_PODMAN='/usr/bin/podman'
    BL64_CNT_CMD_DOCKER='/usr/bin/docker'
    ;;
  ${BL64_OS_MCOS}-*)
    # Podman is not available for MacOS
    BL64_CNT_CMD_PODMAN="$BL64_LIB_INCOMPATIBLE"
    # Docker is available using docker-desktop
    BL64_CNT_CMD_DOCKER='/usr/local/bin/docker'
    ;;
  *) bl64_check_show_unsupported ;;
  esac
}
