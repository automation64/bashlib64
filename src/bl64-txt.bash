#######################################
# BashLib64 / Module / Functions / Manipulate text files content
#######################################

#######################################
# Removes comments from text input using the external tool Grep
#
# * Comment delimiter: #
# * All text to the right of the delimiter is removed
#
# Arguments:
#   $1: Full path to the text file. Use $BL64_TXT_FLAG_STDIN for stdin. Default: STDIN
# Outputs:
#   STDOUT: Original text with comments removed
#   STDERR: grep Error message
# Returns:
#   0: successfull execution
#   >0: grep command exit status
#######################################
function bl64_txt_strip_comments() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_TXT_FLAG_STDIN}}"

  [[ "$source" == "$BL64_TXT_FLAG_STDIN" ]] && source="$BL64_TXT_SET_GREP_STDIN"

  bl64_txt_run_egrep "$BL64_TXT_SET_GREP_INVERT" '^#.*$|^ *#.*$' "$source"
}

#######################################
# Read a text file, replace shell variable names with its value and show the result on stdout
#
# * Uses envsubst
# * Variables in the source file must follow the syntax: $VARIABLE or ${VARIABLE}
#
# Arguments:
#   $1: source file path
# Outputs:
#   STDOUT: source modified with replaced variables
#   STDERR: command stderr
# Returns:
#   0: replacement ok
#   >0: status from last failed command
#######################################
function bl64_txt_replace_env() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"

  bl64_check_parameter 'source' &&
    bl64_check_file "$source" ||
    return $?

  bl64_txt_run_envsubst <"$source"
}

#######################################
# Search for a whole line in a given text file or stdin
#
# Arguments:
#   $1: source file path. Use $BL64_TXT_FLAG_STDIN for stdin. Default: STDIN
#   $2: text to look for. Default: empty line
# Outputs:
#   STDOUT: none
#   STDERR: Error messages
# Returns:
#   0: line was found
#   >0: grep command exit status
#######################################
function bl64_txt_search_line() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_TXT_FLAG_STDIN}}"
  local line="${2:-}"

  [[ "$source" == "$BL64_TXT_FLAG_STDIN" ]] && source="$BL64_TXT_SET_GREP_STDIN"
  bl64_txt_run_grep \
    "$BL64_TXT_SET_GREP_QUIET" \
    "$BL64_TXT_SET_GREP_STRING" \
    "$BL64_TXT_SET_GREP_LINE" \
    "$line" \
    "$source"
}

#######################################
# Replace text directly in file using sed
#
# * Uses sed -i inline editing command
# * Helper to avoid platform specific implementation details
# * Warning: sed regexp is not consistent across versions and vendors. Caller is responsible for testing to ensure compatibility
#
# Arguments:
#   $1: sed expression
# Outputs:
#   STDOUT: none
#   STDERR: Error messages
# Returns:
#   0: operation ok
#   >0: operation failed
#######################################
function bl64_txt_line_replace_sed() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_TXT_FLAG_STDIN}}"
  local sed_expression="${2:-}"
  local -i exit_status=0

  bl64_check_parameter 'sed_expression' || return $?

  [[ "$source" == "$BL64_TXT_FLAG_STDIN" ]] && source=''

  # shellcheck disable=SC2086
  bl64_txt_run_sed -i"$BL64_LIB_SUFFIX_BACKUP" "$sed_expression" $source
  exit_status=$?
  bl64_fs_path_remove "${source}${BL64_LIB_SUFFIX_BACKUP}"
  return "$exit_status"
}

#######################################
# OS command wrapper: awk
#
# * Run AWS with POSIX compatibility and traditional regexp
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
function bl64_txt_run_awk() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_AWK_POSIX" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_TXT_CMD_AWK_POSIX" $BL64_TXT_SET_AWK_POSIX "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
# shellcheck disable=SC2120
function bl64_txt_run_envsubst() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_ENVSUBST" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_ENVSUBST" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
function bl64_txt_run_grep() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_GREP" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_GREP" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Run grep with regular expression matching
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
function bl64_txt_run_egrep() {
  bl64_dbg_lib_show_function "$@"

  bl64_txt_run_grep "$BL64_TXT_SET_GREP_ERE" "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
# * Warning: sed regexp is not consistent across versions and vendors. Caller is responsible for testing to ensure compatibility
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
function bl64_txt_run_sed() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_SED" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_SED" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
function bl64_txt_run_base64() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_BASE64" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_BASE64" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
function bl64_txt_run_tr() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_TR" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_TR" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
function bl64_txt_run_cut() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_CUT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_CUT" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
function bl64_txt_run_uniq() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_UNIQ" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_UNIQ" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
function bl64_txt_run_sort() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_SORT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_SORT" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
function bl64_txt_run_tail() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_TAIL" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_TAIL" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
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
function bl64_txt_run_fmt() {
  bl64_dbg_lib_show_function "$@"

    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_FMT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_FMT" "$@"
  bl64_dbg_lib_trace_stop
}
