#######################################
# BashLib64 / Module / Functions / Check for conditions and report status
#
# Version: 1.10.0
#######################################

#######################################
# Check and report if the command is present and has execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the command to check
#   $2: Not found error message. Default: _BL64_CHECK_TXT_COMMAND_NOT_FOUND
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Command found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#   $BL64_LIB_ERROR_APP_MISSING
#   $BL64_LIB_ERROR_FILE_NOT_FOUND
#   $BL64_LIB_ERROR_FILE_NOT_EXECUTE
#######################################
function bl64_check_command() {
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_COMMAND_NOT_FOUND}}"

  bl64_check_parameter 'path' || return $?

  if [[ "$path" == "$BL64_LIB_INCOMPATIBLE" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_INCOMPATIBLE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  if [[ "$path" == "$BL64_LIB_UNAVAILABLE" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_COMMAND_NOT_FOUND} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  fi

  if [[ ! -f "$path" ]]; then
    bl64_msg_show_error "${message} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / command: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi

  if [[ ! -x "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / command: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_EXECUTE
  fi

  return 0
}

#######################################
# Check and report if the file is present and has read permissions for the current user.
#
# Arguments:
#   $1: Full path to the file
#   $2: Not found error message. Default: _BL64_CHECK_TXT_FILE_NOT_FOUND
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_FILE_NOT_FOUND
#   $BL64_LIB_ERROR_FILE_NOT_READ
#######################################
function bl64_check_file() {
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_FILE_NOT_FOUND}}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_error "${message} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_FILE_NOT_FILE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -r "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_FILE_NOT_READABLE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / file: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_READ
  fi
  return 0
}

#######################################
# Check and report if the directory is present and has read and execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the directory
#   $2: Not found error message. Default: _BL64_CHECK_TXT_DIRECTORY_NOT_FOUND
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
#   $BL64_LIB_ERROR_DIRECTORY_NOT_READ
#######################################
function bl64_check_directory() {
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_DIRECTORY_NOT_FOUND}}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_error "${message} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
  fi
  if [[ ! -d "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_DIRECTORY_NOT_DIR} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
  fi
  if [[ ! -r "$path" || ! -x "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_DIRECTORY_NOT_READABLE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_DIRECTORY_NOT_READ
  fi
  return 0
}

#######################################
# Check and report if the path is present
#
# Arguments:
#   $1: Full path to the directory
#   $2: Not found error message. Default: _BL64_CHECK_TXT_PATH_NOT_FOUND
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_FOUND
#######################################
function bl64_check_path() {
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_PATH_NOT_FOUND}}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_error "${message} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PATH_NOT_FOUND
  fi
  return 0
}

#######################################
# Check shell parameters
#
# * variable is defined
# * parameter is not empty
# * parameter is not using default value
#
# Arguments:
#   $1: parameter name
#   $2: parameter description. Shown on error messages
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PARAMETER_EMPTY
#######################################
function bl64_check_parameter() {
  local parameter_name="${1:-}"
  local description="${2:-parameter: ${parameter_name}}"

  if [[ ! -v "$parameter_name" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_NOT_SET} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / ${description})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PARAMETER_MISSING
  fi

  if [[ -z "$parameter_name" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_MISSING} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / parameter: parameter_name)"
    return $BL64_LIB_ERROR_PARAMETER_EMPTY
  fi

  if eval "[[ -z \"\${${parameter_name}}\" || \"\${${parameter_name}}\" == '${BL64_LIB_DEFAULT}' ]]"; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_MISSING} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / ${description})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PARAMETER_EMPTY
  fi
  return 0
}

#######################################
# Check shell exported environment variable:
#   - exported variable is not empty
#   - exported variable is set
#
# Arguments:
#   $1: parameter name
#   $2: parameter description. Shown on error messages
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_EXPORT_EMPTY
#   $BL64_LIB_ERROR_EXPORT_SET
#######################################
function bl64_check_export() {
  local export_name="${1:-}"
  local description="${2:-export: $export_name}"

  if [[ ! -v "$export_name" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_EXPORT_SET} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / ${description})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_EXPORT_SET
  fi

  if eval "[[ -z \$${export_name} ]]"; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_EXPORT_EMPTY} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / ${description})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_EXPORT_EMPTY
  fi
  return 0
}

#######################################
# Check that the given path is relative
#
# * String check only
# * Path is not tested for existance
#
# Arguments:
#   $1: Path string
#   $2: Failed check error message. Default: _BL64_CHECK_TXT_PATH_NOT_RELATIVE
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_RELATIVE
#######################################
function bl64_check_path_relative() {
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_PATH_NOT_RELATIVE}}"

  bl64_check_parameter 'path' || return $?
  if [[ "$path" == '/' || "$path" == /* ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PATH_NOT_RELATIVE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PATH_NOT_RELATIVE
  fi
  return 0
}

#######################################
# Check that the given path is absolute
#
# * String check only
# * Path is not tested for existance
#
# Arguments:
#   $1: Path string
#   $2: Failed check error message. Default: _BL64_CHECK_TXT_PATH_NOT_ABSOLUTE
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_ABSOLUTE
#######################################
function bl64_check_path_absolute() {
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_PATH_NOT_ABSOLUTE}}"

  bl64_check_parameter 'path' || return $?
  if [[ "$path" != '/' && "$path" != /* ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PATH_NOT_ABSOLUTE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PATH_NOT_ABSOLUTE
  fi
  return 0
}

#######################################
# Check that the effective user running the current process is root
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_PRIVILEGE_IS_ROOT
#######################################
function bl64_check_privilege_root() {
  if [[ "$EUID" != '0' ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PRIVILEGE_IS_NOT_ROOT} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / current id: $EUID)"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT
  fi
  return 0
}

#######################################
# Check that the effective user running the current process is not root
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT
#######################################
function bl64_check_privilege_not_root() {
  if [[ "$EUID" == '0' ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PRIVILEGE_IS_ROOT} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PRIVILEGE_IS_ROOT
  fi
  return 0
}

#######################################
# Check file/dir overwrite condition
#
# Arguments:
#   $1: Full path to the object
#   $2: Error message
#   $3: Overwrite flag. Must be ON(1) or OFF(0). Default: OFF
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED
#######################################
function bl64_check_overwrite() {
  local path="${1:-}"
  local overwrite="${2:-"$BL64_LIB_VAR_OFF"}"
  local message="${3:-${_BL64_CHECK_TXT_OVERWRITE_NOT_PERMITED}}"

  bl64_check_parameter 'path' || return $?

  if [[ "$overwrite" == "$BL64_LIB_VAR_OFF" ]]; then
    if [[ -e "$path" ]]; then
      bl64_msg_show_error "${message} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / path: ${path})"
      # shellcheck disable=SC2086
      return $BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED
    fi
  fi

  return 0
}

#######################################
# Raise unsupported platform error
#
# Arguments:
#   $1: target (function name, command path, etc)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_OS_INCOMPATIBLE
#######################################
function bl64_check_alert_unsupported() {
  local target="${1:-}"

  bl64_msg_show_error "${_BL64_CHECK_TXT_INCOMPATIBLE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]} / os: ${BL64_OS_DISTRO}${target:+ / command: ${target}})"
  return $BL64_LIB_ERROR_OS_INCOMPATIBLE
}

#######################################
# Raise undefined command error
#
# * Commonly used in the default branch of case statements to catch undefined options
#
# Arguments:
#   $1: command
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_alert_undefined() {
  local target="${1:-}"

  bl64_msg_show_error "${_BL64_CHECK_TXT_UNDEFINED} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]}${target:+ / command: ${target}})"
  return $BL64_LIB_ERROR_TASK_UNDEFINED
}

#######################################
# Check that parameters are passed
#
# Arguments:
#   $1: total number of parameters from the calling function ($#)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_parameters_none() {
  local count="${1:-0}"

  if [[ "$count" == '0' ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_NOARGS} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]})"
    return $BL64_LIB_ERROR_PARAMETER_MISSING
  else
    return 0
  fi
}

#######################################
# Check that the optional module is loaded
#
# Arguments:
#   $1: load status (eg: $BL64_XXXX_MODULE)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_module_setup() {
  local setup_status="${1:-}"

  bl64_check_parameter 'setup_status' || return $?

  if [[ "$setup_status" == "$BL64_LIB_VAR_OFF" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_MODULE_NOT_SETUP} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]})"
    return $BL64_LIB_ERROR_MODULE_SETUP_MISSING
  else
    return 0
  fi
}
