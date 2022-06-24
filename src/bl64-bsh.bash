#######################################
# BashLib64 / Module / Functions / Interact with Bash shell
#
# Version: 1.0.0
#######################################

#######################################
# Get current script location
#
# Arguments:
#   None
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: full path
#   >0: command error
#######################################
function bl64_bsh_script_get_path() {
  bl64_dbg_lib_show_function
  local -i main=${#BASH_SOURCE[*]}
  local caller=''

  (( main > 0 )) && main=$((main - 1))
  caller="${BASH_SOURCE[${main}]}"

  unset CDPATH &&
    [[ -n "$caller" ]] &&
    cd -- "${caller%/*}" >/dev/null &&
    pwd -P ||
    return $?
}

#######################################
# Get current script name
#
# Arguments:
#   None
# Outputs:
#   STDOUT: script name
#   STDERR: Error messages
# Returns:
#   0: name
#   >0: command error
#######################################
function bl64_bsh_script_get_name() {
  bl64_dbg_lib_show_function
  local -i main=${#BASH_SOURCE[*]}

  (( main > 0 )) && main=$((main - 1))

  bl64_fmt_basename "${BASH_SOURCE[${main}]}"

}
