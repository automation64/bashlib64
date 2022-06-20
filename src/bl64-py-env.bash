#######################################
# BashLib64 / Module / Globals / Interact with system-wide Python
#
# Version: 1.8.0
#######################################

# Optional module. Not enabled by default
export BL64_PY_MODULE="$BL64_LIB_VAR_OFF"

# Define placeholders for optional distro native python versions
export BL64_PY_CMD_PYTHON3="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON35="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON36="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON37="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON38="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON39="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON310="$BL64_LIB_UNAVAILABLE"

# Full path to the python venv activated by bl64_py_setup
export BL64_PY_VENV_PATH=''

# Version info
export BL64_PY_VERSION_PYTHON3=''
export BL64_PY_VERSION_PIP3=''

export BL64_PY_SET_PIP_VERBOSE=''
export BL64_PY_SET_PIP_VERSION=''
export BL64_PY_SET_PIP_UPGRADE=''
export BL64_PY_SET_PIP_USER=''
export BL64_PY_SET_PIP_DEBUG=''
export BL64_PY_SET_PIP_QUIET=''
export BL64_PY_SET_PIP_NO_WARN_SCRIPT=''
export BL64_PY_SET_VENV_CFG=''
export BL64_PY_SET_MODULE_VENV=''
export BL64_PY_SET_MODULE_PIP=''

declare _BL64_PY_TXT_PIP_PREPARE_PIP='upgrade pip module'
declare _BL64_PY_TXT_PIP_PREPARE_SETUP='install and upgrade setuptools modules'
declare _BL64_PY_TXT_PIP_INSTALL='install modules'
declare _BL64_PY_TXT_VENV_MISSING='requested python virtual environment is missing'
declare _BL64_PY_TXT_VENV_INVALID='requested python virtual environment is invalid (no pyvenv.cfg found)'
declare _BL64_PY_TXT_VENV_CREATE='create python virtual environment'

# External commands variables
export PYTHONHOME
export PYTHONPATH
export PYTHONSTARTUP
export PYTHONDEBUG
export PYTHONUSERBASE
export PYTHONEXECUTABLE
export PYTHONWARNINGS
export VIRTUAL_ENV
