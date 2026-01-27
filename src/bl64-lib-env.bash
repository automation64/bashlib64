#######################################
# BashLib64 / Module / Globals / Setup script run-time environment
#######################################

# shellcheck disable=SC2034
{
  declare BL64_VERSION='22.13.0'

  #
  # Imported generic shell standard variables
  #

  export HOME="${HOME:-}"
  export LANG="${LANG:-}"
  export LANGUAGE="${LANGUAGE:-}"
  export LC_ALL="${LC_ALL:-}"
  export PATH="${PATH:-}"
  export PS1="${PS1:-}"
  export PS2="${PS2:-}"
  export TERM="${TERM:-}"
  export TMPDIR="${TMPDIR:-}"

  #
  # Common constants
  #

  # Default value
  declare BL64_VAR_DEFAULT='DEFAULT'
  declare BL64_VAR_DEFAULT_LEGACY='_'

  # Flag for incompatible command or task
  declare BL64_VAR_INCOMPATIBLE='_INC_'

  # Flag for unavailable command or task
  declare BL64_VAR_UNAVAILABLE='_UNV_'

  # Pseudo null value
  declare BL64_VAR_NULL='_NULL_'
  declare BL64_VAR_ALL='_ALL_'
  declare BL64_VAR_NONE='_NONE_'

  # Logical values
  declare BL64_VAR_TRUE='0'
  declare BL64_VAR_FALSE='1'
  declare BL64_VAR_ON='1'
  declare BL64_VAR_OFF='0'
  declare BL64_VAR_OK='0'
  declare BL64_VAR_NOTOK='1'
  declare BL64_VAR_YES='1'
  declare BL64_VAR_NO='0'

  #
  # Global settings
  #
  # * Allows the caller to customize bashlib64 behaviour
  # * Set the variable to the intented value before sourcing bashlib64
  #

  # Run lib as command? (On/Off)
  declare BL64_LIB_CMD="${BL64_LIB_CMD:-$BL64_VAR_OFF}"

  # Enable generic compatibility mode? (On/Off)
  declare BL64_LIB_COMPATIBILITY="${BL64_LIB_COMPATIBILITY:-$BL64_VAR_ON}"

  # Normalize locale? (On/Off)
  declare BL64_LIB_LANG="${BL64_LIB_LANG:-$BL64_VAR_ON}"

  # Enable strict security? (On/Off)
  declare BL64_LIB_STRICT="${BL64_LIB_STRICT:-$BL64_VAR_ON}"

  # Enable lib shell traps? (On/Off)
  declare BL64_LIB_TRAPS="${BL64_LIB_TRAPS:-$BL64_VAR_ON}"

  # Enable CICD operation mode? (On/Off)
  declare BL64_LIB_CICD="${BL64_LIB_CICD:-$BL64_VAR_OFF}"

  #
  # Shared exit codes
  #
  # * Exit code 1 and 2 are reserved for the caller script
  # * Exit codes for bashlib64 functions must be between 3 and 127
  #

  # Application reserved. Not used by bashlib64
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_APP_1=1
  declare -i BL64_LIB_ERROR_APP_2=2

  # Parameters
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_PARAMETER_INVALID=3
  declare -i BL64_LIB_ERROR_PARAMETER_MISSING=4
  declare -i BL64_LIB_ERROR_PARAMETER_RANGE=5
  declare -i BL64_LIB_ERROR_PARAMETER_EMPTY=6

  # Function operation
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_TASK_FAILED=10
  declare -i BL64_LIB_ERROR_TASK_BACKUP=11
  declare -i BL64_LIB_ERROR_TASK_RESTORE=12
  declare -i BL64_LIB_ERROR_TASK_TEMP=13
  declare -i BL64_LIB_ERROR_TASK_UNDEFINED=14
  declare -i BL64_LIB_ERROR_TASK_REQUIREMENTS=15

  # Module operation
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_MODULE_SETUP_INVALID=20
  declare -i BL64_LIB_ERROR_MODULE_SETUP_MISSING=21
  declare -i BL64_LIB_ERROR_MODULE_NOT_IMPORTED=22

  # OS
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_OS_NOT_MATCH=30
  declare -i BL64_LIB_ERROR_OS_TAG_INVALID=31
  declare -i BL64_LIB_ERROR_OS_INCOMPATIBLE=32
  declare -i BL64_LIB_ERROR_OS_BASH_VERSION=33

  # External commands
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_APP_INCOMPATIBLE=40
  declare -i BL64_LIB_ERROR_APP_MISSING=41

  # Filesystem
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_FILE_NOT_FOUND=50
  declare -i BL64_LIB_ERROR_FILE_NOT_READ=51
  declare -i BL64_LIB_ERROR_FILE_NOT_EXECUTE=52
  declare -i BL64_LIB_ERROR_DIRECTORY_NOT_FOUND=53
  declare -i BL64_LIB_ERROR_DIRECTORY_NOT_READ=54
  declare -i BL64_LIB_ERROR_PATH_NOT_RELATIVE=55
  declare -i BL64_LIB_ERROR_PATH_NOT_ABSOLUTE=56
  declare -i BL64_LIB_ERROR_PATH_NOT_FOUND=57
  declare -i BL64_LIB_ERROR_PATH_PRESENT=58

  # IAM
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_PRIVILEGE_IS_ROOT=60
  declare -i BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT=61
  declare -i BL64_LIB_ERROR_USER_NOT_FOUND=62
  declare -i BL64_LIB_ERROR_GROUP_NOT_FOUND=63

  # General
  # shellcheck disable=SC2034
  declare -i BL64_LIB_ERROR_EXPORT_EMPTY=70
  declare -i BL64_LIB_ERROR_EXPORT_SET=71
  declare -i BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED=72
  declare -i BL64_LIB_ERROR_CHECK_FAILED=80
  declare -i BL64_LIB_ERROR_IS_NOT=85

  #
  # Script Identify
  #

  # shellcheck disable=SC2034
  declare BL64_SCRIPT_PATH=''
  declare BL64_SCRIPT_NAME=''
  declare BL64_SCRIPT_SID=''
  declare BL64_SCRIPT_ID=''
  declare BL64_SCRIPT_VERSION='1.0.0'

  #
  # Set Signal traps
  #

  declare BL64_LIB_SIGNAL_HUP='-'
  declare BL64_LIB_SIGNAL_STOP='-'
  declare BL64_LIB_SIGNAL_QUIT='-'
  declare BL64_LIB_SIGNAL_DEBUG='-'
  declare BL64_LIB_SIGNAL_ERR='-'
  declare BL64_LIB_SIGNAL_EXIT='bl64_dbg_runtime_show'

  #
  # Common suffixes
  #
  declare BL64_LIB_SUFFIX_BACKUP='.bl64bkp'
}
