#######################################
# BashLib64 / Module / Functions / Interact with system-wide Python
#
# Version: 1.5.0
#######################################

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

  read -r -a version < <(bl64_py_run_pip "$BL64_PY_SET_PIP_VERSION")
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
  bl64_py_run_pip \
    'install' \
    $BL64_PY_SET_PIP_UPGRADE \
    $BL64_PY_SET_PIP_USER \
    $modules_pip

  bl64_msg_show_task "$_BL64_PY_TXT_PIP_PREPARE_SETUP"
  # shellcheck disable=SC2086
  bl64_py_run_pip \
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
  bl64_py_run_pip \
    'install' \
    $BL64_PY_SET_PIP_NO_WARN_SCRIPT \
    $BL64_PY_SET_PIP_USER \
    "$@"
}

#######################################
# Python wrapper with verbose, debug and common options
#
# * Trust no one. Ignore user provided config and use default config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_py_run_python() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_PY_MODULE" ||
    return $?

  unset PYTHONHOME
  unset PYTHONPATH
  unset PYTHONSTARTUP
  unset PYTHONDEBUG
  unset PYTHONUSERBASE
  unset PYTHONEXECUTABLE
  unset PYTHONWARNINGS

  "$BL64_PY_CMD_PYTHON3" "$@"
}

#######################################
# Python PIP wrapper
#
# Arguments:
#   $@: arguments are passes as-is
# Outputs:
#   STDOUT: PIP output
#   STDERR: PIP error
# Returns:
#   PIP exit status
#######################################
function bl64_py_run_pip() {
  bl64_dbg_lib_show_function "$@"
  local debug="$BL64_PY_SET_PIP_QUIET"

  bl64_msg_verbose_lib_enabled && debug="$BL64_PY_SET_PIP_VERBOSE"
  bl64_dbg_lib_command_enabled && debug="$BL64_PY_SET_PIP_DEBUG"

  bl64_py_run_python -m 'pip' $debug "$@"
}
