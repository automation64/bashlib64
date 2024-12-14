#######################################
# BashLib64 / Module / Setup / Manage Version Control System
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
function bl64_vcs_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last sourced module' &&
    return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_API_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_vcs_set_command &&
    _bl64_vcs_set_options &&
    BL64_VCS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'vcs'
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
function _bl64_vcs_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
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
function _bl64_vcs_set_options() {
  bl64_dbg_lib_show_function
  # Common sets - unversioned
  BL64_VCS_SET_GIT_NO_PAGER='--no-pager'
  BL64_VCS_SET_GIT_QUIET=' '
}
