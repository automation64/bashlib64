#######################################
# BashLib64 / Module / Setup / Interact with AWS
#
# Version: 1.0.0
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_aws_setup() {
  bl64_dbg_lib_show_function "$@"
  local aws_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$aws_bin" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_check_directory "$aws_bin" ||
      return $?
  fi

  bl64_aws_set_command "$aws_bin" &&
    bl64_aws_set_options &&
    bl64_check_command "$BL64_AWS_CMD_AWS" &&
    BL64_AWS_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_aws_set_command() {
  bl64_dbg_lib_show_function "$@"
  local aws_bin="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$aws_bin" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/aws' ]]; then
      aws_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/aws' ]]; then
      aws_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/aws' ]]; then
      aws_bin='/usr/local/bin'
    elif [[ -x '/opt/aws/bin/aws' ]]; then
      aws_bin='/opt/aws/bin'
    elif [[ -x '/usr/bin/aws' ]]; then
      aws_bin='/usr/bin'
    fi
  else
    [[ ! -x "${aws_bin}/aws" ]] && aws_bin="$BL64_LIB_DEFAULT"
  fi

  if [[ "$aws_bin" != "$BL64_LIB_DEFAULT" ]]; then
    [[ -x "${aws_bin}/aws" ]] && BL64_AWS_CMD_AWS="${aws_bin}/aws"
  fi

  bl64_dbg_lib_show_vars 'BL64_AWS_CMD_AWS'
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_aws_set_options() {
  bl64_dbg_lib_show_function
}
