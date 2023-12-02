#######################################
# BashLib64 / Module / Setup / Manage local filesystem
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
function bl64_fs_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21

  bl64_lib_module_imported 'BL64_CHECK_MODULE' &&
    bl64_lib_module_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    bl64_lib_module_imported 'BL64_MSG_MODULE' &&
    bl64_lib_module_imported 'BL64_FMT_MODULE' &&
    _bl64_fs_set_command &&
    _bl64_fs_set_alias &&
    _bl64_fs_set_options &&
    BL64_FS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'fs'
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
function _bl64_fs_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_FS_CMD_CHMOD='/bin/chmod'
    BL64_FS_CMD_CHOWN='/bin/chown'
    BL64_FS_CMD_CP='/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/bin/ln'
    BL64_FS_CMD_LS='/bin/ls'
    BL64_FS_CMD_MKDIR='/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/bin/mktemp'
    BL64_FS_CMD_MV='/bin/mv'
    BL64_FS_CMD_RM='/bin/rm'
    BL64_FS_CMD_TOUCH='/usr/bin/touch'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_FS_CMD_CHMOD='/usr/bin/chmod'
    BL64_FS_CMD_CHOWN='/usr/bin/chown'
    BL64_FS_CMD_CP='/usr/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/bin/ln'
    BL64_FS_CMD_LS='/usr/bin/ls'
    BL64_FS_CMD_MKDIR='/usr/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
    BL64_FS_CMD_MV='/usr/bin/mv'
    BL64_FS_CMD_RM='/usr/bin/rm'
    BL64_FS_CMD_TOUCH='/usr/bin/touch'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_FS_CMD_CHMOD='/usr/bin/chmod'
    BL64_FS_CMD_CHOWN='/usr/bin/chown'
    BL64_FS_CMD_CP='/usr/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/usr/bin/ln'
    BL64_FS_CMD_LS='/usr/bin/ls'
    BL64_FS_CMD_MKDIR='/usr/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
    BL64_FS_CMD_MV='/usr/bin/mv'
    BL64_FS_CMD_RM='/usr/bin/rm'
    BL64_FS_CMD_TOUCH='/usr/bin/touch'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_FS_CMD_CHMOD='/bin/chmod'
    BL64_FS_CMD_CHOWN='/bin/chown'
    BL64_FS_CMD_CP='/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/bin/ln'
    BL64_FS_CMD_LS='/bin/ls'
    BL64_FS_CMD_MKDIR='/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/bin/mktemp'
    BL64_FS_CMD_MV='/bin/mv'
    BL64_FS_CMD_RM='/bin/rm'
    BL64_FS_CMD_TOUCH='/bin/touch'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_FS_CMD_CHMOD='/bin/chmod'
    BL64_FS_CMD_CHOWN='/usr/sbin/chown'
    BL64_FS_CMD_CP='/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/bin/ln'
    BL64_FS_CMD_LS='/bin/ls'
    BL64_FS_CMD_MKDIR='/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
    BL64_FS_CMD_MV='/bin/mv'
    BL64_FS_CMD_RM='/bin/rm'
    BL64_FS_CMD_TOUCH='/usr/bin/touch'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
# * BL64_FS_SET_MKTEMP_TMPDIR: not using long form (--) as it requires =
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_fs_set_options() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
    BL64_FS_SET_CHMOD_VERBOSE='--verbose'
    BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
    BL64_FS_SET_CHOWN_VERBOSE='--verbose'
    BL64_FS_SET_CP_FORCE='--force'
    BL64_FS_SET_CP_RECURSIVE='--recursive'
    BL64_FS_SET_CP_VERBOSE='--verbose'
    BL64_FS_SET_FIND_NAME='-name'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_FORCE='--force'
    BL64_FS_SET_LN_SYMBOLIC='--symbolic'
    BL64_FS_SET_LN_VERBOSE='--verbose'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='--parents'
    BL64_FS_SET_MKDIR_VERBOSE='--verbose'
    BL64_FS_SET_MKTEMP_DIRECTORY='--directory'
    BL64_FS_SET_MKTEMP_QUIET='--quiet'
    BL64_FS_SET_MKTEMP_TMPDIR='-p'
    BL64_FS_SET_MV_FORCE='--force'
    BL64_FS_SET_MV_VERBOSE='--verbose'
    BL64_FS_SET_RM_FORCE='--force'
    BL64_FS_SET_RM_RECURSIVE='--recursive'
    BL64_FS_SET_RM_VERBOSE='--verbose'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
    BL64_FS_SET_CHMOD_VERBOSE='--verbose'
    BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
    BL64_FS_SET_CHOWN_VERBOSE='--verbose'
    BL64_FS_SET_CP_FORCE='--force'
    BL64_FS_SET_CP_RECURSIVE='--recursive'
    BL64_FS_SET_CP_VERBOSE='--verbose'
    BL64_FS_SET_FIND_NAME='-name'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_FORCE='--force'
    BL64_FS_SET_LN_SYMBOLIC='--symbolic'
    BL64_FS_SET_LN_VERBOSE='--verbose'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='--parents'
    BL64_FS_SET_MKDIR_VERBOSE='--verbose'
    BL64_FS_SET_MKTEMP_DIRECTORY='--directory'
    BL64_FS_SET_MKTEMP_QUIET='--quiet'
    BL64_FS_SET_MKTEMP_TMPDIR='-p'
    BL64_FS_SET_MV_FORCE='--force'
    BL64_FS_SET_MV_VERBOSE='--verbose'
    BL64_FS_SET_RM_FORCE='--force'
    BL64_FS_SET_RM_RECURSIVE='--recursive'
    BL64_FS_SET_RM_VERBOSE='--verbose'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
    BL64_FS_SET_CHMOD_VERBOSE='--verbose'
    BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
    BL64_FS_SET_CHOWN_VERBOSE='--verbose'
    BL64_FS_SET_CP_FORCE='--force'
    BL64_FS_SET_CP_RECURSIVE='--recursive'
    BL64_FS_SET_CP_VERBOSE='--verbose'
    BL64_FS_SET_FIND_NAME='-name'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_FORCE='--force'
    BL64_FS_SET_LN_SYMBOLIC='--symbolic'
    BL64_FS_SET_LN_VERBOSE='--verbose'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='--parents'
    BL64_FS_SET_MKDIR_VERBOSE='--verbose'
    BL64_FS_SET_MKTEMP_DIRECTORY='--directory'
    BL64_FS_SET_MKTEMP_QUIET='--quiet'
    BL64_FS_SET_MKTEMP_TMPDIR='-p'
    BL64_FS_SET_MV_FORCE='--force'
    BL64_FS_SET_MV_VERBOSE='--verbose'
    BL64_FS_SET_RM_FORCE='--force'
    BL64_FS_SET_RM_RECURSIVE='--recursive'
    BL64_FS_SET_RM_VERBOSE='--verbose'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='-R'
    BL64_FS_SET_CHMOD_VERBOSE='-v'
    BL64_FS_SET_CHOWN_RECURSIVE='-R'
    BL64_FS_SET_CHOWN_VERBOSE='-v'
    BL64_FS_SET_CP_FORCE='-f'
    BL64_FS_SET_CP_RECURSIVE='-R'
    BL64_FS_SET_CP_VERBOSE='-v'
    BL64_FS_SET_FIND_NAME='-name'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_FORCE='-f'
    BL64_FS_SET_LN_SYMBOLIC='-s'
    BL64_FS_SET_LN_VERBOSE='-v'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='-p'
    BL64_FS_SET_MKDIR_VERBOSE=' '
    BL64_FS_SET_MKTEMP_DIRECTORY='-d'
    BL64_FS_SET_MKTEMP_QUIET='-q'
    BL64_FS_SET_MKTEMP_TMPDIR='-p'
    BL64_FS_SET_MV_FORCE='-f'
    BL64_FS_SET_MV_VERBOSE=' '
    BL64_FS_SET_RM_FORCE='-f'
    BL64_FS_SET_RM_RECURSIVE='-R'
    BL64_FS_SET_RM_VERBOSE=' '
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='-R'
    BL64_FS_SET_CHMOD_VERBOSE='-v'
    BL64_FS_SET_CHOWN_RECURSIVE='-R'
    BL64_FS_SET_CHOWN_VERBOSE='-v'
    BL64_FS_SET_CP_FORCE='-f'
    BL64_FS_SET_CP_RECURSIVE='-R'
    BL64_FS_SET_CP_VERBOSE='-v'
    BL64_FS_SET_FIND_NAME='-name'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_FORCE='-f'
    BL64_FS_SET_LN_SYMBOLIC='-s'
    BL64_FS_SET_LN_VERBOSE='-v'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='-p'
    BL64_FS_SET_MKDIR_VERBOSE='-v'
    BL64_FS_SET_MKTEMP_DIRECTORY='-d'
    BL64_FS_SET_MKTEMP_QUIET='-q'
    BL64_FS_SET_MKTEMP_TMPDIR='-p'
    BL64_FS_SET_MV_FORCE='-f'
    BL64_FS_SET_MV_VERBOSE='-v'
    BL64_FS_SET_RM_FORCE='-f'
    BL64_FS_SET_RM_RECURSIVE='-R'
    BL64_FS_SET_RM_VERBOSE='-v'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
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
# shellcheck disable=SC2034
function _bl64_fs_set_alias() {
  local cmd_mawk='/usr/bin/mawk'

  BL64_FS_ALIAS_CHOWN_DIR="${BL64_FS_CMD_CHOWN} ${BL64_FS_SET_CHOWN_VERBOSE} ${BL64_FS_SET_CHOWN_RECURSIVE}"
  BL64_FS_ALIAS_CP_DFIND="/usr/bin/find"
  BL64_FS_ALIAS_CP_DIR="${BL64_FS_CMD_CP} ${BL64_FS_SET_CP_VERBOSE} ${BL64_FS_SET_CP_FORCE} ${BL64_FS_SET_CP_RECURSIVE}"
  BL64_FS_ALIAS_CP_FIFIND="/usr/bin/find"
  BL64_FS_ALIAS_CP_FILE="${BL64_FS_CMD_CP} ${BL64_FS_SET_CP_VERBOSE} ${BL64_FS_SET_CP_FORCE}"
  BL64_FS_ALIAS_LN_FORCE="--force"
  BL64_FS_ALIAS_LN_SYMBOLIC="${BL64_FS_CMD_LN} ${BL64_FS_SET_LN_SYMBOLIC} ${BL64_FS_SET_LN_VERBOSE}"
  BL64_FS_ALIAS_LS_FILES="${BL64_FS_CMD_LS} ${BL64_FS_SET_LS_NOCOLOR}"
  BL64_FS_ALIAS_MKDIR_FULL="${BL64_FS_CMD_MKDIR} ${BL64_FS_SET_MKDIR_VERBOSE} ${BL64_FS_SET_MKDIR_PARENTS}"
  BL64_FS_ALIAS_MKTEMP_DIR="${BL64_FS_CMD_MKTEMP} -d"
  BL64_FS_ALIAS_MKTEMP_FILE="${BL64_FS_CMD_MKTEMP}"
  BL64_FS_ALIAS_MV="${BL64_FS_CMD_MV} ${BL64_FS_SET_MV_VERBOSE} ${BL64_FS_SET_MV_FORCE}"
  BL64_FS_ALIAS_MV="${BL64_FS_CMD_MV} ${BL64_FS_SET_MV_VERBOSE} ${BL64_FS_SET_MV_FORCE}"
  BL64_FS_ALIAS_RM_FILE="${BL64_FS_CMD_RM} ${BL64_FS_SET_RM_VERBOSE} ${BL64_FS_SET_RM_FORCE}"
  BL64_FS_ALIAS_RM_FULL="${BL64_FS_CMD_RM} ${BL64_FS_SET_RM_VERBOSE} ${BL64_FS_SET_RM_FORCE} ${BL64_FS_SET_RM_RECURSIVE}"
}
