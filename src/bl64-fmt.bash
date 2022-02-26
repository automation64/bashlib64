#######################################
# BashLib64 / Format text data
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.1.0
#######################################

#######################################
# Removes comments from text input using the external tool Grep
#
# * Comment delimiter: #
# * All text to the right of the delimiter is removed
#
# Arguments:
#   $1: Full path to the text file. Default: STDIN
# Outputs:
#   STDOUT: Original text with comments removed
#   STDERR: grep Error message
# Returns:
#   0: successfull execution
#   >0: grep command exit status
#######################################
function bl64_fmt_strip_comments() {
  local source="${1:--}"

  "$BL64_OS_CMD_GREP" -v -E '^#.*$|^ *#.*$' "$source"
}

#######################################
# Show the last part (basename) of a full path
#
# * The function operates on text data, it doesn't verify path existance
# * The last part can be either a directory or a file
# * Parts are separated by the / character
# * The basename is defined by taking the text to the right of the last separator
# * Function mimics the linux basename command
#
# Arguments:
#   $1: Full path
# Outputs:
#   STDOUT: Basename
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_basename() {
  local path="$1"

  [[ -z "$path" ]] && return 0

  printf '%s' "${path##*/}"
}

#######################################
# Show the directory part of a full path
#
# * The function operates on text data, it doesn't verify path existance
# * Parts are separated by the / character
# * The directory is defined by taking the input string up to the last separator
# * Function mimics the linux dirname command
#
# Arguments:
#   $1: Full path
# Outputs:
#   STDOUT: Dirname
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_dirname() {
  local path="$1"

  [[ -z "$path" ]] && return 0

  printf '%s' "${path%/*}"
}
