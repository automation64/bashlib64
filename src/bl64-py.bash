#######################################
# BashLib64 / Interact with system-wide Python
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.1.0
#######################################

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
# Warning: bootstrap function: use pure bash, no return, no exit
function bl64_py_set_command() {
  bl64_dbg_lib_show_function

  # Define distro native Python versions
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    BL64_PY_CMD_PYTHON36='/usr/bin/python3'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_OL}-8.*)
    BL64_PY_CMD_PYTHON36='/usr/bin/python3'
    BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
    ;;
  ${BL64_OS_RHEL}-9.*)
    BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
    ;;
  ${BL64_OS_FD}-33.* | ${BL64_OS_FD}-34.*)
    BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
    ;;
  ${BL64_OS_FD}-35.*)
    BL64_PY_CMD_PYTHON310='/usr/bin/python3.10'
    ;;
  ${BL64_OS_DEB}-9.*)
    BL64_PY_CMD_PYTHON35='/usr/bin/python3.5'
    ;;
  ${BL64_OS_DEB}-10.*)
    BL64_PY_CMD_PYTHON37='/usr/bin/python3.7'
    ;;
  ${BL64_OS_DEB}-11.*)
    BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
    ;;
  ${BL64_OS_UB}-20.*)
    BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
    ;;
  ${BL64_OS_UB}-21.*)
    BL64_PY_CMD_PYTHON310='/usr/bin/python3.10'
    ;;
  ${BL64_OS_ALP}-3.*)
    BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
    ;;
  ${BL64_OS_MCOS}-12.*)
    BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
    ;;
  *) bl64_msg_show_unsupported ;;
  esac

  # Select best match for default python or leave default if no better option found
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
  else
    BL64_PY_CMD_PYTHON3="/usr/bin/python3"
  fi
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
# Warning: bootstrap function: use pure bash, no return, no exit
function bl64_py_set_options() {
  bl64_dbg_lib_show_function
  # Common sets - unversioned
  BL64_PY_SET_PIP_VERBOSE='--verbose'
  BL64_PY_SET_PIP_VERSION='--version'
  BL64_PY_SET_PIP_UPGRADE='--upgrade'
  BL64_PY_SET_PIP_USER='--user'
}

#######################################
# Python PIP caller
#
# Arguments:
#   $@: arguments are passes as-is
# Outputs:
#   STDOUT: PIP output
#   STDERR: PIP error
# Returns:
#   PIP exit status
#######################################
function bl64_py_pip_run() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_command "$BL64_PY_CMD_PYTHON3" || return $?

  bl64_dbg_lib_command_enabled && debug="$BL64_PY_SET_PIP_VERBOSE"

  bl64_dbg_lib_show_info "arguments:[$*]"
  "$BL64_PY_CMD_PYTHON3" -m 'pip' $debug "$@"
}

#######################################
# Get Python PIP version
#
# Arguments:
#   None
# Outputs:
#   STDOUT: PIP version
#   STDERR: PIP error
# Returns:
#   0: ok
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#######################################
function bl64_py_pip_get_version() {
  bl64_dbg_lib_show_function
  local -a version

  read -r -a version < <("$BL64_PY_CMD_PYTHON3" -m 'pip' "$BL64_PY_SET_PIP_VERSION")
  if [[ "${version[1]}" == [0-9.]* ]]; then
    printf '%s' "${version[1]}"
  else
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  return 0
}

#######################################
# Initialize package manager for local-user
#
# * Upgrade pip
# * Install/upgrade setuptools
#
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exist status
#######################################
function bl64_py_pip_usr_prepare() {
  bl64_dbg_lib_show_function
  local modules_pip='pip'
  local modules_setup='setuptools wheel stevedore'

  bl64_msg_show_task "$_BL64_PY_TXT_PIP_PREPARE_PIP"
  bl64_py_pip_run \
    'install' \
    $BL64_PY_SET_PIP_UPGRADE \
    $BL64_PY_SET_PIP_USER \
    $modules_pip

  bl64_msg_show_task "$_BL64_PY_TXT_PIP_PREPARE_SETUP"
  # shellcheck disable=SC2086
  bl64_py_pip_run \
    'install' \
    $BL64_PY_SET_PIP_UPGRADE \
    $BL64_PY_SET_PIP_USER \
    $modules_setup

}

#######################################
# Install packages for local-user
#
# * Assume yes
#
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exist status
#######################################
function bl64_py_pip_usr_install() {
  bl64_dbg_lib_show_function "$@"
  bl64_msg_show_task "$_BL64_PY_TXT_PIP_INSTALL"
  bl64_py_pip_run \
    'install' \
    $BL64_PY_SET_PIP_USER \
    "$@"
}
