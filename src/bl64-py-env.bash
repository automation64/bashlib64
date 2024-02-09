#######################################
# BashLib64 / Module / Globals / Interact with system-wide Python
#######################################

# shellcheck disable=SC2034
declare BL64_PY_VERSION='3.0.0'

declare BL64_PY_MODULE='0'

# Define placeholders for optional distro native python versions
declare BL64_PY_CMD_PYTHON3="$BL64_VAR_UNAVAILABLE"

# Full path to the python venv activated by bl64_py_setup
declare BL64_PY_VENV_PATH=''

# Version info
declare BL64_PY_VERSION_PYTHON3=''
declare BL64_PY_VERSION_PIP3=''

declare BL64_PY_SET_PIP_VERBOSE=''
declare BL64_PY_SET_PIP_VERSION=''
declare BL64_PY_SET_PIP_UPGRADE=''
declare BL64_PY_SET_PIP_USER=''
declare BL64_PY_SET_PIP_DEBUG=''
declare BL64_PY_SET_PIP_QUIET=''
declare BL64_PY_SET_PIP_SITE=''
declare BL64_PY_SET_PIP_NO_WARN_SCRIPT=''

declare BL64_PY_DEF_VENV_CFG='pyvenv.cfg'

declare _BL64_PY_TXT_PIP_PREPARE_PIP='upgrade pip module'
declare _BL64_PY_TXT_PIP_PREPARE_SETUP='install and upgrade setuptools modules'
declare _BL64_PY_TXT_PIP_CLEANUP_PIP='cleanup pip cache'
declare _BL64_PY_TXT_PIP_INSTALL='install modules'
declare _BL64_PY_TXT_VENV_MISSING='requested python virtual environment is missing'
declare _BL64_PY_TXT_VENV_INVALID='requested python virtual environment is invalid (no pyvenv.cfg found)'
declare _BL64_PY_TXT_VENV_CREATE='create python virtual environment'
