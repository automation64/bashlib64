#######################################
# BashLib64 / Module / Setup / Interact with system-wide Python
#
# Version: 1.2.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_py_setup() {
  bl64_dbg_lib_show_function

  bl64_py_set_command &&
    bl64_py_set_options

}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_py_set_command() {
  bl64_dbg_lib_show_function

  # Define distro native Python versions
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*) BL64_PY_CMD_PYTHON36='/usr/bin/python3' ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
    BL64_PY_CMD_PYTHON36='/usr/bin/python3'
    BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
    ;;
  ${BL64_OS_CNT}-9.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
  ${BL64_OS_FD}-33.* | ${BL64_OS_FD}-34.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
  ${BL64_OS_FD}-35.*) BL64_PY_CMD_PYTHON310='/usr/bin/python3.10' ;;
  ${BL64_OS_DEB}-9.*) BL64_PY_CMD_PYTHON35='/usr/bin/python3.5' ;;
  ${BL64_OS_DEB}-10.*) BL64_PY_CMD_PYTHON37='/usr/bin/python3.7' ;;
  ${BL64_OS_DEB}-11.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
  ${BL64_OS_UB}-20.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
  ${BL64_OS_UB}-21.* | ${BL64_OS_UB}-22.*) BL64_PY_CMD_PYTHON310='/usr/bin/python3.10' ;;
  ${BL64_OS_ALP}-3.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
  ${BL64_OS_MCOS}-12.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
  *) bl64_check_show_unsupported ;;
  esac

  # Select best match for default python3
  if [[ -x "$BL64_PY_CMD_PYTHON310" ]]; then
    BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON310"
  elif [[ -x "$BL64_PY_CMD_PYTHON39" ]]; then
    BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON39"
  elif [[ -x "$BL64_PY_CMD_PYTHON37" ]]; then
    BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON37"
  elif [[ -x "$BL64_PY_CMD_PYTHON36" ]]; then
    BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON36"
  elif [[ -x "$BL64_PY_CMD_PYTHON35" ]]; then
    BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON35"
  fi

}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_py_set_options() {
  bl64_dbg_lib_show_function
  # Common sets - unversioned
  BL64_PY_SET_PIP_VERBOSE='--verbose'
  BL64_PY_SET_PIP_VERSION='--version'
  BL64_PY_SET_PIP_UPGRADE='--upgrade'
  BL64_PY_SET_PIP_USER='--user'
}
