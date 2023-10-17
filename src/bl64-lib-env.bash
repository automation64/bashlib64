#######################################
# BashLib64 / Module / Globals / Setup script run-time environment
#######################################

export BL64_VERSION='17.0.0'

#
# Imported shell standard variables
#

export LANG
export LC_ALL
export LANGUAGE
export TERM

#
# Common constants
#

# Default value for parameters
export BL64_VAR_DEFAULT='_'

# Flag for incompatible command or task
export BL64_VAR_INCOMPATIBLE='_INC_'

# Flag for unavailable command or task
export BL64_VAR_UNAVAILABLE='_UNV_'

# Pseudo null value
export BL64_VAR_NULL='_NULL_'

# Logical values
export BL64_VAR_TRUE='0'
export BL64_VAR_FALSE='1'
export BL64_VAR_ON='1'
export BL64_VAR_OFF='0'
export BL64_VAR_OK='0'
export BL64_VAR_NONE='_NONE_'
export BL64_VAR_ALL='_ALL_'

#
# Global settings
#
# * Allows the caller to customize bashlib64 behaviour
# * Set the variable to the intented value before sourcing bashlib64
#

# Run lib as command? (On/Off)
export BL64_LIB_CMD="${BL64_LIB_CMD:-$BL64_VAR_OFF}"

# Enable generic compatibility mode? (On/Off)
export BL64_LIB_COMPATIBILITY="${BL64_LIB_COMPATIBILITY:-$BL64_VAR_ON}"

# Normalize locale? (On/Off)
export BL64_LIB_LANG="${BL64_LIB_LANG:-$BL64_VAR_ON}"

# Enable strict security? (On/Off)
export BL64_LIB_STRICT="${BL64_LIB_STRICT:-$BL64_VAR_ON}"

# Enable lib shell traps? (On/Off)
export BL64_LIB_TRAPS="${BL64_LIB_TRAPS:-$BL64_VAR_ON}"

#
# Shared error codes
#
# * Warning: bashlib64 error codes must be declared in this section only to avoid module level duplicates
# * Error code 1 and 2 are reserved for the caller script
# * Codes must be between 3 and 127
#

# Application reserved. Not used by bashlib64
# declare -ig BL64_LIB_ERROR_APP_1=1
# declare -ig BL64_LIB_ERROR_APP_2=2

# Parameters
declare -ig BL64_LIB_ERROR_PARAMETER_INVALID=3
declare -ig BL64_LIB_ERROR_PARAMETER_MISSING=4
declare -ig BL64_LIB_ERROR_PARAMETER_RANGE=5
declare -ig BL64_LIB_ERROR_PARAMETER_EMPTY=6

# Function operation
declare -ig BL64_LIB_ERROR_TASK_FAILED=10
declare -ig BL64_LIB_ERROR_TASK_BACKUP=11
declare -ig BL64_LIB_ERROR_TASK_RESTORE=12
declare -ig BL64_LIB_ERROR_TASK_TEMP=13
declare -ig BL64_LIB_ERROR_TASK_UNDEFINED=14

# Module operation
declare -ig BL64_LIB_ERROR_MODULE_SETUP_INVALID=20
declare -ig BL64_LIB_ERROR_MODULE_SETUP_MISSING=21
declare -ig BL64_LIB_ERROR_MODULE_NOT_IMPORTED=22

# OS
declare -ig BL64_LIB_ERROR_OS_NOT_MATCH=30
declare -ig BL64_LIB_ERROR_OS_TAG_INVALID=31
declare -ig BL64_LIB_ERROR_OS_INCOMPATIBLE=32
declare -ig BL64_LIB_ERROR_OS_BASH_VERSION=33

# External commands
declare -ig BL64_LIB_ERROR_APP_INCOMPATIBLE=40
declare -ig BL64_LIB_ERROR_APP_MISSING=41

# Filesystem
declare -ig BL64_LIB_ERROR_FILE_NOT_FOUND=50
declare -ig BL64_LIB_ERROR_FILE_NOT_READ=51
declare -ig BL64_LIB_ERROR_FILE_NOT_EXECUTE=52
declare -ig BL64_LIB_ERROR_DIRECTORY_NOT_FOUND=53
declare -ig BL64_LIB_ERROR_DIRECTORY_NOT_READ=54
declare -ig BL64_LIB_ERROR_PATH_NOT_RELATIVE=55
declare -ig BL64_LIB_ERROR_PATH_NOT_ABSOLUTE=56
declare -ig BL64_LIB_ERROR_PATH_NOT_FOUND=57
declare -ig BL64_LIB_ERROR_PATH_PRESENT=58

# IAM
declare -ig BL64_LIB_ERROR_PRIVILEGE_IS_ROOT=60
declare -ig BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT=61
declare -ig BL64_LIB_ERROR_USER_NOT_FOUND=62
#declare -ig BL64_LIB_ERROR_GROUP_NOT_FOUND=63

# General
declare -ig BL64_LIB_ERROR_EXPORT_EMPTY=70
declare -ig BL64_LIB_ERROR_EXPORT_SET=71
declare -ig BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED=72
declare -ig BL64_LIB_ERROR_CHECK_FAILED=80

#
# Script Identify
#

export BL64_SCRIPT_PATH=''
export BL64_SCRIPT_NAME=''
export BL64_SCRIPT_SID=''
export BL64_SCRIPT_ID=''

#
# Set Signal traps
#

export BL64_LIB_SIGNAL_HUP='-'
export BL64_LIB_SIGNAL_STOP='-'
export BL64_LIB_SIGNAL_QUIT='-'
export BL64_LIB_SIGNAL_DEBUG='-'
export BL64_LIB_SIGNAL_ERR='-'
export BL64_LIB_SIGNAL_EXIT='bl64_dbg_runtime_show'

#
# Module IDs
#

export BL64_ANS_MODULE=''
export BL64_API_MODULE=''
export BL64_ARC_MODULE=''
export BL64_AWS_MODULE=''
export BL64_BSH_MODULE=''
export BL64_CHECK_MODULE=''
export BL64_CNT_MODULE=''
export BL64_DBG_MODULE=''
export BL64_FMT_MODULE=''
export BL64_FS_MODULE=''
export BL64_GCP_MODULE=''
export BL64_HLM_MODULE=''
export BL64_IAM_MODULE=''
export BL64_K8S_MODULE=''
export BL64_LOG_MODULE=''
export BL64_MDB_MODULE=''
export BL64_MSG_MODULE=''
export BL64_OS_MODULE=''
export BL64_PKG_MODULE=''
export BL64_PY_MODULE=''
export BL64_RBAC_MODULE=''
export BL64_RND_MODULE=''
export BL64_RXTX_MODULE=''
export BL64_TF_MODULE=''
export BL64_TM_MODULE=''
export BL64_TXT_MODULE=''
export BL64_UI_MODULE=''
export BL64_VCS_MODULE=''
export BL64_XSV_MODULE=''
