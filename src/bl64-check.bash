#######################################
# BashLib64 / Check for conditions and report status
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
#######################################

#
# Internal Functions
#

#
# Exported Functions
#

#######################################
# Check and report if the command is present and has execute permissions for the current user.
#
# Globals:
#   _BL64_CHECK_TXT_MISSING_PARAMETER
#   _BL64_CHECK_TXT_COMMAND_NOT_FOUND
#   _BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE
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
    return $BL64_CHECK_ERROR_MISSING_PARAMETER
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_COMMAND_NOT_FOUND ($path)"
    return $BL64_CHECK_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -x "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE ($path)"
    return $BL64_CHECK_ERROR_FILE_NOT_EXECUTE
  fi
  :
}

#######################################
# Check and report if the file is present and has read permissions for the current user.
#
# Globals:
#   _BL64_CHECK_TXT_MISSING_PARAMETER
#   _BL64_CHECK_TXT_FILE_NOT_FOUND
#   _BL64_CHECK_TXT_FILE_NOT_EXECUTABLE
# Arguments:
#   $1: Full path to the file to check
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
    return $BL64_CHECK_ERROR_MISSING_PARAMETER
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_FILE_NOT_FOUND ($path)"
    return $BL64_CHECK_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -r "$path" ]]; then
    bl64_msg_show_error "$_BL64_CHECK_TXT_FILE_NOT_READABLE ($path)"
    return $BL64_CHECK_ERROR_FILE_NOT_READ
  fi
  :
}
