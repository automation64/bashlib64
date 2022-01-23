#######################################
# BashLib64 / Check for conditions and report status
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.2.0
#######################################

#######################################
# Check and report if the command is present and has execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the command to check
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Command found
#   $BL64_CHECK_ERROR_MISSING_PARAMETER
#   $BL64_CHECK_ERROR_FILE_NOT_FOUND
#   $BL64_CHECK_ERROR_FILE_NOT_EXECUTE
#######################################
function bl64_check_command() {
  local path="$1"

  if [[ -z "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_MISSING_PARAMETER (command path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_MISSING_PARAMETER
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_COMMAND_NOT_FOUND ($path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -x "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE ($path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_FILE_NOT_EXECUTE
  fi
  :
}

#######################################
# Check and report if the file is present and has read permissions for the current user.
#
# Arguments:
#   $1: Full path to the file
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_CHECK_ERROR_MISSING_PARAMETER
#   $BL64_CHECK_ERROR_FILE_NOT_FOUND
#   $BL64_CHECK_ERROR_FILE_NOT_READ
#######################################
function bl64_check_file() {
  local path="$1"

  if [[ -z "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_MISSING_PARAMETER (file path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_MISSING_PARAMETER
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_FILE_NOT_FOUND ($path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -r "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_FILE_NOT_READABLE ($path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_FILE_NOT_READ
  fi
  :
}

#######################################
# Check and report if the directory is present and has read and execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the directory
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_CHECK_ERROR_MISSING_PARAMETER
#   $BL64_CHECK_ERROR_DIRECTORY_NOT_FOUND
#   $BL64_CHECK_ERROR_DIRECTORY_NOT_READ
#######################################
function bl64_check_directory() {
  local path="$1"

  if [[ -z "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_MISSING_PARAMETER (directory path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_MISSING_PARAMETER
  fi
  if [[ ! -d "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_DIRECTORY_NOT_FOUND ($path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_DIRECTORY_NOT_FOUND
  fi
  if [[ ! -r "$path" || ! -x "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_DIRECTORY_NOT_READABLE ($path)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_DIRECTORY_NOT_READ
  fi
  :
}

#######################################
# Check shell parameters:
#   - parameter is not empty
#
# Arguments:
#   $1: parameter name
#   $2: parameter description. Shown on error messages
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_CHECK_ERROR_MISSING_PARAMETER
#   $BL64_CHECK_ERROR_PARAMETER_EMPTY
#######################################
function bl64_check_parameter() {
  local parameter="$1"
  local description="${2:-parameter $parameter}"

  if [[ -z "$parameter" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_MISSING_PARAMETER (parameter name)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_MISSING_PARAMETER
  fi

  if eval "[[ -z \$${parameter} ]]"; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_MISSING_PARAMETER ($description)"
    # shellcheck disable=SC2086
    return $BL64_CHECK_ERROR_PARAMETER_EMPTY
  fi
  :
}
