#######################################
# BashLib64 / Module / Functions / Cryptography tools
#######################################

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_gpg() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=''

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_GPG" || return $?

  bl64_msg_app_detail_is_enabled && verbosity='--verbose'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_CRYP_CMD_GPG" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_openssl() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_OPENSSL" || return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_CRYP_CMD_OPENSSL" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_md5sum() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_MD5SUM" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_CRYP_CMD_MD5SUM" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_sha256sum() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_SHA256SUM" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_CRYP_CMD_SHA256SUM" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Determine if the GPG key file is armored or not
#
# * File is not checked to be a valid key
# * File is considered dearmored if the string is present
#
# Arguments:
#   $1: GPG key file path
# Outputs:
#   STDOUT: none
#   STDERR: command stderr
# Returns:
#   0: file is armored
#   BL64_LIB_ERROR_IS_NOT
#   >0: operation failed
#######################################
function bl64_cryp_gpg_key_is_armored() {
  bl64_dbg_lib_show_function "$@"
  local key_file="$1"

  bl64_check_file "$key_file" ||
    return $?

  # shellcheck disable=SC2086
  bl64_txt_run_grep \
    $BL64_TXT_SET_GREP_QUIET \
    'BEGIN PGP PUBLIC KEY BLOCK' \
    "$key_file" || return "$BL64_LIB_ERROR_IS_NOT"
}

#######################################
# Export (armor) GPG key
#
# * Use --armor option to create base64 distributable file
#
# Arguments:
#   $1: source GPG key file path
#   $2: (optional) destination GPG key file path. If not declared, use source + '.asc'
#   $3: file permissions. Format: chown format. Default: use current umask
#   $4: file user name. Default: current
#   $5: file group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: command stderr
# Returns:
#   0: file is armored
#   BL64_LIB_ERROR_IS_NOT
#   >0: operation failed
#######################################
function bl64_cryp_gpg_key_armor() {
  bl64_dbg_lib_show_function "$@"
  local source_key_file="$1"
  local target_key_file="${2:-${source_key_file}.asc}"
  local file_mode="${3:-${BL64_VAR_DEFAULT}}"
  local file_user="${4:-${BL64_VAR_DEFAULT}}"
  local file_group="${5:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'source_key_file' &&
    bl64_check_file "$source_key_file" ||
    return $?

  bl64_msg_show_lib_subtask "export GPG key file and prepare for distribution (${source_key_file})"
  bl64_cryp_run_gpg \
    --export \
    --armor \
    --output "$target_key_file" \
    "$source_key_file" ||
    return $?

  if [[ -f "$target_key_file" ]]; then
    bl64_fs_path_permission_set "$file_mode" "$BL64_VAR_DEFAULT" "$file_user" "$file_group" "$BL64_VAR_OFF" \
      "$target_key_file"
  fi
}

#######################################
# Dearmor GPG key
#
# * Use --dearmor option to convert base64 distributable file
#
# Arguments:
#   $1: source GPG key file path
#   $2: destination GPG key file path. If not provided replace source
#   $3: file permissions. Format: chown format. Default: use current umask
#   $4: file user name. Default: current
#   $5: file group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: command stderr
# Returns:
#   0: file is armored
#   BL64_LIB_ERROR_IS_NOT
#   >0: operation failed
#######################################
function bl64_cryp_gpg_key_dearmor() {
  bl64_dbg_lib_show_function "$@"
  local source_key_file="$1"
  local target_key_file="${2:-}"
  local file_mode="${3:-${BL64_VAR_DEFAULT}}"
  local file_user="${4:-${BL64_VAR_DEFAULT}}"
  local file_group="${5:-${BL64_VAR_DEFAULT}}"
  local -i replace=0

  bl64_check_parameter 'source_key_file' &&
    bl64_check_file "$source_key_file" ||
    return $?

  if [[ -z "$target_key_file" ]]; then
    bl64_dbg_lib_show_info 'requested to replace existing key'
    target_key_file="${source_key_file}.tmp" &&
      replace=1
  fi

  bl64_msg_show_lib_subtask "dearmor exported GPG key file (${source_key_file})"
  bl64_cryp_run_gpg \
    --dearmor \
    --output "$target_key_file" \
    "$source_key_file" ||
    return $?

  if ((replace == 1)); then
    bl64_dbg_lib_show_info "replacing key (${target_key_file} -> ${source_key_file})"
    "$BL64_OS_CMD_CAT" "$target_key_file" >"$source_key_file" &&
      bl64_fs_file_remove "$target_key_file"
  else
    bl64_fs_path_permission_set "$file_mode" "$BL64_VAR_DEFAULT" "$file_user" "$file_group" "$BL64_VAR_OFF" "$target_key_file"
  fi
}

#######################################
# Download GPG key
#
# * If the key is armored, dearmor it
#
# Arguments:
#   $1: source GPG key URL
#   $2: destination GPG key file path. If not provided replace source
#   $3: replace existing file. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $4: file permissions. Format: chown format. Default: use current umask
#   $5: file user name. Default: current
#   $6: file group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: command stderr
# Returns:
#   0: file is armored
#   BL64_LIB_ERROR_IS_NOT
#   >0: operation failed
#######################################
function bl64_cryp_key_download() {
  bl64_dbg_lib_show_function "$@"
  local source_url="$1"
  local target_key_file="${2:-}"
  local replace="${3:-${BL64_VAR_DEFAULT}}"
  local file_mode="${4:-${BL64_VAR_DEFAULT}}"
  local file_user="${5:-${BL64_VAR_DEFAULT}}"
  local file_group="${6:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'source_url' &&
    bl64_check_parameter 'target_key_file' &&
    bl64_check_module 'BL64_RXTX_MODULE' ||
    return $?

  bl64_rxtx_web_get_file \
    "$source_url" \
    "$target_key_file" \
    "$replace" \
    "$file_mode" \
    "$file_user" \
    "$file_group" ||
    return $?

  if bl64_cryp_gpg_key_is_armored "$target_key_file"; then
    bl64_cryp_gpg_key_dearmor "$target_key_file"
  fi
}
