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
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
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
  bl64_dbg_lib_show_function "$@"
  local venv_path="$1"

  if [[ "$venv_path" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_py_venv_check "$venv_path" ||
      return $?
  fi

  bl64_lib_module_imported 'BL64_CHECK_MODULE' &&
    bl64_lib_module_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    bl64_lib_module_imported 'BL64_OS_MODULE' &&
    bl64_lib_module_imported 'BL64_MSG_MODULE' &&
    _bl64_py_set_command "$venv_path" &&
    bl64_check_command "$BL64_PY_CMD_PYTHON3" &&
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

  if [[ "$venv_path" == "$BL64_VAR_DEFAULT" ]]; then
    # Select best match for default python3
    if [[ -x '/usr/bin/python3.12' ]]; then
      BL64_PY_VERSION_PYTHON3='3.12'
      BL64_PY_CMD_PYTHON3="/usr/bin/python${BL64_PY_VERSION_PYTHON3}"
      BL64_PY_CMD_PYTHON312="$BL64_PY_CMD_PYTHON3"
    elif [[ -x '/usr/bin/python3.11' ]]; then
      BL64_PY_VERSION_PYTHON3='3.11'
      BL64_PY_CMD_PYTHON3="/usr/bin/python${BL64_PY_VERSION_PYTHON3}"
      BL64_PY_CMD_PYTHON311="$BL64_PY_CMD_PYTHON3"
    elif [[ -x '/usr/bin/python3.10' ]]; then
      BL64_PY_VERSION_PYTHON3='3.10'
      BL64_PY_CMD_PYTHON3="/usr/bin/python${BL64_PY_VERSION_PYTHON3}"
      BL64_PY_CMD_PYTHON310="$BL64_PY_CMD_PYTHON3"
    elif [[ -x '/usr/bin/python3.9' ]]; then
      BL64_PY_VERSION_PYTHON3='3.9'
      BL64_PY_CMD_PYTHON3="/usr/bin/python${BL64_PY_VERSION_PYTHON3}"
      BL64_PY_CMD_PYTHON39="$BL64_PY_CMD_PYTHON3"
    elif [[ -x '/usr/bin/python3.8' ]]; then
      BL64_PY_VERSION_PYTHON3='3.8'
      BL64_PY_CMD_PYTHON3="/usr/bin/python${BL64_PY_VERSION_PYTHON3}"
      BL64_PY_CMD_PYTHON38="$BL64_PY_CMD_PYTHON3"
    elif [[ -x '/usr/bin/python3.7' ]]; then
      BL64_PY_VERSION_PYTHON3='3.7'
      BL64_PY_CMD_PYTHON3="/usr/bin/python${BL64_PY_VERSION_PYTHON3}"
      BL64_PY_CMD_PYTHON37="$BL64_PY_CMD_PYTHON3"
    elif [[ -x '/usr/bin/python3.6' ]]; then
      BL64_PY_VERSION_PYTHON3='3.6'
      BL64_PY_CMD_PYTHON3="/usr/bin/python${BL64_PY_VERSION_PYTHON3}"
      BL64_PY_CMD_PYTHON36="$BL64_PY_CMD_PYTHON3"
    elif [[ -x '/usr/bin/python3.5' ]]; then
      BL64_PY_VERSION_PYTHON3='3.5'
      BL64_PY_CMD_PYTHON3="/usr/bin/python${BL64_PY_VERSION_PYTHON3}"
      BL64_PY_CMD_PYTHON35="$BL64_PY_CMD_PYTHON3"
    else
      if bl64_check_compatibility_mode; then
        BL64_PY_CMD_PYTHON3='/usr/bin/python3'
      else
        bl64_check_alert_unsupported
        return $?
      fi
    fi

    # Ignore VENV. Use detected python
    export VIRTUAL_ENV=''

  else
    bl64_dbg_lib_show_comments 'use python3 from virtual environment'
    BL64_PY_CMD_PYTHON3="${venv_path}/bin/python3"

    # Emulate bin/activate
    export VIRTUAL_ENV="$venv_path"
    export PATH="${VIRTUAL_ENV}:${PATH}"
    unset PYTHONHOME

    # Let other basthlib64 functions know about this venv
    BL64_PY_VENV_PATH="$venv_path"
  fi

  bl64_dbg_lib_show_vars 'BL64_PY_CMD_PYTHON3' 'BL64_PY_VENV_PATH' 'VIRTUAL_ENV' 'PATH'
  return 0
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
  # Common sets - unversioned
  BL64_PY_SET_PIP_VERBOSE='--verbose'
  BL64_PY_SET_PIP_DEBUG='-vvv'
  BL64_PY_SET_PIP_VERSION='--version'
  BL64_PY_SET_PIP_UPGRADE='--upgrade'
  BL64_PY_SET_PIP_USER='--user'
  BL64_PY_SET_PIP_QUIET='--quiet'
  BL64_PY_SET_PIP_SITE='--system-site-packages'
  BL64_PY_SET_PIP_NO_WARN_SCRIPT='--no-warn-script-location'

  return 0
}
