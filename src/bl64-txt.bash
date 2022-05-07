#######################################
# BashLib64 / Module / Functions / Manipulate text files content
#
# Version: 1.1.0
#######################################

#######################################
# Search for a whole line in a given text file
#
# Arguments:
#   $1: source file path
#   $2: text to look for
# Outputs:
#   STDOUT: none
#   STDERR: Error messages
# Returns:
#   0: line was found
#   >0: grep command exit status
#######################################
function bl64_txt_search_line() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:--}"
  local line="$2"

  "$BL64_OS_CMD_GREP" -E "^${line}$" "$source" > /dev/null
}
