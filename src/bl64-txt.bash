#######################################
# BashLib64 / Module / Functions / Manipulate text files content
#
# Version: 1.2.0
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

  "$BL64_TXT_CMD_GREP" -E "^${line}$" "$source" > /dev/null
}

#######################################
# OS command wrapper: awk
#
# * Detects OS provided awk and selects the best match
# * The selected awk app is configured for POSIX compatibility and traditional regexp
# * If gawk is required use the BL64_TXT_CMD_GAWK variable instead of this function
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_txt_run_awk() {
  bl64_dbg_lib_show_function "$@"
  local awk_cmd="$BL64_LIB_INCOMPATIBLE"
  local awk_flags=' '

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    if [[ -x '/usr/bin/gawk' ]]; then
      awk_cmd='/usr/bin/gawk'
      awk_flags='--posix'
    elif [[ -x '/usr/bin/mawk' ]]; then
      awk_cmd='/usr/bin/mawk'
    fi
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    awk_cmd='/usr/bin/gawk'
    awk_flags='--posix'
    ;;
  ${BL64_OS_ALP}-*)
    if [[ -x '/usr/bin/gawk' ]]; then
      awk_cmd='/usr/bin/gawk'
      awk_flags='--posix'
    fi
    ;;
  ${BL64_OS_MCOS}-*)
    awk_cmd='/usr/bin/awk'
    ;;
  *) bl64_check_show_unsupported ;;
  esac
  bl64_check_command "$awk_cmd" || return $?

  # shellcheck disable=SC2086
  "$awk_cmd" $awk_flags "$@"
}
