#######################################
# BashLib64 / Module / Functions / Manage OS identity and access service
#######################################

#######################################
# Create local OS user
#
# * Wrapper for native user creation command
# * If the user is already created nothing is done, no error
#
# Arguments:
#   $1: login name
#   $2: (optional) home path. Format: full path. Default: os native
#   $3: (optional) primary group. Format: group name. Default: os native
#   $4: (optional) shell. Format: full path. Default: os native
#   $5: (optional) description. Default: none
#   $6: (optional) user ID. Default: os native
# Outputs:
#   STDOUT: native user add command output
#   STDERR: native user add command error messages
# Returns:
#   native user add command error status
#######################################
function bl64_iam_user_add() {
  bl64_dbg_lib_show_function "$@"
  local login="${1:-}"
  local home="${2:-$BL64_VAR_DEFAULT}"
  local group="${3:-$BL64_VAR_DEFAULT}"
  local shell="${4:-$BL64_VAR_DEFAULT}"
  local gecos="${5:-$BL64_VAR_DEFAULT}"
  local uid="${6:-$BL64_VAR_DEFAULT}"
  local password=''

  bl64_check_parameter 'login' ||
    return $?

  if bl64_iam_user_is_created "$login"; then
    bl64_msg_show_warning "${_BL64_IAM_TXT_EXISTING_USER} ($login)"
    return 0
  fi

  bl64_msg_show_lib_subtask "$_BL64_IAM_TXT_ADD_USER ($login)"
  [[ "$home" == "$BL64_VAR_DEFAULT" ]] && home=''
  [[ "$group" == "$BL64_VAR_DEFAULT" ]] && group=''
  [[ "$shell" == "$BL64_VAR_DEFAULT" ]] && shell=''
  [[ "$gecos" == "$BL64_VAR_DEFAULT" ]] && gecos=''
  [[ "$uid" == "$BL64_VAR_DEFAULT" ]] && uid=''
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_iam_run_useradd \
      ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
      ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
      ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
      ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
      ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
      $BL64_IAM_SET_USERADD_CREATE_HOME \
      "$login"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    bl64_iam_run_useradd \
      ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
      ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
      ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
      ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
      ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
      $BL64_IAM_SET_USERADD_CREATE_HOME \
      "$login"
    ;;
  ${BL64_OS_SLES}-*)
    bl64_dbg_lib_show_comments 'force primary group creation'
    bl64_iam_run_useradd \
      --user-group \
      ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
      ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
      ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
      ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
      ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
      $BL64_IAM_SET_USERADD_CREATE_HOME \
      "$login"
    ;;
  ${BL64_OS_ALP}-*)
    bl64_dbg_lib_show_comments 'disable automatic password generation'
    bl64_iam_run_adduser \
      ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
      ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
      ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
      ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
      ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
      $BL64_IAM_SET_USERADD_CREATE_HOME \
      -D \
      "$login"
    ;;
  ${BL64_OS_MCOS}-*)
    password="$(bl64_rnd_get_numeric)" || return $?
    bl64_iam_run_sysadminctl \
      ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
      ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
      ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
      ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
      ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
      $BL64_IAM_SET_USERADD_CREATE_HOME \
      -addUser "$login" \
      -password "$password"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create local user group
#
# Arguments:
#   $1: group name
#   $2: (optional) group ID
# Outputs:
#   STDOUT: Progress info
#   STDERR: Command execution error
# Returns:
#   0: group created ok
#   >0: failed to create group
#######################################
function bl64_iam_group_add() {
  bl64_dbg_lib_show_function "$@"
  local group_name="$1"
  local group_id="${2:-$BL64_VAR_DEFAULT}"

  bl64_check_parameter 'group_name' ||
    return $?

  if bl64_iam_group_is_created "$group_name"; then
    bl64_msg_show_warning "${_BL64_IAM_TXT_EXISTING_GROUP} ($group_name)"
    return 0
  fi

  bl64_msg_show_lib_subtask "$_BL64_IAM_TXT_ADD_GROUP ($group_name)"
  [[ "$group_id" == "$BL64_VAR_DEFAULT" ]] && group_id=''
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_iam_run_groupadd \
      ${group_id:+--gid ${group_id}} \
      "$group_name"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    bl64_iam_run_groupadd \
      ${group_id:+--gid ${group_id}} \
      "$group_name"
    ;;
  ${BL64_OS_SLES}-*)
    bl64_iam_run_groupadd \
      ${group_id:+--gid ${group_id}} \
      "$group_name"
    ;;
  ${BL64_OS_ALP}-*)
    bl64_iam_run_addgroup \
      ${group_id:+--gid ${group_id}} \
      "$group_name"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Determine if the user is created
#
# Arguments:
#   $1: login name
# Outputs:
#   STDOUT: None
#   STDERR: command error messages
# Returns:
#   0: it is
#   BL64_LIB_ERROR_IS_NOT
#   >0: command error status
#######################################
function bl64_iam_user_is_created() {
  bl64_dbg_lib_show_function "$@"
  local user_name="$1"

  bl64_check_parameter 'user_name' ||
    return $?

  bl64_iam_user_get_id "$user_name" >/dev/null 2>&1 ||
    return $BL64_LIB_ERROR_IS_NOT
}

#######################################
# Determine if the group is created
#
# Arguments:
#   $1: group name
# Outputs:
#   STDOUT: None
#   STDERR: command error messages
# Returns:
#   0: it is
#   BL64_LIB_ERROR_IS_NOT
#   >0: command error status
#######################################
function bl64_iam_group_is_created() {
  bl64_dbg_lib_show_function "$@"
  local group_name="$1"

  bl64_check_parameter 'group_name' ||
    return $?

  bl64_os_run_getent 'group' "$group_name" >/dev/null 2>&1 ||
    return $BL64_LIB_ERROR_IS_NOT
}

#######################################
# Get user's UID
#
# Arguments:
#   $1: user login name. Default: current user
# Outputs:
#   STDOUT: user ID
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_user_get_id() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"

  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_iam_run_id -u $user
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    bl64_iam_run_id -u $user
    ;;
  ${BL64_OS_SLES}-*)
    bl64_iam_run_id -u $user
    ;;
  ${BL64_OS_ALP}-*)
    bl64_iam_run_id -u $user
    ;;
  ${BL64_OS_MCOS}-*)
    bl64_iam_run_id -u $user
    ;;
  *) bl64_check_alert_unsupported ;;
  esac

}

#######################################
# Get current user name
#
# Arguments:
#   None
# Outputs:
#   STDOUT: user name
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_user_get_current() {
  bl64_dbg_lib_show_function
  bl64_iam_run_id -u -n
}

#######################################
# Check that the user is created
#
# Arguments:
#   $1: user name
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_USER_NOT_FOUND
#######################################
function bl64_iam_check_user() {
  bl64_dbg_lib_show_function "$@"
  local user="${1:-}"
  local message="${2:-${_BL64_IAM_TXT_USER_NOT_FOUND}}"

  bl64_check_parameter 'user' || return $?

  if ! bl64_iam_user_is_created "$user"; then
    bl64_msg_show_error "${message} (user: ${user} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE}.${FUNCNAME[2]:-NONE}@${BASH_LINENO[2]:-NONE})"
    return $BL64_LIB_ERROR_USER_NOT_FOUND
  else
    return 0
  fi
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_run_useradd() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_USERADD" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_USERADD" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_run_groupadd() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_GROUPADD" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_GROUPADD" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_run_groupmod() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_GROUPMOD" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_GROUPMOD" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_run_usermod() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_USERMOD" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_USERMOD" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_run_adduser() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_ADDUSER" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_ADDUSER" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_run_addgroup() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_ADDGROUP" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_ADDGROUP" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_run_id() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_command "$BL64_IAM_CMD_ID" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_ID" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_run_sysadminctl() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_SYSADMINCTL" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_SYSADMINCTL" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Create XDG directories in user's home
#
# Arguments:
#   $1: full path to the user's home directory
#   $2: permissions. Format: chown format. Default: use current umask
#   $3: user name. Default: current
#   $4: group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: execution errors
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_xdg_create() {
  bl64_dbg_lib_show_function "$@"
  local home_path="${1:-}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local dir_user="${3:-${BL64_VAR_DEFAULT}}"
  local dir_group="${4:-${BL64_VAR_DEFAULT}}"
  local xdg_config="${home_path}/.config"
  local xdg_cache="${home_path}/.cache"
  local xdg_local="${home_path}/.local"

  bl64_check_parameter 'home_path' ||
    return $?

  bl64_msg_show_lib_task "${_BL64_IAM_TXT_XDG_CREATE} (${home_path})"
  bl64_fs_create_dir "$dir_mode" "$dir_user" "$dir_group" \
    "$xdg_config" \
    "$xdg_local" \
    "$xdg_cache" \
    "${xdg_local}/bin" \
    "${xdg_local}/lib" \
    "${xdg_local}/share" \
    "${xdg_local}/state"
}

#######################################
# Modify local user
#
# * Wrapper for native user mod command
#
# Arguments:
#   $1: login name
#   $2: (optional) primary group. Format: group name. Default: os native
#   $3: (optional) shell. Format: full path. Default: os native
#   $4: (optional) description. Default: none
#   $5: (optional) user ID. Default: os native
# Outputs:
#   STDOUT: progress
#   STDERR: execution errors
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_user_modify() {
  bl64_dbg_lib_show_function "$@"
  local login="${1:-}"
  local group="${3:-$BL64_VAR_DEFAULT}"
  local shell="${4:-$BL64_VAR_DEFAULT}"
  local gecos="${5:-$BL64_VAR_DEFAULT}"
  local uid="${6:-$BL64_VAR_DEFAULT}"

  bl64_check_parameter 'login' ||
    return $?

  bl64_msg_show_lib_subtask "$_BL64_IAM_TXT_MOD_USER ($login)"
  [[ "$group" == "$BL64_VAR_DEFAULT" ]] && group=''
  [[ "$shell" == "$BL64_VAR_DEFAULT" ]] && shell=''
  [[ "$gecos" == "$BL64_VAR_DEFAULT" ]] && gecos=''
  [[ "$uid" == "$BL64_VAR_DEFAULT" ]] && uid=''
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_iam_run_usermod \
      ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
      ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
      ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
      ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
      "$login"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    bl64_iam_run_usermod \
      ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
      ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
      ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
      ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
      "$login"
    ;;
  ${BL64_OS_SLES}-*)
    bl64_dbg_lib_show_comments 'force primary group creation'
    bl64_iam_run_usermod \
      ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
      ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
      ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
      ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
      "$login"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}
