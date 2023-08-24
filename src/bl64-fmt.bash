#######################################
# BashLib64 / Module / Functions / Format text data
#######################################

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
function bl64_fmt_strip_starting_slash() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return $BL64_VAR_OK
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
function bl64_fmt_strip_ending_slash() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return $BL64_VAR_OK
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
#   bl64_fmt_basename '/full/path/to/file' -> 'file'
#   bl64_fmt_basename '/full/path/to/file/' -> ''
#   bl64_fmt_basename 'path/to/file' -> 'file'
#   bl64_fmt_basename 'path/to/file/' -> ''
#   bl64_fmt_basename '/file' -> 'file'
#   bl64_fmt_basename '/' -> ''
#   bl64_fmt_basename 'file' -> 'file'
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
function bl64_fmt_basename() {
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
#   bl64_fmt_dirname '/full/path/to/file' -> '/full/path/to'
#   bl64_fmt_dirname '/full/path/to/file/' -> '/full/path/to/file'
#   bl64_fmt_dirname '/file' -> '/'
#   bl64_fmt_dirname '/' -> '/'
#   bl64_fmt_dirname 'dir' -> 'dir'
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
function bl64_fmt_dirname() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return $BL64_VAR_OK
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
function bl64_fmt_list_to_string() {
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
# Build a separator line with optional payload
#
# * Separator format: payload + \n
#
# Arguments:
#   $1: Separator payload. Format: string
# Outputs:
#   STDOUT: separator line
#   STDERR: grep Error message
# Returns:
#   printf exit status
#######################################
function bl64_fmt_separator_line() {
  bl64_dbg_lib_show_function "$@"
  local payload="${1:-}"

  printf '%s\n' "$payload"
}

#######################################
# Converts ASCII-127 string to URL compatible format
#
# * Target is the QUERY segment of the URL:
# *   PROTOCOL://FQDN/QUERY
# * Conversion is done using sed
# * Input is assumed to be encoded in ASCII-127
# * Conversion is done as per RFC3986
# *  unreserved: left as is
# *  reserved: converted
# *  remaining ascii-127 non-control chars: converted
#
# Arguments:
#   $1: String to convert. Must be terminated by \n
# Outputs:
#   STDOUT: encoded string
#   STDERR: execution errors
# Returns:
#   0: successfull execution
#   >0: failed to convert
#######################################
function bl64_fmt_url_encode() {
  bl64_dbg_lib_show_function

  bl64_txt_run_sed \
    -e 's/%/%25/g' \
    -e 's/ /%20/g' \
    -e 's/:/%3A/g' \
    -e 's/\//%2F/g' \
    -e 's/\?/%3F/g' \
    -e 's/#/%23/g' \
    -e 's/@/%40/g' \
    -e 's/\[/%5B/g' \
    -e 's/\]/%5D/g' \
    -e 's/\!/%21/g' \
    -e 's/\$/%24/g' \
    -e 's/&/%26/g' \
    -e "s/'/%27/g" \
    -e 's/[(]/%28/g' \
    -e 's/[)]/%29/g' \
    -e 's/\*/%2A/g' \
    -e 's/\+/%2B/g' \
    -e 's/,/%2C/g' \
    -e 's/;/%3B/g' \
    -e 's/=/%3D/g' \
    -e 's/"/%22/g' \
    -e 's/</%3C/g' \
    -e 's/>/%3E/g' \
    -e 's/\^/%5E/g' \
    -e 's/`/%60/g' \
    -e 's/{/%7B/g' \
    -e 's/}/%7D/g' \
    -e 's/[|]/%7C/g' \
    -e 's/[\]/%5C/g'
}
