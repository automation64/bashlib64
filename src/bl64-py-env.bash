#######################################
# BashLib64 / Module / Globals / Interact with system-wide Python
#######################################

# shellcheck disable=SC2034
{
  declare BL64_PY_VERSION='4.2.2'

  declare BL64_PY_MODULE='0'

  # Define placeholders for optional distro native python versions
  declare BL64_PY_CMD_PYTHON3="$BL64_VAR_UNAVAILABLE"

  # Full path to the python venv activated by bl64_py_setup
  declare BL64_PY_PATH_VENV=''

  # Location of PIP installed commands, user-wide
  declare BL64_PY_PATH_PIP_USR_BIN=''

  # Version info
  declare BL64_PY_VERSION_PYTHON3=''
  declare BL64_PY_VERSION_PIP3=''

  declare BL64_PY_SET_PIP_DEBUG=''
  declare BL64_PY_SET_PIP_NO_COLOR
  declare BL64_PY_SET_PIP_NO_WARN_SCRIPT=''
  declare BL64_PY_SET_PIP_QUIET=''
  declare BL64_PY_SET_PIP_SITE=''
  declare BL64_PY_SET_PIP_UPGRADE=''
  declare BL64_PY_SET_PIP_USER=''
  declare BL64_PY_SET_PIP_VERBOSE=''
  declare BL64_PY_SET_PIP_VERSION=''

  declare BL64_PY_DEF_VENV_CFG='pyvenv.cfg'

  # Variables used by Python
  declare VIRTUAL_ENV="${VIRTUAL_ENV:-}"
}
