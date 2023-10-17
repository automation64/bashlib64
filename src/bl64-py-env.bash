#######################################
# BashLib64 / Module / Globals / Interact with system-wide Python
#######################################

export BL64_PY_VERSION='1.14.0'

# Optional module. Not enabled by default
export BL64_PY_MODULE="$BL64_VAR_OFF"

# Define placeholders for optional distro native python versions
export BL64_PY_CMD_PYTHON3="$BL64_VAR_UNAVAILABLE"
export BL64_PY_CMD_PYTHON35="$BL64_VAR_UNAVAILABLE"
export BL64_PY_CMD_PYTHON36="$BL64_VAR_UNAVAILABLE"
export BL64_PY_CMD_PYTHON37="$BL64_VAR_UNAVAILABLE"
export BL64_PY_CMD_PYTHON38="$BL64_VAR_UNAVAILABLE"
export BL64_PY_CMD_PYTHON39="$BL64_VAR_UNAVAILABLE"
export BL64_PY_CMD_PYTHON310="$BL64_VAR_UNAVAILABLE"
export BL64_PY_CMD_PYTHON311="$BL64_VAR_UNAVAILABLE"

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
export BL64_PY_SET_PIP_SITE=''
export BL64_PY_SET_PIP_NO_WARN_SCRIPT=''

export BL64_PY_DEF_VENV_CFG=''
export BL64_PY_DEF_MODULE_VENV=''
export BL64_PY_DEF_MODULE_PIP=''

export _BL64_PY_TXT_PIP_PREPARE_PIP='upgrade pip module'
export _BL64_PY_TXT_PIP_PREPARE_SETUP='install and upgrade setuptools modules'
export _BL64_PY_TXT_PIP_CLEANUP_PIP='cleanup pip cache'
export _BL64_PY_TXT_PIP_INSTALL='install modules'
export _BL64_PY_TXT_VENV_MISSING='requested python virtual environment is missing'
export _BL64_PY_TXT_VENV_INVALID='requested python virtual environment is invalid (no pyvenv.cfg found)'
export _BL64_PY_TXT_VENV_CREATE='create python virtual environment'
