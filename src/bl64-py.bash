#######################################
# BashLib64 / Module / Functions / Interact with system-wide Python
#######################################

#######################################
# Create virtual environment
#
# Arguments:
#   $1: full path to the virtual environment
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_py_venv_create() {
  bl64_dbg_lib_show_function "$@"
  local venv_path="${1:-}"

  bl64_check_parameter 'venv_path' &&
    bl64_check_path_absolute "$venv_path" &&
    bl64_check_path_not_present "$venv_path" ||
    return $?

  bl64_msg_show_lib_subtask "create python virtual environment (${venv_path})"
  bl64_py_run_python -m 'venv' "$venv_path"
}

#######################################
# Check that the requested virtual environment is created
#
# Arguments:
#   $1: full path to the virtual environment
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_py_venv_check() {
  bl64_dbg_lib_show_function "$@"
  local venv_path="${1:-}"

  bl64_check_parameter 'venv_path' &&
    bl64_check_directory "$venv_path" 'requested python virtual environment is missing' &&
    bl64_check_file "${venv_path}/${BL64_PY_DEF_VENV_CFG}" 'requested python virtual environment is invalid (no pyvenv.cfg found)'
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

  read -r -a version < <(bl64_py_run_pip "$BL64_PY_SET_PIP_VERSION")
  if [[ "${version[1]}" == [0-9.]* ]]; then
    printf '%s' "${version[1]}"
  else
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
  fi

  return 0
}

#######################################
# Initialize package manager for local-user
#
# * Upgrade pip
# * Install/upgrade setuptools
# * Upgrade is done using the OS provided PIP module. Do not use bl64_py_pip_usr_install as it relays on the latest version of PIP
#
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_py_pip_usr_prepare() {
  bl64_dbg_lib_show_function
  local modules_pip='pip'
  local modules_setup='setuptools wheel stevedore'
  local flag_user="$BL64_PY_SET_PIP_USER"

  if [[ -n "$VIRTUAL_ENV" ]]; then
    # If venv is in use no need to flag usr install
    flag_user=' '
  else
    bl64_os_check_not_version \
      "${BL64_OS_KL}-2024" "${BL64_OS_KL}-2025" \
      "${BL64_OS_ARC}-2025" ||
      return $?
  fi

  bl64_msg_show_lib_subtask 'upgrade pip module'
  # shellcheck disable=SC2086
  bl64_py_run_pip \
    'install' \
    $BL64_PY_SET_PIP_UPGRADE \
    $flag_user \
    $modules_pip ||
    return $?

  bl64_msg_show_lib_subtask 'install and upgrade setuptools modules'
  # shellcheck disable=SC2086
  bl64_py_run_pip \
    'install' \
    $BL64_PY_SET_PIP_UPGRADE \
    $flag_user \
    $modules_setup ||
    return $?

  return 0
}

#######################################
# Install packages for local-user
#
# * Assume yes
# * Assumes that bl64_py_pip_usr_prepare was runned before
# * Uses the latest version of PIP (previously upgraded by bl64_py_pip_usr_prepare)
#
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_py_pip_usr_install() {
  bl64_dbg_lib_show_function "$@"
  local flag_user="$BL64_PY_SET_PIP_USER"
  local verbose='--progress-bar=off'

  bl64_check_parameters_none $# || return $?

  if [[ -n "$VIRTUAL_ENV" ]]; then
    # If venv is in use no need to flag usr install
    flag_user=' '
  else
    bl64_os_check_not_version \
      "${BL64_OS_KL}-2024" "${BL64_OS_KL}-2025" \
      "${BL64_OS_ARC}-2025" ||
      return $?
  fi

  bl64_msg_app_run_is_enabled && verbose=' '

  bl64_msg_show_lib_subtask "install modules ($*)"
  # shellcheck disable=SC2086
  bl64_py_run_pip \
    'install' \
    $BL64_PY_SET_PIP_UPGRADE \
    $flag_user $verbose \
    "$@"
}

#######################################
# Deploy PIP packages
#
# * Before installation: prepares the package manager environment and cache
# * After installation: removes cache and temporary files
#
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: process output
#   STDERR: process stderr
# Returns:
#   n: process exist status
#######################################
function bl64_py_pip_usr_deploy() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none $# || return $?

  bl64_py_pip_usr_prepare &&
    bl64_py_pip_usr_install "$@" ||
    return $?

  bl64_py_pip_usr_cleanup
  return 0
}

#######################################
# Clean up pip install environment
#
# * Empty cache
# * Ignore errors and warnings
# * Best effort
#
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   0: always ok
#######################################
function bl64_py_pip_usr_cleanup() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_subtask 'cleanup pip cache'
  bl64_py_run_pip \
    'cache' \
    'purge'

  return 0
}

#######################################
# Python wrapper with verbose, debug and common options
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
function bl64_py_run_python() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_PY_MODULE' ||
    return $?

  _bl64_py_harden_python

  bl64_dbg_lib_trace_start
  "$BL64_PY_CMD_PYTHON3" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_py_harden_python() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited PYTHON* shell variables'
  bl64_dbg_lib_trace_start
  unset PYTHONHOME
  unset PYTHONPATH
  unset PYTHONSTARTUP
  unset PYTHONDEBUG
  unset PYTHONUSERBASE
  unset PYTHONEXECUTABLE
  unset PYTHONWARNINGS
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Python PIP wrapper
#
# * Uses global ephemeral settings when configured for temporal and cache
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
  local verbose="$BL64_PY_SET_PIP_QUIET"
  local cache=' '

  if bl64_dbg_lib_command_is_enabled; then
    verbose="$BL64_PY_SET_PIP_DEBUG"
  else
    if bl64_msg_app_run_is_enabled; then
      verbose=' '
    else
      export PIP_NO_COLOR='on'
    fi
  fi

  [[ -n "$BL64_FS_PATH_CACHE" ]] && cache="--cache-dir=${BL64_FS_PATH_CACHE}"

  _bl64_py_harden_pip
  # shellcheck disable=SC2086
  TMPDIR="${BL64_FS_PATH_TEMPORAL:-}" bl64_py_run_python \
    -m 'pip' \
    $verbose \
    $cache \
    $BL64_PY_SET_PIP_NO_COLOR \
    "$@"
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_py_harden_pip() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited PIP* shell variables'
  bl64_dbg_lib_trace_start
  unset PIP_GLOBAL
  unset PIP_USER
  unset PIP_SITE
  bl64_dbg_lib_trace_stop

  bl64_dbg_lib_show_info 'normalize PIP_* shell variables'
  bl64_dbg_lib_trace_start
  export PIP_CONFIG_FILE='os.devnull'
  export PIP_DISABLE_PIP_VERSION_CHECK='yes'
  export PIP_NO_INPUT='yes'
  export PIP_NO_PYTHON_VERSION_WARNING='yes'
  export PIP_NO_WARN_SCRIPT_LOCATION='yes'
  export PIP_YES='yes'
  bl64_dbg_lib_trace_stop
  return 0
}

#######################################
# Python PIPX wrapper
#
# Arguments:
#   $@: arguments are passes as-is
# Outputs:
#   STDOUT: PIPX output
#   STDERR: PIPX error
# Returns:
#   PIP exit status
#######################################
function bl64_py_run_pipx() {
  bl64_dbg_lib_show_function "$@"
  local debug=' '
  local verbose="$BL64_PY_SET_PIP_QUIET"
  local cache=' '

  if bl64_msg_app_run_is_enabled; then
    verbose=' '
  else
    export USE_EMOJI='no'
  fi
  bl64_dbg_lib_command_is_enabled && debug="$BL64_PY_SET_PIP_DEBUG"

  _bl64_py_harden_pipx
  # shellcheck disable=SC2086
  bl64_py_run_python \
    -m 'pipx' \
    $debug $verbose $cache \
    "$@"
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_py_harden_pipx() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited PIPX* shell variables'
  bl64_dbg_lib_trace_start
  bl64_dbg_lib_trace_stop
  unset PIPX_HOME
  unset PIPX_GLOBAL_HOME
  unset PIPX_BIN_DIR
  unset PIPX_GLOBAL_BIN_DIR
  unset PIPX_MAN_DIR
  unset PIPX_GLOBAL_MAN_DIR
  unset PIPX_DEFAULT_PYTHON
  return 0
}
