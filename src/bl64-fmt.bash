#######################################
# BashLib64 / Module / Functions / Format text data
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_fmt_strip_starting_slash() {
  bl64_msg_show_deprecated 'bl64_fmt_strip_starting_slash' 'bl64_fmt_path_starting_slash'
  bl64_fmt_path_strip_root "$@"
}

function bl64_fmt_strip_ending_slash() {
  bl64_msg_show_deprecated 'bl64_fmt_strip_ending_slash' 'bl64_fmt_path_strip_ending_slash'
  bl64_fmt_path_strip_root "$@"
}

function bl64_fmt_basename() {
  bl64_msg_show_deprecated 'bl64_fmt_basename' 'bl64_fmt_path_get_basename'
  bl64_fmt_path_strip_root "$@"
}

function bl64_fmt_dirname() {
  bl64_msg_show_deprecated 'bl64_fmt_dirname' 'bl64_fmt_path_get_dirname'
  bl64_fmt_path_strip_root "$@"
}

function bl64_fmt_list_to_string() {
  bl64_msg_show_deprecated 'bl64_fmt_list_to_string' 'bl64_fmt_list_convert_to_string'
  bl64_fmt_path_strip_root "$@"
}

function bl64_fmt_separator_line() {
  bl64_msg_show_deprecated 'bl64_fmt_separator_line' 'bl64_ui_separator_show'
  bl64_fmt_path_strip_root "$@"
}

function bl64_fmt_check_value_in_list() {
  bl64_msg_show_deprecated 'bl64_fmt_check_value_in_list' 'bl64_fmt_list_check_membership'
  bl64_fmt_path_strip_root "$@"
}

#
# Private functions
#

#
# Public functions
#

#######################################
# Removes starting slash from path
#
# * If path is a single slash or relative path no change is done
#
# Arguments:
#   $1: Target path
# Outputs:
#   STDOUT: Updated path
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_path_starting_slash() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return 0
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == /* ]]; then
    printf '%s' "${path:1}"
  else
    printf '%s' "${path}"
  fi
}

#######################################
# Removes ending slash from path
#
# * If path is a single slash or no ending slash is present no change is done
#
# Arguments:
#   $1: Target path
# Outputs:
#   STDOUT: Updated path
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_path_strip_ending_slash() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return 0
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == */ ]]; then
    printf '%s' "${path:0:-1}"
  else
    printf '%s' "${path}"
  fi
}

#######################################
# Show the last part (basename) of a path
#
# * The function operates on text data, it doesn't verify path existance
# * The last part can be either a directory or a file
# * Parts are separated by the / character
# * The basename is defined by taking the text to the right of the last separator
# * Function mimics the linux basename command
#
# Examples:
#
#   bl64_fmt_path_get_basename '/full/path/to/file' -> 'file'
#   bl64_fmt_path_get_basename '/full/path/to/file/' -> ''
#   bl64_fmt_path_get_basename 'path/to/file' -> 'file'
#   bl64_fmt_path_get_basename 'path/to/file/' -> ''
#   bl64_fmt_path_get_basename '/file' -> 'file'
#   bl64_fmt_path_get_basename '/' -> ''
#   bl64_fmt_path_get_basename 'file' -> 'file'
#
# Arguments:
#   $1: Path
# Outputs:
#   STDOUT: Basename
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_path_get_basename() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"
  local base=''

  if [[ -n "$path" && "$path" != '/' ]]; then
    base="${path##*/}"
  fi

  if [[ -z "$base" || "$base" == */* ]]; then
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  else
    printf '%s' "$base"
  fi
  return 0
}

#######################################
# Show the directory part of a path
#
# * The function operates on text data, it doesn't verify path existance
# * Parts are separated by the slash (/) character
# * The directory is defined by taking the input string up to the last separator
#
# Examples:
#
#   bl64_fmt_path_get_dirname '/full/path/to/file' -> '/full/path/to'
#   bl64_fmt_path_get_dirname '/full/path/to/file/' -> '/full/path/to/file'
#   bl64_fmt_path_get_dirname '/file' -> '/'
#   bl64_fmt_path_get_dirname '/' -> '/'
#   bl64_fmt_path_get_dirname 'dir' -> 'dir'
#
# Arguments:
#   $1: Path
# Outputs:
#   STDOUT: Dirname
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_path_get_dirname() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return 0
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" != */* ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == /*/* ]]; then
    printf '%s' "${path%/*}"
  elif [[ "$path" == */*/* ]]; then
    printf '%s' "${path%/*}"
  elif [[ "$path" == /* && "${path:1}" != */* ]]; then
    printf '%s' '/'
  fi
}

#######################################
# Convert list to string. Optionally add prefix, postfix to each field
#
# * list: lines separated by \n
# * string: same as original list but with \n replaced with space
#
# Arguments:
#   $1: output field separator. Default: space
#   $2: prefix. Format: string
#   $3: postfix. Format: string
# Inputs:
#   STDIN: list
# Outputs:
#   STDOUT: string
#   STDERR: None
# Returns:
#   always ok
#######################################
function bl64_fmt_list_convert_to_string() {
  bl64_dbg_lib_show_function
  local field_separator="${1:-${BL64_VAR_DEFAULT}}"
  local prefix="${2:-${BL64_VAR_DEFAULT}}"
  local postfix="${3:-${BL64_VAR_DEFAULT}}"

  [[ "$field_separator" == "$BL64_VAR_DEFAULT" ]] && field_separator=' '
  [[ "$prefix" == "$BL64_VAR_DEFAULT" ]] && prefix=''
  [[ "$postfix" == "$BL64_VAR_DEFAULT" ]] && postfix=''

  bl64_txt_run_awk \
    -v field_separator="$field_separator" \
    -v prefix="$prefix" \
    -v postfix="$postfix" \
    '
    BEGIN {
      joined_string = ""
      RS="\n"
    }
    {
      joined_string = ( joined_string == "" ? "" : joined_string field_separator ) prefix $0 postfix
    }
    END { print joined_string }
  '
}

#######################################
# Check that the value is part of a list
#
# Arguments:
#   $1: (optional) error message
#   $2: value that will be verified
#   $@: list of one or more values to check against
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_CHECK_FAILED
#######################################
function bl64_fmt_list_check_membership() {
  bl64_dbg_lib_show_function "$@"
  local error_message="${1:-$BL64_VAR_DEFAULT}"
  local target_value="${2:-}"
  local valid_value=''
  local -i is_valid=$BL64_LIB_ERROR_CHECK_FAILED

  shift
  shift
  bl64_check_parameter 'target_value' &&
    bl64_check_parameters_none $# 'please provide at least one value to check against' ||
    return $?
  [[ "$error_message" == "$BL64_VAR_DEFAULT" ]] && error_message='invalid value'

  for valid_value in "$@"; do
    [[ "$target_value" == "$valid_value" ]] &&
      is_valid=0 &&
      break
  done
  ((is_valid != 0)) &&
    bl64_msg_show_error "${error_message}. Value must be one of: [${*}] (caller: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE}.${FUNCNAME[2]:-NONE}@${BASH_LINENO[2]:-NONE})"

  return $is_valid
}

#######################################
# Determine if the version is in semver format
#
# Arguments:
#   $1: Version
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: Yes
#   >0: No
#######################################
function bl64_fmt_version_is_semver() {
  bl64_dbg_lib_show_function "$@"
  local version="$1"
  local version_pattern_semver='^[0-9]+\.[0-9]+\.[0-9]+$'
  [[ "$version" =~ $version_pattern_semver ]]
}

#######################################
# Determine if the version is in major.minor format
#
# Arguments:
#   $1: Version
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: Yes
#   >0: No
#######################################
function bl64_fmt_version_is_major_minor() {
  bl64_dbg_lib_show_function "$@"
  local version="$1"
  local version_pattern='^[0-9]+\.[0-9]+$'
  [[ "$version" =~ $version_pattern ]]
}

#######################################
# Determine if the version is in major format
#
# Arguments:
#   $1: Version
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: Yes
#   >0: No
#######################################
function bl64_fmt_version_is_major() {
  bl64_dbg_lib_show_function "$@"
  local version="$1"
  local version_pattern='^[0-9]+$'
  [[ "$version" =~ $version_pattern ]]
}
