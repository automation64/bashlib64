#######################################
# BashLib64 / Module / Functions / Manage role based access service
#
# Version: 1.7.0
#######################################

#######################################
# Add password-less root privilege
#
# Arguments:
#   $1: user name. User must already be present.
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: rule added
#   >0: failed command exit status
#######################################
function bl64_rbac_add_root() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local new_sudoers="${BL64_RBAC_FILE_SUDOERS}.bl64_new"
  local old_sudoers="${BL64_RBAC_FILE_SUDOERS}.bl64_old"
  local -i status=0

  bl64_check_privilege_root &&
    bl64_check_parameter 'user' &&
    bl64_check_file "$BL64_RBAC_FILE_SUDOERS" &&
    bl64_rbac_check_sudoers "$BL64_RBAC_FILE_SUDOERS" ||
    return $?

  umask 0266
  # shellcheck disable=SC2016
  bl64_txt_run_awk \
    -v ControlUsr="$user" \
    '
      BEGIN { Found = 0 }
      ControlUsr " ALL=(ALL) NOPASSWD: ALL" == $0 { Found = 1 }
      { print $0 }
      END {
        if( Found == 0) {
          print( ControlUsr " ALL=(ALL) NOPASSWD: ALL" )
        }
      }
    ' \
    "$BL64_RBAC_FILE_SUDOERS" >"$new_sudoers"

  if [[ -s "$new_sudoers" ]]; then
    bl64_fs_cp_file "${BL64_RBAC_FILE_SUDOERS}" "$old_sudoers"
  fi
  if [[ -s "$new_sudoers" && -s "$old_sudoers" ]]; then
    "$BL64_OS_CMD_CAT" "${BL64_RBAC_FILE_SUDOERS}.bl64_new" >"${BL64_RBAC_FILE_SUDOERS}" &&
      bl64_rbac_check_sudoers "$BL64_RBAC_FILE_SUDOERS"
    status=$?
  else
    status=$BL64_LIB_ERROR_TASK_FAILED
  fi

  return $status
}

#######################################
# Use visudo --check to validate sudoers file
#
# Arguments:
#   $1: full path to the sudoers file
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: sudoers sintax ok
#   visudo exit status
#######################################
function bl64_rbac_check_sudoers() {
  bl64_dbg_lib_show_function "$@"
  local sudoers="$1"
  local -i status=0

  bl64_check_privilege_root &&
    bl64_check_command "$BL64_RBAC_CMD_VISUDO" ||
    return $?

  "$BL64_RBAC_CMD_VISUDO" \
    --check \
    --file "$sudoers"
  status=$?

  if ((status != 0)); then
    bl64_msg_show_error "$_BL64_RBAC_TXT_INVALID_SUDOERS ($sudoers)"
  fi

  return $status
}

#######################################
# Run privileged OS command using Sudo if needed
#
# Arguments:
#   $@: command and arguments to run
# Outputs:
#   STDOUT: command or sudo output
#   STDERR: command or sudo error
# Returns:
#   command or sudo exit status
#######################################
function bl64_rbac_run_command() {
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  (($# == 0)) && return $BL64_LIB_ERROR_PARAMETER_MISSING
  # shellcheck disable=SC2086
  bl64_check_command "$BL64_RBAC_CMD_SUDO" || return $?

  # Check the effective user id
  if [[ "$EUID" == '0' ]]; then
    # Already root, execute command directly
    "$@"
  else
    # Current user is regular, use SUDO
    $BL64_RBAC_ALIAS_SUDO_ENV "$@"
  fi
}
