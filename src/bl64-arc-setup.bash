#######################################
# BashLib64 / Module / Setup / Manage archive files
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
function bl64_arc_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21

  bl64_lib_module_imported 'BL64_CHECK_MODULE' &&
    bl64_lib_module_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    bl64_lib_module_imported 'BL64_MSG_MODULE' &&
    bl64_lib_module_imported 'BL64_FS_MODULE' &&
    _bl64_arc_set_command &&
    _bl64_arc_set_options &&
    BL64_ARC_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'arc'
}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_arc_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_ARC_CMD_TAR='/usr/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
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
function _bl64_arc_set_options() {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_ARC_SET_TAR_VERBOSE='-v'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}
