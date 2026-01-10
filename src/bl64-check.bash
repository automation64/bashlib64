#######################################
# BashLib64 / Module / Functions / Check for conditions and report status
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_check_module_imported() {
  bl64_msg_show_deprecated 'bl64_check_module_imported' '_bl64_lib_module_is_imported'
  _bl64_lib_module_is_imported "$@"
}

function bl64_check_user() {
  bl64_msg_show_deprecated 'bl64_check_user' 'bl64_iam_check_user'
  bl64_iam_check_user "$@"
}

#
# Public functions
#

#######################################
# Check and report if the command is present and has execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the command to check
#   $2: (optional) Not found error message
#   $3: (optional) Command name. Displayed in the error message when not found
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
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-$BL64_VAR_DEFAULT}"
  local command_name="${3:-}"

  bl64_lib_var_is_default "$message" && message='command not found. Please install it and try again'
  bl64_check_parameter 'path' ${command_name:+"command: ${command_name}"} || return $?

  if [[ "$path" == "$BL64_VAR_INCOMPATIBLE" ]]; then
    bl64_msg_show_check "command not compatible with the current OS (OS: ${BL64_OS_DISTRO}${command_name:+ | command: ${command_name}})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
  fi

  if [[ "$path" == "$BL64_VAR_UNAVAILABLE" ]]; then
    bl64_msg_show_check "${message}${command_name:+ (command: ${command_name})}"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_APP_MISSING"
  fi

  if [[ ! -e "$path" ]]; then
    bl64_msg_show_check "${message} (command: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi

  if [[ ! -x "$path" ]]; then
    bl64_msg_show_check "invalid command permissions. Set the execution permission and try again (command: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_EXECUTE"
  fi

  return 0
}

#######################################
# Check that the file is present and has read permissions for the current user.
#
# Arguments:
#   $1: Full path to the file
#   $2: Not found error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_FILE_NOT_FOUND
#   $BL64_LIB_ERROR_FILE_NOT_READ
#######################################
function bl64_check_file() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required file is not present}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_check "path is present but is not a regular file (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi
  if [[ ! -r "$path" ]]; then
    bl64_msg_show_check "required file is present but has no read permission (file: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_READ"
  fi
  return 0
}

#######################################
# Check that the directory is present and has read and execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the directory
#   $2: Not found error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
#   $BL64_LIB_ERROR_DIRECTORY_NOT_READ
#######################################
function bl64_check_directory() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required directory is not present}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_DIRECTORY_NOT_FOUND"
  fi
  if [[ ! -d "$path" ]]; then
    bl64_msg_show_check "path is present but is not a directory (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_DIRECTORY_NOT_FOUND"
  fi
  if [[ ! -r "$path" || ! -x "$path" ]]; then
    bl64_msg_show_check "required directory is present but has no read permission (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_DIRECTORY_NOT_READ"
  fi
  return 0
}

#######################################
# Check that the path is present
#
# * The target must can be of any type
#
# Arguments:
#   $1: Full path
#   $2: Not found error message.
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_FOUND
#######################################
function bl64_check_path() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required path is not present}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PATH_NOT_FOUND"
  fi
  return 0
}

#######################################
# Check for mandatory shell function parameters
#
# * Check that:
#   * variable is defined
#   * parameter is not empty
#   * parameter is not using null value
#   * parameter is not using default value: this is to allow the calling function to have several mandatory parameters before optionals
#
# Arguments:
#   $1: parameter name
#   $2: (optional) parameter description. Shown on error messages
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PARAMETER_EMPTY
#######################################
function bl64_check_parameter() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local parameter_name="${1:-}"
  local description="${2:-parameter: ${parameter_name}}"
  local parameter_ref=''

  if [[ -z "$parameter_name" ]]; then
    bl64_msg_show_check "required parameter is missing (parameter: ${parameter_name})"
    return "$BL64_LIB_ERROR_PARAMETER_EMPTY"
  fi

  if [[ ! -v "$parameter_name" ]]; then
    bl64_msg_show_check "required shell variable is not set (${description})"
    return "$BL64_LIB_ERROR_PARAMETER_MISSING"
  fi

  parameter_ref="${!parameter_name}"
  if [[ -z "$parameter_ref" || "$parameter_ref" == "${BL64_VAR_NULL}" ]]; then
    bl64_msg_show_check "required parameter is missing (${description})"
    return "$BL64_LIB_ERROR_PARAMETER_EMPTY"
  fi

  if [[ "$parameter_ref" == "${BL64_VAR_DEFAULT}" ]]; then
    bl64_msg_show_check "required parameter value must be other than default (${description})"
    return "$BL64_LIB_ERROR_PARAMETER_INVALID"
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
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local export_name="${1:-}"
  local description="${2:-export: $export_name}"
  local export_ref=''

  bl64_check_parameter 'export_name' || return $?

  if [[ ! -v "$export_name" ]]; then
    bl64_msg_show_check "required shell exported variable is not set (${description})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_EXPORT_SET"
  fi

  export_ref="${!export_name}"
  if [[ -z "$export_ref" ]]; then
    bl64_msg_show_check "required shell exported variable is empty (${description})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_EXPORT_EMPTY"
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
#   $2: Failed check error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_RELATIVE
#######################################
function bl64_check_path_relative() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required path must be relative}"

  bl64_check_parameter 'path' || return $?
  if [[ "$path" == '/' || "$path" == /* ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PATH_NOT_RELATIVE"
  fi
  return 0
}

#######################################
# Check that the given path is not present
#
# * The target must can be of any type
#
# Arguments:
#   $1: Full path
#   $2: Failed check error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_PRESENT
#######################################
function bl64_check_path_not_present() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-requested path is already present}"

  bl64_check_parameter 'path' || return $?
  if [[ -e "$path" ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PATH_PRESENT"
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
#   $2: Failed check error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_ABSOLUTE
#######################################
function bl64_check_path_absolute() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required path must be absolute}"

  bl64_check_parameter 'path' || return $?
  if [[ "$path" != '/' && "$path" != /* ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PATH_NOT_ABSOLUTE"
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
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function
  if [[ "$EUID" != '0' ]]; then
    bl64_msg_show_check "the task requires root privilege. Please run the script as root or with SUDO (current id: $EUID)"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT"
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
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function

  if [[ "$EUID" == '0' ]]; then
    bl64_msg_show_check 'the task should not be run with root privilege. Please run the script as a regular user and not using SUDO'
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PRIVILEGE_IS_ROOT"
  fi
  return 0
}

#######################################
# Check file/dir overwrite condition and fail if not meet
#
# * Use for tasks that needs to ensure that previous content will not overwriten unless requested
# * Target path can be of any type
#
# Arguments:
#   $1: Full path to the object
#   $2: Overwrite flag. Must be ON(1) or OFF(0). Default: OFF
#   $3: Error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: no previous file/dir or overwrite is requested
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED
#######################################
function bl64_check_overwrite() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local overwrite="${2:-$BL64_VAR_OFF}"
  local message="${3:-target is already present and overwrite is not permitted. Unable to continue}"

  bl64_check_parameter 'path' || return $?

  if ! bl64_lib_flag_is_enabled "$overwrite" || bl64_lib_var_is_default "$overwrite"; then
    if [[ -e "$path" ]]; then
      bl64_msg_show_check "${message} (path: ${path})"
      return "$BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED"
    fi
  fi

  return 0
}

#######################################
# Check file/dir overwrite condition and warn if not meet
#
# * Use for tasks that will do nothing if the target is already present
# * Warning: Caller is responsible for checking that path parameter is valid
# * Target path can be of any type
#
# Arguments:
#   $1: Full path to the object
#   $2: Overwrite flag. Must be ON(1) or OFF(0). Default: OFF
#   $3: Warning message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: skip since previous file/dir is present
#   1: no previous file/dir present or overwrite is requested
#######################################
function bl64_check_overwrite_skip() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local overwrite="${2:-$BL64_VAR_OFF}"
  local message="${3:-}"

  bl64_check_parameter 'path'

  if ! bl64_lib_flag_is_enabled "$overwrite" || bl64_lib_var_is_default "$overwrite"; then
    if [[ -e "$path" ]]; then
      bl64_msg_show_warning "${message:-target is already present and overwrite is not requested. Target is left as is} (path: ${path})"
      return 0
    fi
  fi

  return 1
}

#######################################
# Raise error: invalid parameter
#
# * Use to raise an error when the calling function has verified that the parameter is not valid
# * This is a generic enough message to capture most validation use cases when there is no specific bl64_check_*
# * Can be used as the default value (*) for the bash command "case" to capture invalid options
#
# Arguments:
#   $1: parameter name
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
# shellcheck disable=SC2120
function bl64_check_alert_parameter_invalid() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local parameter="${1:-${BL64_VAR_DEFAULT}}"
  local message="${2:-the requested operation was provided with an invalid parameter value}"

  bl64_lib_var_is_default "$parameter" && parameter=''
  bl64_msg_show_check "${message} ${parameter:+(parameter: ${parameter})}"
  return "$BL64_LIB_ERROR_PARAMETER_INVALID"
}

#######################################
# Raise unsupported platform error
#
# Arguments:
#   $1: extra error message. Added to the error detail between (). Default: none
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_OS_INCOMPATIBLE
#######################################
function bl64_check_alert_unsupported() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local extra="${1:-}"

  bl64_msg_show_check "the requested operation is not supported on the current OS (${extra:+${extra} ${BL64_MSG_COSMETIC_PIPE} }os: ${BL64_OS_DISTRO})"
  return "$BL64_LIB_ERROR_OS_INCOMPATIBLE"
}

#######################################
# Check that the compatibility mode is enabled to support untested command
#
# * If enabled, show a warning and continue OK
# * If not enabled, fail
#
# Arguments:
#   $1: extra error message. Added to the error detail between (). Default: none
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: using compatibility mode
#   >0: command is incompatible and compatibility mode is disabled
#######################################
function bl64_check_compatibility_mode() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local extra="${1:-}"

  if bl64_lib_mode_compability_is_enabled; then
    bl64_msg_show_warning "using generic compatibility mode for untested command version (${extra:+${extra} ${BL64_MSG_COSMETIC_PIPE} }os: ${BL64_OS_DISTRO})"
  else
    bl64_check_alert_unsupported "$extra"
    return $?
  fi
}

#######################################
# Raise resource not detected error
#
# * Generic error used when a required external resource is not found on the system
# * Common use case: module setup looking for command in known locations
#
# Arguments:
#   $1: resource name. Default: none
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_APP_MISSING
#######################################
function bl64_check_alert_resource_not_found() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local resource="${1:-}"

  bl64_msg_show_check "required resource was not found on the system (${resource:+resource: ${resource} ${BL64_MSG_COSMETIC_PIPE} }os: ${BL64_OS_DISTRO})"
  return "$BL64_LIB_ERROR_APP_MISSING"
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
# shellcheck disable=SC2119,SC2120
function bl64_check_alert_undefined() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local target="${1:-}"

  bl64_msg_show_check "requested command is not defined or implemented (${target:+ ${BL64_MSG_COSMETIC_PIPE} command: ${target}})"
  return "$BL64_LIB_ERROR_TASK_UNDEFINED"
}

#######################################
# Raise module setup error
#
# * Helper to check if the module was correctly setup and raise error if not
# * Use as last function of bl64_*_setup
# * Will take the last exit status
#
# Arguments:
#   $1: bashlib64 module alias
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   $status
#######################################
function bl64_check_alert_module_setup() {
  local -i last_status=$? # must be first line to catch $?
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local module="${1:-}"

  bl64_check_parameter 'module' || return $?

  if [[ "$last_status" != '0' ]]; then
    bl64_msg_show_check "BashLib64 module setup failure (module: ${module})"
    return "$last_status"
  else
    return 0
  fi
}

#######################################
# Check that at least 1 parameter is passed when using dynamic arguments
#
# Arguments:
#   $1: must be $# to capture number of parameters from the calling function
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_parameters_none() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local count="${1:-}"
  local message="${2:-the requested operation requires at least one parameter and none was provided}"

  bl64_check_parameter 'count' || return $?

  if [[ "$count" == '0' ]]; then
    bl64_msg_show_check "${message}"
    return "$BL64_LIB_ERROR_PARAMETER_MISSING"
  else
    return 0
  fi
}

#######################################
# Check that the module is loaded and has been setup
#
# * Use in functions that depends on module resources being present before execution
#
# Arguments:
#   $1: module id (eg: BL64_XXXX_MODULE)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_MODULE_SETUP_MISSING
#######################################
function bl64_check_module() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local module="${1:-}"
  local setup_status=''

  bl64_check_parameter 'module' &&
    _bl64_lib_module_is_imported "$module" ||
    return $?

  setup_status="${!module}"
  if [[ "$setup_status" == "$BL64_VAR_OFF" ]]; then
    bl64_msg_show_check "required BashLib64 module is not setup. Call the bl64_<MODULE>_setup function before using the module (module: ${module})"
    return "$BL64_LIB_ERROR_MODULE_SETUP_MISSING"
  fi

  return 0
}

#######################################
# Check exit status
#
# * Helper to check for exit status of the last executed command and show error if failed
# * Return the same status as the latest command. This is to facilitate chaining with && return $? or be the last command of the function
#
# Arguments:
#   $1: exit status
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   $status
#######################################
function bl64_check_status() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local status="${1:-}"
  local message="${2:-task execution failed}"

  bl64_check_parameter 'status' || return $?

  if [[ "$status" != '0' ]]; then
    bl64_msg_show_check "${message} (status: ${status})"
    # shellcheck disable=SC2086
    return "$status"
  else
    return 0
  fi
}

#######################################
# Check that the HOME variable is present and the path is valid
#
# * HOME is the standard shell variable for current user's home
#
# Arguments:
#   None
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: home is valid
#   >0: home is not valid
#######################################
function bl64_check_home() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function

  bl64_check_export 'HOME' 'standard shell variable HOME is not defined' &&
    bl64_check_directory "$HOME" "unable to find user's HOME directory"
}

#######################################
# Check and report if the command is available using the current search path
#
# * standar PATH variable is used for the search
# * aliases and built-in commands will always return true
# * if the command is in the search path, then bl64_check_command is used to ensure it can be used
#
# Arguments:
#   $1: command file name
#   $2: Not found error message.
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Command found
#   BL64_LIB_ERROR_FILE_NOT_FOUND
#######################################
function bl64_check_command_search_path() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local file="${1:-}"
  local message="${2:-required command is not found in any of the search paths}"
  local full_path=''

  bl64_check_parameter 'file' || return $?

  full_path="$(type -p "${file}")"
  # shellcheck disable=SC2181
  if (($? != 0)); then
    bl64_msg_show_check "${message} (command: ${file})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi

  bl64_check_command "$full_path"
}
