#######################################
# BashLib64 / Module / Setup / Interact with system-wide Python
#######################################

#######################################
# Setup the bashlib64 module
#
# * (Optional) Use virtual environment
#
# Arguments:
#   $1: full path to the virtual environment
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_py_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  bl64_dbg_lib_show_function "$@"
  local venv_path="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$venv_path" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_dbg_lib_show_info "venv requested (${venv_path})"
    if [[ -d "$venv_path" ]]; then
      bl64_dbg_lib_show_info 'use already existing venv'
      _bl64_py_setup "$venv_path"
    else
      bl64_dbg_lib_show_info 'no previous venv, create one'
      _bl64_py_setup "$BL64_VAR_DEFAULT" &&
        bl64_py_venv_create "$venv_path" &&
        _bl64_py_setup "$venv_path"
    fi
  else
    bl64_dbg_lib_show_info "no venv requested"
    _bl64_py_setup "$BL64_VAR_DEFAULT"
  fi

  bl64_check_alert_module_setup 'py'
}

function _bl64_py_setup() {
  local venv_path="$1"

  if [[ "$venv_path" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_py_venv_check "$venv_path" ||
      return $?
  fi

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_py_set_command "$venv_path" &&
    bl64_check_command "$BL64_PY_CMD_PYTHON3" &&
    _bl64_py_set_version &&
    _bl64_py_set_options &&
    BL64_PY_MODULE="$BL64_VAR_ON"
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * (Optional) Enable requested virtual environment
# * If virtual environment is requested, instead of running bin/activate manually set the same variables that it would
# * Python versions are detected up to the subversion, minor is ignored. Example: use python3.6 instead of python3.6.1
#
# Arguments:
#   $1: full path to the virtual environment
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_py_set_command() {
  bl64_dbg_lib_show_function "$@"
  local venv_path="$1"

  if bl64_lib_var_is_default "$venv_path"; then
    if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
      _bl64_py_set_command_macos || return $?
    elif [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
      _bl64_py_set_command_linux || return $?
    fi
    bl64_dbg_lib_show_comments 'Ignore VENV. Use detected python'
    export VIRTUAL_ENV=''
  else
    bl64_dbg_lib_show_comments 'use python3 from virtual environment'
    BL64_PY_CMD_PYTHON3="${venv_path}/bin/python3"

    bl64_dbg_lib_show_comments 'Emulate bin/activate'
    export VIRTUAL_ENV="$venv_path"
    export PATH="${VIRTUAL_ENV}:${PATH}"
    unset PYTHONHOME

    bl64_dbg_lib_show_comments 'Let other basthlib64 functions know about this venv'
    # shellcheck disable=SC2034
    BL64_PY_PATH_VENV="$venv_path"
  fi
  bl64_dbg_lib_show_vars 'BL64_PY_CMD_PYTHON3' 'BL64_PY_PATH_VENV' 'VIRTUAL_ENV' 'PATH'
  return 0
}

function _bl64_py_set_command_macos() {
  bl64_dbg_lib_show_function
  if [[ -x '/usr/bin/python3' ]]; then
    BL64_PY_CMD_PYTHON3='/usr/bin/python3'
  else
    bl64_check_alert_unsupported
    return $?
  fi
}

function _bl64_py_set_command_linux() {
  bl64_dbg_lib_show_function
  # Select best match for default python3
  if [[ -x '/usr/bin/python3.13' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.13"
  elif [[ -x '/usr/bin/python3.12' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.12"
  elif [[ -x '/usr/bin/python3.11' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.11"
  elif [[ -x '/usr/bin/python3.10' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.10"
  elif [[ -x '/usr/bin/python3.9' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.9"
  elif [[ -x '/usr/bin/python3.8' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.8"
  elif [[ -x '/usr/bin/python3.7' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.7"
  elif [[ -x '/usr/bin/python3.6' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.6"
  elif [[ -x '/usr/bin/python3.5' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.5"
  elif [[ -x '/usr/bin/python3.4' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.4"
  elif [[ -x '/usr/bin/python3.3' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.3"
  elif [[ -x '/usr/bin/python3.2' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.2"
  elif [[ -x '/usr/bin/python3.1' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.1"
  elif [[ -x '/usr/bin/python3.0' ]]; then
    BL64_PY_CMD_PYTHON3="/usr/bin/python3.0"
  else
    if bl64_check_compatibility_mode; then
      BL64_PY_CMD_PYTHON3='/usr/bin/python3'
    else
      bl64_check_alert_unsupported
      return $?
    fi
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
function _bl64_py_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  {
    BL64_PY_SET_PIP_DEBUG='-vvv'
    BL64_PY_SET_PIP_NO_WARN_SCRIPT='--no-warn-script-location'
    BL64_PY_SET_PIP_QUIET='--quiet'
    BL64_PY_SET_PIP_SITE='--system-site-packages'
    BL64_PY_SET_PIP_UPGRADE='--upgrade'
    BL64_PY_SET_PIP_USER='--user'
    BL64_PY_SET_PIP_VERBOSE='--verbose'
    BL64_PY_SET_PIP_VERSION='--version'
  }

  if [[ "${BL64_PY_VERSION_PIP3%%.*}" -ge 10 ]]; then
    BL64_PY_SET_PIP_NO_COLOR="--no-color"
  else
    BL64_PY_SET_PIP_NO_COLOR=' '
  fi

  # shellcheck disable=SC2034
  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    BL64_PY_PATH_PIP_USR_BIN="${HOME}/Library/Python/${BL64_PY_VERSION_PYTHON3}/bin"
  else
    BL64_PY_PATH_PIP_USR_BIN="${HOME}/.local/bin"
  fi

  return 0
}

#######################################
# Identify and set module components versions
#
# * Version information is stored in module global variables
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: command errors
# Returns:
#   0: version set ok
#   >0: command error
#######################################
function _bl64_py_set_version() {
  bl64_dbg_lib_show_function
  BL64_PY_VERSION_PYTHON3="$(
    "$BL64_PY_CMD_PYTHON3" -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
  )"
  [[ -z "$BL64_PY_VERSION_PYTHON3" ]] &&
    bl64_msg_show_lib_error "Unable to determine Python version (${BL64_PY_CMD_PYTHON3})" &&
    return "$BL64_LIB_ERROR_TASK_FAILED"

  BL64_PY_VERSION_PIP3="$(
    "$BL64_PY_CMD_PYTHON3" -c "import pip; print(pip.__version__)"
  )"
  [[ -z "$BL64_PY_VERSION_PIP3" ]] &&
    bl64_msg_show_lib_error "Unable to determine PIP version (${BL64_PY_CMD_PYTHON3})" &&
    return "$BL64_LIB_ERROR_TASK_FAILED"

  return 0
}
