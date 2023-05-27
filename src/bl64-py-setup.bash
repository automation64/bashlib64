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

  _bl64_py_set_command "$venv_path" &&
    bl64_check_command "$BL64_PY_CMD_PYTHON3" &&
    _bl64_py_set_options &&
    _bl64_py_set_resources &&
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
    bl64_dbg_lib_show_info 'identify OS native python3 path'
    # shellcheck disable=SC2034
    case "$BL64_OS_DISTRO" in
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*) BL64_PY_CMD_PYTHON36='/usr/bin/python3' ;;
    ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
      BL64_PY_CMD_PYTHON36='/usr/bin/python3'
      BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
      ;;
    ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.* | ${BL64_OS_ALM}-9.* | ${BL64_OS_RCK}-9.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_FD}-33.* | ${BL64_OS_FD}-34.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_FD}-35.* | ${BL64_OS_FD}-36.*) BL64_PY_CMD_PYTHON310='/usr/bin/python3.10' ;;
    ${BL64_OS_FD}-37.*) BL64_PY_CMD_PYTHON311='/usr/bin/python3.11' ;;
    ${BL64_OS_DEB}-9.*) BL64_PY_CMD_PYTHON35='/usr/bin/python3.5' ;;
    ${BL64_OS_DEB}-10.*) BL64_PY_CMD_PYTHON37='/usr/bin/python3.7' ;;
    ${BL64_OS_DEB}-11.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_UB}-18.*) BL64_PY_CMD_PYTHON36='/usr/bin/python3.6' ;;
    ${BL64_OS_UB}-20.*) BL64_PY_CMD_PYTHON38='/usr/bin/python3.8' ;;
    ${BL64_OS_UB}-21.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_UB}-22.*) BL64_PY_CMD_PYTHON310='/usr/bin/python3.10' ;;
    ${BL64_OS_UB}-23.*) BL64_PY_CMD_PYTHON310='/usr/bin/python3.11' ;;
    ${BL64_OS_SLES}-15.*)
      # Default
      BL64_PY_CMD_PYTHON36='/usr/bin/python3.6'
      # SP3
      BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
      # SP4
      BL64_PY_CMD_PYTHON310='/usr/bin/python3.10'
      ;;
    "${BL64_OS_ALP}-3.14" | "${BL64_OS_ALP}-3.15") BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    "${BL64_OS_ALP}-3.16" | "${BL64_OS_ALP}-3.17") BL64_PY_CMD_PYTHON39='/usr/bin/python3.10' ;;
    ${BL64_OS_MCOS}-12.* | ${BL64_OS_MCOS}-13.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    *) bl64_check_alert_unsupported ;;
    esac

    # Select best match for default python3
    if [[ -x "$BL64_PY_CMD_PYTHON311" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON311"
      BL64_PY_VERSION_PYTHON3='3.11'
    elif [[ -x "$BL64_PY_CMD_PYTHON310" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON310"
      BL64_PY_VERSION_PYTHON3='3.10'
    elif [[ -x "$BL64_PY_CMD_PYTHON39" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON39"
      BL64_PY_VERSION_PYTHON3='3.9'
    elif [[ -x "$BL64_PY_CMD_PYTHON38" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON38"
      BL64_PY_VERSION_PYTHON3='3.8'
    elif [[ -x "$BL64_PY_CMD_PYTHON37" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON37"
      BL64_PY_VERSION_PYTHON3='3.7'
    elif [[ -x "$BL64_PY_CMD_PYTHON36" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON36"
      BL64_PY_VERSION_PYTHON3='3.6'
    elif [[ -x "$BL64_PY_CMD_PYTHON35" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON35"
      BL64_PY_VERSION_PYTHON3='3.5'
    fi

    # Ignore VENV. Use detected python
    export VIRTUAL_ENV=''

  else
    bl64_dbg_lib_show_info 'use python3 from virtual environment'
    BL64_PY_CMD_PYTHON3="${venv_path}/bin/python3"

    # Emulate bin/activate
    export VIRTUAL_ENV="$venv_path"
    export PATH="${VIRTUAL_ENV}:${PATH}"
    unset PYTHONHOME

    # Let other basthlib64 functions know about this venv
    BL64_PY_VENV_PATH="$venv_path"
  fi

  bl64_dbg_lib_show_vars 'BL64_PY_CMD_PYTHON3' 'BL64_PY_VENV_PATH' 'VIRTUAL_ENV' 'PATH'
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

}

#######################################
# Declare version specific definitions
#
# * Use to capture default file names, values, attributes, etc
# * Do not use to capture CLI flags. Use *_set_options instead
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_py_set_resources() {
  bl64_dbg_lib_show_function

  BL64_PY_DEF_VENV_CFG='pyvenv.cfg'
  BL64_PY_DEF_MODULE_VENV='venv'
  BL64_PY_DEF_MODULE_PIP='pip'

  return 0
}
