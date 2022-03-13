#######################################
# BashLib64 / Manipulate CSV like text files
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
#######################################

#######################################
# Search for records based on key filters and return matching rows
#
# Arguments:
#   $1: source file path. Default: STDIN
# Outputs:
#   STDOUT: matching records
#   STDERR: Error messages
# Returns:
#   0: successfull execution
#   BL64_XSV_ERROR_MISSING_COMMAND
#   >0: awk command exit status
#######################################
function bl64_xsv_search_records() {
  local values="$1"
  local source="${2:--}"
  local keys="${3:-1}"
  local fields="${4:-0}"
  local separator="${5:-$BL64_XSV_FS_COLON}"

  # shellcheck disable=SC2086
  bl64_check_command "$BL64_OS_CMD_AWK" || return $BL64_XSV_ERROR_MISSING_COMMAND

  # shellcheck disable=SC2086
  bl64_check_parameter 'values' 'search value' ||
    return $BL64_XSV_ERROR_MISSING_PARAMETER

  # shellcheck disable=SC2016
  "$BL64_OS_CMD_AWK" \
    -F "$separator" \
    -v VALUES="${values}" \
    -v KEYS="$keys" \
    -v FIELDS="$fields" \
    'BEGIN {
      show_total = split( FIELDS, show_fields, ENVIRON["BL64_XSV_FS_COLON"] )
      keys_total = split( KEYS, keys_fields, ENVIRON["BL64_XSV_FS_COLON"] )
      values_total = split( VALUES, values_fields, ENVIRON["BL64_XSV_FS"] )
      row_match = ""
      count = 0
      found = 0
    }
    /^#/ || /^$/ { next }
    {
      found = 0
      for( count = 1; count <= keys_total; count++ ) {
        if ( $keys_fields[count] == values_fields[count] ) {
          found = 1
        } else {
          found = 0
          break
        }
      }

      if( found == 1 ) {
        row_match = $show_fields[1]
        for( count = 2; count <= show_total; count++ ) {
          row_match = row_match FS $show_fields[count]
        }
        print row_match
      }
    }
    END {}' \
    "$source"

}
