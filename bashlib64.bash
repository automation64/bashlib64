#!/usr/bin/env bash
#######################################
# BashLib64 / Bash automation library
#
# Author: serdigital64 (https://github.com/serdigital64)
# Repository: https://github.com/automation64/bashlib64
#
# Copyright 2022 SerDigital64@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#######################################

#
# Library Bootstrap
#

# Verify that the current shell is supported
if [ -z "$BASH_VERSION" ]; then
  echo "Fatal: BashLib64 is not supported in the current shell (shell: $SHELL)"
  exit 1
elif [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
  echo "Fatal: BashLib64 requires Bash V4 or greater (current-version: ${BASH_VERSION})"
  exit 1
fi

# Do not inherit aliases and commands
builtin unset -f unalias
builtin unset -f command
builtin unset -f set
builtin unalias -a
builtin hash -r

# Disable debugging by default. Can be reactivated with bl64_dbg_*
set +x

# Normalize shtop defaults
builtin shopt -qu \
  'dotglob' \
  'extdebug' \
  'failglob' \
  'globstar' \
  'gnu_errfmt' \
  'huponexit' \
  'lastpipe' \
  'login_shell' \
  'nocaseglob' \
  'nocasematch' \
  'nullglob' \
  'xpg_echo'
builtin shopt -qs \
  'extquote'

# Ensure pipeline exit status is failed when any cmd fails
builtin set -o 'pipefail'

# Enable error processing
builtin set -o 'errtrace'
builtin set -o 'functrace'

# Disable fast-fail. Developer must implement error handling (check for exit status)
builtin set +o 'errexit'

# Reset bash set options to defaults
builtin set -o 'braceexpand'
builtin set -o 'hashall'
builtin set +o 'allexport'
builtin set +o 'histexpand'
builtin set +o 'history'
builtin set +o 'ignoreeof'
builtin set +o 'monitor'
builtin set +o 'noclobber'
builtin set +o 'noglob'
builtin set +o 'nolog'
builtin set +o 'notify'
builtin set +o 'onecmd'
builtin set +o 'posix'

# Do not set/unset - Breaks bats-core
# set -o 'keyword'
# set -o 'noexec'

# Do not inherit sensitive environment variables
builtin unset CDPATH
builtin unset ENV
builtin unset IFS
builtin unset MAIL
builtin unset MAILPATH

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
#######################################
# BashLib64 / Module / Functions / Setup script run-time environment
#######################################

#
# Public functions
#

function bl64_lib_mode_command_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_CMD"; }
function bl64_lib_mode_compability_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_COMPATIBILITY"; }
function bl64_lib_mode_strict_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_STRICT"; }

function bl64_lib_mode_cicd_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_CICD"; }
function bl64_lib_mode_cicd_enable { BL64_LIB_CICD="$BL64_VAR_ON"; }
function bl64_lib_mode_cicd_disable { BL64_LIB_CICD="$BL64_VAR_OFF"; }

function bl64_lib_lang_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_LANG"; }
function bl64_lib_trap_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_TRAPS"; }

function bl64_lib_var_is_default {
  local value="${1:-}"
  [[ "$value" == "$BL64_VAR_DEFAULT" || "$value" == "$BL64_VAR_DEFAULT_LEGACY" ]]
}

#
# Private functions
#

# shellcheck disable=SC2164
function _bl64_lib_script_get_path() {
  local -i main=${#BASH_SOURCE[*]}
  local caller=''
  local current_path="$PWD"
  local current_cdpath=''

  ((main > 0)) && main=$((main - 1))
  caller="${BASH_SOURCE[${main}]}"

  caller="${caller%/*}"
  if [[ -n "$caller" ]]; then
    [[ -n "${CDPATH:-}" ]] && current_cdpath="$CDPATH"
    cd -- "$caller" >/dev/null 2>&1 &&
      pwd -P
    [[ -n "$current_cdpath" ]] && CDPATH="$current_cdpath"
    cd "$current_path"
  fi
}

function _bl64_lib_script_get_name() {
  local base=''
  local name="${BASH_ARGV0:-}"
  if [[ -n "$name" && "$name" != '/' ]]; then
    base="${name##*/}"
  fi
  if [[ -z "$base" || "$base" == */* ]]; then
    base='noname'
  fi
  printf '%s' "$base"
}

#######################################
# Check that the module is imported
#
# * Used for the modular version of bashlib64 to ensure dependant modules are loaded (sourced)
# * A module is considered imported if the associated shell environment variable BL64_XXX_MODULE is defined
# * This check will not verify if the module was also initialized. Use the function 'bl64_check_module' instead
#
# Arguments:
#   $1: module id (eg: BL64_XXXX_MODULE)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_MODULE_NOT_IMPORTED
#######################################
function _bl64_lib_module_is_imported() {
  local module="${1:-}"
  [[ -z "$module" ]] && return "$BL64_LIB_ERROR_PARAMETER_MISSING"

  if [[ ! -v "$module" ]]; then
    module="${module##BL64_}"
    module="${module%%_MODULE}"
    printf 'Error: required BashLib64 module not found. Please source the module before using it. (module: %s | caller: %s)\n' \
      "${module%%BL64_}" \
      "${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NA}.${FUNCNAME[2]:-NONE}@${BASH_LINENO[2]:-NA}" \
      >&2
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_MODULE_NOT_IMPORTED"
  fi
  return 0
}

#
# Public functions
#

#######################################
# Determines if the flag variable is enabled or not
#
# * Use to query flag type parameters that are called directly from the shell where bl64 vars are not yet defined
# * Primitive function: should not depend on any other function or external command
# * Flag is considered enabled when value is:
#   * $BL64_VAR_ON
#   * 'ON' | 'on' | 'On'
#   * 'YES' | 'no' | 'No'
#   * 1
#
# Arguments:
#   $1: flag value. Strings are automatically converted to uppercase
# Outputs:
#   STDOUT: None
#   STDERR: command stderr
# Returns:
#   0: flag enabled
#   BL64_LIB_ERROR_IS_NOT
#   BL64_LIB_ERROR_PARAMETER_MISSING
#######################################
function bl64_lib_flag_is_enabled {
  local -u flag="${1:-}"
  case "$flag" in
    "$BL64_VAR_ON" | 'ON' | 'YES' | '1') return 0 ;;
    "$BL64_VAR_OFF" | 'OFF' | 'NO' | '0') return 1 ;;
    *) return "$BL64_LIB_ERROR_PARAMETER_INVALID" ;;
  esac
}

#######################################
# Set script ID
#
# * Use to change the default BL64_SCRIPT_ID which is BL64_SCRIPT_NAME
#
# Arguments:
#   $1: id value
# Outputs:
#   STDOUT: None
#   STDERR: Error messages
# Returns:
#   0: id changed ok
#   >0: command error
#######################################
# shellcheck disable=SC2120
function bl64_lib_script_set_id() {
  local script_id="${1:-}"
  # shellcheck disable=SC2086
  [[ -z "$script_id" ]] && return "$BL64_LIB_ERROR_PARAMETER_MISSING"
  BL64_SCRIPT_ID="$script_id"
}

#######################################
# Define current script identity
#
# * BL64_SCRIPT_SID: session ID for the running script. Changes on each run
# * BL64_SCRIPT_PATH: full path to the base directory script
# * BL64_SCRIPT_NAME: file name of the current script
# * BL64_SCRIPT_ID: script id (tag)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Error messages
# Returns:
#   0: identity set
#   >0: failed to set
#######################################
function bl64_lib_script_set_identity() {
  BL64_SCRIPT_SID="${BASHPID}${RANDOM}" &&
    BL64_SCRIPT_PATH="$(_bl64_lib_script_get_path)" &&
    BL64_SCRIPT_NAME="$(_bl64_lib_script_get_name)" &&
    bl64_lib_script_set_id "$BL64_SCRIPT_NAME"
}

#######################################
# Define current script version
#
# Arguments:
#   $1: semver
# Outputs:
#   STDOUT: None
#   STDERR: Error messages
# Returns:
#   0: seted ok
#   >0: failed to set
#######################################
function bl64_lib_script_version_set() {
  local script_version="$1"
  # shellcheck disable=SC2086
  [[ -z "$script_version" ]] && return "$BL64_LIB_ERROR_PARAMETER_MISSING"
  BL64_SCRIPT_VERSION="$script_version"
}

#######################################
# Check that the minimum bashlib64 version is met
#
# Arguments:
#   $1: minimum bashlib64 version (semver format)
# Outputs:
#   STDOUT: None
#   STDERR: Error messages
# Returns:
#   0: version is ok
#   >0: version is not ok
#######################################
function bl64_lib_script_minver_check() {
  local minimum_version="$1"
  local -a a_parts
  local -a b_parts

  # shellcheck disable=SC2086
  [[ -z "$minimum_version" ]] && return "$BL64_LIB_ERROR_PARAMETER_MISSING"

  [[ "$minimum_version" == "$BL64_VERSION" ]] && return 0

  IFS='.'
  # shellcheck disable=SC2206
  a_parts=($minimum_version) &&
    b_parts=($BL64_VERSION)
  unset IFS

  for i in {0..2}; do
    a_part=${a_parts[i]:-0}
    b_part=${b_parts[i]:-0}
    ((a_part < b_part)) && return 0
    if ((a_part > b_part)); then
      printf 'Error: the current BashLib64 version is older than the minimum required by the script (current: %s | mininum-supported: %s)\n' \
        "$BL64_VERSION" "$minimum_version" >&2
      return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
    fi
  done
}
#######################################
# BashLib64 / Module / Globals / Check for conditions and report status
#######################################

# shellcheck disable=SC2034
{
  declare BL64_CHECK_VERSION='6.2.3'

  declare BL64_CHECK_MODULE='0'
}

#######################################
# BashLib64 / Module / Globals / Show shell debugging information
#######################################

# shellcheck disable=SC2034
{
  declare BL64_DBG_VERSION='3.3.0'

  declare BL64_DBG_MODULE='0'

  # Debug target
  declare BL64_DBG_TARGET=''

  # Dry-Run Flag
  declare BL64_DBG_DRYRUN=''

  #
  # Debug targets. Use to select what to debug and how
  #
  # * ALL_TRACE: Shell tracing for the application and bashlib64
  # * APP_TRACE: Shell tracing for selected application functions
  # * APP_TASK: Debugging messages from selected application functions
  # * APP_CMD: External commands: enable command specific debugging options used in the app
  # * APP_CUSTOM_X: Do nothing. Reserved to allow the application define custom debug
  # * APP_ALL: Enable full app debugging (task,trace,cmd)
  # * LIB_TRACE: Shell tracing for selected bashlib64 functions
  # * LIB_TASK: Debugging messages from selected bashlib64 functions
  # * LIB_CMD: External commands: enable command specific debugging options used in bashlib64
  # * LIB_ALL: Enable full bashlib64 debugging (task,trace,cmd)
  #

  declare BL64_DBG_TARGET_NONE='NONE'
  declare BL64_DBG_TARGET_APP_TRACE='APP_TRACE'
  declare BL64_DBG_TARGET_APP_TASK='APP_TASK'
  declare BL64_DBG_TARGET_APP_CMD='APP_CMD'
  declare BL64_DBG_TARGET_APP_ALL='APP'
  declare BL64_DBG_TARGET_APP_CUSTOM_1='CUSTOM_1'
  declare BL64_DBG_TARGET_APP_CUSTOM_2='CUSTOM_2'
  declare BL64_DBG_TARGET_APP_CUSTOM_3='CUSTOM_3'
  declare BL64_DBG_TARGET_LIB_TRACE='LIB_TRACE'
  declare BL64_DBG_TARGET_LIB_TASK='LIB_TASK'
  declare BL64_DBG_TARGET_LIB_CMD='LIB_CMD'
  declare BL64_DBG_TARGET_LIB_ALL='LIB'
  declare BL64_DBG_TARGET_ALL='ALL'

  #
  # Debugging exclusions
  #
  # * Used to excluded non-essential debugging information from general output
  # * Each variable represents a module
  # * Default is to exclude declared modules
  #

  declare BL64_DBG_EXCLUDE_CHECK="$BL64_VAR_ON"
  declare BL64_DBG_EXCLUDE_MSG="$BL64_VAR_ON"
  declare BL64_DBG_EXCLUDE_LOG="$BL64_VAR_ON"

  #
  # Dry-Run options
  #
  declare BL64_DBG_DRYRUN_NONE='NONE'
  declare BL64_DBG_DRYRUN_APP='APP'
  declare BL64_DBG_DRYRUN_LIB='LIB'
  declare BL64_DBG_DRYRUN_ALL='ALL'

  declare _BL64_DBG_TXT_FUNCTION_START='(start-tracing)'
  declare _BL64_DBG_TXT_FUNCTION_STOP='(stop-tracing)'
  declare _BL64_DBG_TXT_SHELL_VAR='(variable-value)'
  declare _BL64_DBG_TXT_COMMENTS='(task-comments)'
  declare _BL64_DBG_TXT_INFO='(task-info)'
  declare _BL64_DBG_TXT_CALL='(function-call)'

  declare _BL64_DBG_TXT_LABEL_BASH_RUNTIME='[bash-runtime]'
  declare _BL64_DBG_TXT_LABEL_BASH_VARIABLE='[bash-variable]'
  declare _BL64_DBG_TXT_LABEL_FUNCTION='>>>'
  declare _BL64_DBG_TXT_LABEL_INFO='==='
  declare _BL64_DBG_TXT_LABEL_TRACE='***'

  declare _BL64_DBG_TXT_CALLSTACK='Last executed function'
}

#######################################
# BashLib64 / Module / Globals / Write messages to logs
#######################################

# shellcheck disable=SC2034
{
  declare BL64_LOG_VERSION='3.0.1'

  declare BL64_LOG_MODULE='0'

  # Log file types
  declare BL64_LOG_FORMAT_CSV='C'

  # Logging categories
  declare BL64_LOG_CATEGORY_NONE='NONE'
  declare BL64_LOG_CATEGORY_INFO='INFO'
  declare BL64_LOG_CATEGORY_DEBUG='DEBUG'
  declare BL64_LOG_CATEGORY_WARNING='WARNING'
  declare BL64_LOG_CATEGORY_ERROR='ERROR'

  # Parameters
  declare BL64_LOG_REPOSITORY_MODE='0755'
  declare BL64_LOG_TARGET_MODE='0644'

  # Log Target Type
  declare BL64_LOG_TYPE_SINGLE='S'
  declare BL64_LOG_TYPE_MULTIPLE='M'

  # Module variables
  declare BL64_LOG_FS=''
  declare BL64_LOG_FORMAT=''
  declare BL64_LOG_LEVEL=''
  declare BL64_LOG_REPOSITORY=''
  declare BL64_LOG_DESTINATION=''
  declare BL64_LOG_RUNTIME=''
}

#######################################
# BashLib64 / Module / Globals / Display messages
#######################################

# shellcheck disable=SC2034
{
  declare BL64_MSG_VERSION='5.17.0'

  declare BL64_MSG_MODULE='0'

  # Target verbosity)
  declare BL64_MSG_VERBOSE=''

  #
  # Verbosity levels
  #

  declare BL64_MSG_VERBOSE_NONE='NONE'
  declare BL64_MSG_VERBOSE_APP='APP'
  declare BL64_MSG_VERBOSE_DETAIL='DETAIL'
  declare BL64_MSG_VERBOSE_LIB='LIB'
  declare BL64_MSG_VERBOSE_ALL='ALL'

  #
  # Message type tag
  #

  declare BL64_MSG_TYPE_BATCH='BATCH'
  declare BL64_MSG_TYPE_BATCHERR='BATCHERR'
  declare BL64_MSG_TYPE_BATCHOK='BATCHOK'
  declare BL64_MSG_TYPE_ERROR='ERROR'
  declare BL64_MSG_TYPE_HELP='HELP'
  declare BL64_MSG_TYPE_INFO='INFO'
  declare BL64_MSG_TYPE_INIT='INIT'
  declare BL64_MSG_TYPE_INPUT='INPUT'
  declare BL64_MSG_TYPE_LIBINFO='LIBINFO'
  declare BL64_MSG_TYPE_LIBSUBTASK='LIBSUBTASK'
  declare BL64_MSG_TYPE_LIBTASK='LIBTASK'
  declare BL64_MSG_TYPE_PHASE='PHASE'
  declare BL64_MSG_TYPE_SEPARATOR='SEPARATOR'
  declare BL64_MSG_TYPE_SUBTASK='SUBTASK'
  declare BL64_MSG_TYPE_TASK='TASK'
  declare BL64_MSG_TYPE_WARNING='WARNING'

  #
  # Message output type
  #

  declare BL64_MSG_OUTPUT_ASCII='ASCII'
  declare BL64_MSG_OUTPUT_ANSI='ANSI'
  declare BL64_MSG_OUTPUT_EMOJI='EMOJI'

  # default message output type
  declare BL64_MSG_OUTPUT=''

  #
  # Message formats
  #

  declare BL64_MSG_FORMAT_CALLER='CALLER'
  declare BL64_MSG_FORMAT_FULL='FULL'
  declare BL64_MSG_FORMAT_FULL2='FULL2'
  declare BL64_MSG_FORMAT_HOST='HOST'
  declare BL64_MSG_FORMAT_PLAIN='PLAIN'
  declare BL64_MSG_FORMAT_SCRIPT='SCRIPT'
  declare BL64_MSG_FORMAT_SCRIPT2='SCRIPT2'
  declare BL64_MSG_FORMAT_TIME='TIME'
  declare BL64_MSG_FORMAT_TIME2='TIME2'

  # Selected message format
  declare BL64_MSG_FORMAT="${BL64_MSG_FORMAT:-$BL64_MSG_FORMAT_FULL}"

  #
  # Message Themes
  #

  declare BL64_MSG_THEME_ID_ASCII_STD='ascii-std'
  declare BL64_MSG_THEME_ASCII_STD_BATCH='0'
  declare BL64_MSG_THEME_ASCII_STD_BATCHERR='0'
  declare BL64_MSG_THEME_ASCII_STD_BATCHOK='0'
  declare BL64_MSG_THEME_ASCII_STD_ERROR='0'
  declare BL64_MSG_THEME_ASCII_STD_FMTCALLER='0'
  declare BL64_MSG_THEME_ASCII_STD_FMTHOST='0'
  declare BL64_MSG_THEME_ASCII_STD_FMTTIME='0'
  declare BL64_MSG_THEME_ASCII_STD_HELP='0'
  declare BL64_MSG_THEME_ASCII_STD_INFO='0'
  declare BL64_MSG_THEME_ASCII_STD_INIT='0'
  declare BL64_MSG_THEME_ASCII_STD_INPUT='0'
  declare BL64_MSG_THEME_ASCII_STD_LIBINFO='0'
  declare BL64_MSG_THEME_ASCII_STD_LIBSUBTASK='0'
  declare BL64_MSG_THEME_ASCII_STD_LIBTASK='0'
  declare BL64_MSG_THEME_ASCII_STD_PHASE='0'
  declare BL64_MSG_THEME_ASCII_STD_SEPARATOR='0'
  declare BL64_MSG_THEME_ASCII_STD_SUBTASK='0'
  declare BL64_MSG_THEME_ASCII_STD_TASK='0'
  declare BL64_MSG_THEME_ASCII_STD_WARNING='0'

  declare BL64_MSG_THEME_ID_ANSI_STD='ansi-std'
  declare BL64_MSG_THEME_ANSI_STD_BATCH='30;1;47'
  declare BL64_MSG_THEME_ANSI_STD_BATCHERR='5;30;41'
  declare BL64_MSG_THEME_ANSI_STD_BATCHOK='30;42'
  declare BL64_MSG_THEME_ANSI_STD_ERROR='5;37;41'
  declare BL64_MSG_THEME_ANSI_STD_FMTCALLER='33'
  declare BL64_MSG_THEME_ANSI_STD_FMTHOST='34'
  declare BL64_MSG_THEME_ANSI_STD_FMTTIME='36'
  declare BL64_MSG_THEME_ANSI_STD_HELP='36'
  declare BL64_MSG_THEME_ANSI_STD_INFO='36'
  declare BL64_MSG_THEME_ANSI_STD_INIT='36'
  declare BL64_MSG_THEME_ANSI_STD_INPUT='5;30;47'
  declare BL64_MSG_THEME_ANSI_STD_LIBINFO='1;32'
  declare BL64_MSG_THEME_ANSI_STD_LIBSUBTASK='37'
  declare BL64_MSG_THEME_ANSI_STD_LIBTASK='1;35'
  declare BL64_MSG_THEME_ANSI_STD_PHASE='7;1;36'
  declare BL64_MSG_THEME_ANSI_STD_SEPARATOR='30;44'
  declare BL64_MSG_THEME_ANSI_STD_SUBTASK='37'
  declare BL64_MSG_THEME_ANSI_STD_TASK='1;35'
  declare BL64_MSG_THEME_ANSI_STD_WARNING='5;37;43'

  # Selected message theme
  declare BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'

  #
  # Emoji theme elements
  #

  # Selected message label
  declare BL64_MSG_LABEL=''

  declare BL64_MSG_LABEL_EMOJI_BATCH='(🚀)'
  declare BL64_MSG_LABEL_EMOJI_BATCHERR='(🔥)'
  declare BL64_MSG_LABEL_EMOJI_BATCHOK='(🌟)'
  declare BL64_MSG_LABEL_EMOJI_ERROR='(⛔)'
  declare BL64_MSG_LABEL_EMOJI_HELP='(🚩)'
  declare BL64_MSG_LABEL_EMOJI_INFO='(💡)'
  declare BL64_MSG_LABEL_EMOJI_INIT='(⚙️)'
  declare BL64_MSG_LABEL_EMOJI_INPUT='(📝)'
  declare BL64_MSG_LABEL_EMOJI_LIBINFO='(📚)'
  declare BL64_MSG_LABEL_EMOJI_LIBSUBTASK='(⚫)'
  declare BL64_MSG_LABEL_EMOJI_LIBTASK='(🔵)'
  declare BL64_MSG_LABEL_EMOJI_PHASE='(🎯)'
  declare BL64_MSG_LABEL_EMOJI_SEPARATOR='(🔶)'
  declare BL64_MSG_LABEL_EMOJI_SUBTASK='(🔳)'
  declare BL64_MSG_LABEL_EMOJI_TASK='(✅)'
  declare BL64_MSG_LABEL_EMOJI_WARNING='(🔔)'

  declare BL64_MSG_LABEL_ASCII_BATCH='(@)'
  declare BL64_MSG_LABEL_ASCII_BATCHERR='(@)'
  declare BL64_MSG_LABEL_ASCII_BATCHOK='(@)'
  declare BL64_MSG_LABEL_ASCII_ERROR='(!)'
  declare BL64_MSG_LABEL_ASCII_HELP='(?)'
  declare BL64_MSG_LABEL_ASCII_INFO='(i)'
  declare BL64_MSG_LABEL_ASCII_INIT='(:)'
  declare BL64_MSG_LABEL_ASCII_INPUT='(?)'
  declare BL64_MSG_LABEL_ASCII_LIBINFO='(I)'
  declare BL64_MSG_LABEL_ASCII_LIBSUBTASK='(S)'
  declare BL64_MSG_LABEL_ASCII_LIBTASK='(T)'
  declare BL64_MSG_LABEL_ASCII_PHASE='(=)'
  declare BL64_MSG_LABEL_ASCII_SEPARATOR='(#)'
  declare BL64_MSG_LABEL_ASCII_SUBTASK='(>)'
  declare BL64_MSG_LABEL_ASCII_TASK='(-)'
  declare BL64_MSG_LABEL_ASCII_WARNING='(*)'

  # ANSI codes
  #

  declare BL64_MSG_ANSI_FG_BLACK='30'
  declare BL64_MSG_ANSI_FG_RED='31'
  declare BL64_MSG_ANSI_FG_GREEN='32'
  declare BL64_MSG_ANSI_FG_BROWN='33'
  declare BL64_MSG_ANSI_FG_BLUE='34'
  declare BL64_MSG_ANSI_FG_PURPLE='35'
  declare BL64_MSG_ANSI_FG_CYAN='36'
  declare BL64_MSG_ANSI_FG_LIGHT_GRAY='37'
  declare BL64_MSG_ANSI_FG_DARK_GRAY='1;30'
  declare BL64_MSG_ANSI_FG_LIGHT_RED='1;31'
  declare BL64_MSG_ANSI_FG_LIGHT_GREEN='1;32'
  declare BL64_MSG_ANSI_FG_YELLOW='1;33'
  declare BL64_MSG_ANSI_FG_LIGHT_BLUE='1;34'
  declare BL64_MSG_ANSI_FG_LIGHT_PURPLE='1;35'
  declare BL64_MSG_ANSI_FG_LIGHT_CYAN='1;36'
  declare BL64_MSG_ANSI_FG_WHITE='1;37'

  declare BL64_MSG_ANSI_BG_BLACK='40'
  declare BL64_MSG_ANSI_BG_RED='41'
  declare BL64_MSG_ANSI_BG_GREEN='42'
  declare BL64_MSG_ANSI_BG_BROWN='43'
  declare BL64_MSG_ANSI_BG_BLUE='44'
  declare BL64_MSG_ANSI_BG_PURPLE='45'
  declare BL64_MSG_ANSI_BG_CYAN='46'
  declare BL64_MSG_ANSI_BG_LIGHT_GRAY='47'
  declare BL64_MSG_ANSI_BG_DARK_GRAY='1;40'
  declare BL64_MSG_ANSI_BG_LIGHT_RED='1;41'
  declare BL64_MSG_ANSI_BG_LIGHT_GREEN='1;42'
  declare BL64_MSG_ANSI_BG_YELLOW='1;43'
  declare BL64_MSG_ANSI_BG_LIGHT_BLUE='1;44'
  declare BL64_MSG_ANSI_BG_LIGHT_PURPLE='1;45'
  declare BL64_MSG_ANSI_BG_LIGHT_CYAN='1;46'
  declare BL64_MSG_ANSI_BG_WHITE='1;47'

  declare BL64_MSG_ANSI_CHAR_NORMAL='0'
  declare BL64_MSG_ANSI_CHAR_BOLD='1'
  declare BL64_MSG_ANSI_CHAR_UNDERLINE='4'
  declare BL64_MSG_ANSI_CHAR_BLINK='5'
  declare BL64_MSG_ANSI_CHAR_REVERSE='7'

  # Time formats

  declare BL64_MSG_TIME_DMY_HMS_FULL='%(%d/%b/%Y-%H:%M:%S-UTC%z)T'
  declare BL64_MSG_TIME_DMY_HMS_COMPACT='%(%d%b%Y:%H%M%SUTC%z)T'

  #
  # Cosmetic
  #

  declare BL64_MSG_COSMETIC_TAB2='  '
  declare BL64_MSG_COSMETIC_TAB4='    '
  declare BL64_MSG_COSMETIC_TAB6='      '
  declare BL64_MSG_COSMETIC_ARROW='-->'
  declare BL64_MSG_COSMETIC_ARROW2='==>'
  declare BL64_MSG_COSMETIC_ARROW3='>>>'
  declare BL64_MSG_COSMETIC_LEFT_ARROW='<--'
  declare BL64_MSG_COSMETIC_LEFT_ARROW2='<=='
  declare BL64_MSG_COSMETIC_LEFT_ARROW3='<<<'
  declare BL64_MSG_COSMETIC_PHASE_PREFIX='==['
  declare BL64_MSG_COSMETIC_PHASE_SUFIX=']=='
  declare BL64_MSG_COSMETIC_PHASE_PREFIX2='***'
  declare BL64_MSG_COSMETIC_PHASE_SUFIX2='***'
  declare BL64_MSG_COSMETIC_PIPE='|'
  declare BL64_MSG_COSMETIC_ARROW='-->'

  #
  # Internal
  #

  declare BL64_MSG_HELP_USAGE="$BL64_VAR_DEFAULT"
  declare BL64_MSG_HELP_ABOUT="$BL64_VAR_DEFAULT"
  declare BL64_MSG_HELP_DESCRIPTION="$BL64_VAR_DEFAULT"
  declare BL64_MSG_HELP_PARAMETERS="$BL64_VAR_DEFAULT"

}

#######################################
# BashLib64 / Module / Globals / OS / Identify OS attributes and provide command aliases
#######################################

# shellcheck disable=SC2034
{
  declare BL64_OS_VERSION='5.12.0'

  declare BL64_OS_MODULE='0'

  # Current OS Distro ID
  declare BL64_OS_DISTRO=''

  # Current OS Flavor ID
  declare BL64_OS_FLAVOR=''

  # OS Type, from uname
  declare BL64_OS_TYPE=''

  # Machine ID, from uname
  declare BL64_OS_MACHINE=''

  declare BL64_OS_CMD_BASH=''
  declare BL64_OS_CMD_CAT=''
  declare BL64_OS_CMD_DATE=''
  declare BL64_OS_CMD_FALSE=''
  declare BL64_OS_CMD_GETENT=''
  declare BL64_OS_CMD_HOSTNAME=''
  declare BL64_OS_CMD_LOCALE=''
  declare BL64_OS_CMD_SLEEP=''
  declare BL64_OS_CMD_TEE=''
  declare BL64_OS_CMD_TRUE=''
  declare BL64_OS_CMD_UNAME=''

  declare BL64_OS_SET_LOCALE_ALL=''

  #
  # OS standard name tags
  #
  # * Used to normalize OS names
  # * Value format: [A-Z]+
  #

  declare BL64_OS_ALM='ALMALINUX'
  declare BL64_OS_ALP='ALPINE'
  declare BL64_OS_AMZ='AMAZONLINUX'
  declare BL64_OS_ARC='ARCHLINUX'
  declare BL64_OS_CNT='CENTOS'
  declare BL64_OS_DEB='DEBIAN'
  declare BL64_OS_FD='FEDORA'
  declare BL64_OS_KL='KALI'
  declare BL64_OS_MCOS='DARWIN'
  declare BL64_OS_OL='ORACLELINUX'
  declare BL64_OS_RCK='ROCKYLINUX'
  declare BL64_OS_RHEL='RHEL'
  declare BL64_OS_SLES='SLES'
  declare BL64_OS_UB='UBUNTU'
  declare BL64_OS_UNK='UNKNOWN'

  #
  # OS flavor tags
  #
  # * Flavor defines groups of OS distros that are 100% compatible between them

  declare BL64_OS_FLAVOR_ALPINE='ALPINE'
  declare BL64_OS_FLAVOR_ARCH='ARCH'
  declare BL64_OS_FLAVOR_DEBIAN='DEBIAN'
  declare BL64_OS_FLAVOR_FEDORA='FEDORA'
  declare BL64_OS_FLAVOR_MACOS='MACOS'
  declare BL64_OS_FLAVOR_REDHAT='REDHAT'
  declare BL64_OS_FLAVOR_SUSE='SUSE'

  #
  # OS type tags
  #
  declare BL64_OS_TYPE_LINUX='LINUX'
  declare BL64_OS_TYPE_MACOS='MACOS'
  declare BL64_OS_TYPE_UNK='UNKNOWN'

  #
  # Machine type tags
  #
  declare BL64_OS_MACHINE_AMD64='AMD64'
  declare BL64_OS_MACHINE_ARM64='ARM64'
  declare BL64_OS_MACHINE_UNK='UNKNOWN'
}

#######################################
# BashLib64 / Module / Globals / Interact with Ansible CLI
#######################################

# shellcheck disable=SC2034
{
  declare BL64_ANS_VERSION='3.0.1'

  declare BL64_ANS_MODULE='0'

  declare BL64_ANS_ENV_IGNORE=''

  declare BL64_ANS_VERSION_CORE=''

  declare BL64_ANS_CMD_ANSIBLE="$BL64_VAR_UNAVAILABLE"
  declare BL64_ANS_CMD_ANSIBLE_PLAYBOOK="$BL64_VAR_UNAVAILABLE"
  declare BL64_ANS_CMD_ANSIBLE_GALAXY="$BL64_VAR_UNAVAILABLE"

  declare BL64_ANS_PATH_USR_ANSIBLE=''
  declare BL64_ANS_PATH_USR_COLLECTIONS=''
  declare BL64_ANS_PATH_USR_CONFIG=''

  declare BL64_ANS_SET_VERBOSE=''
  declare BL64_ANS_SET_DIFF=''
  declare BL64_ANS_SET_DEBUG=''
}

#######################################
# BashLib64 / Module / Globals / Interact with RESTful APIs
#######################################

# shellcheck disable=SC2034
{
  declare BL64_API_VERSION='2.2.1'

  declare BL64_API_MODULE='0'

  declare BL64_API_CALL_SET_MAX_RETRIES='3'
  declare BL64_API_CALL_SET_WAIT='10'

  #
  # Common constants
  #

  declare BL64_API_METHOD_DELETE='DELETE'
  declare BL64_API_METHOD_GET='GET'
  declare BL64_API_METHOD_POST='POST'
  declare BL64_API_METHOD_PUT='PUT'
}

#######################################
# BashLib64 / Module / Globals / Manage archive files
#######################################

# shellcheck disable=SC2034
{
  declare BL64_ARC_VERSION='4.4.0'

  declare BL64_ARC_MODULE='0'

  declare BL64_ARC_CMD_BUNZIP2="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_GUNZIP="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_TAR="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_UNXZ="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_UNZIP="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_ZIP="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_7ZZ="$BL64_VAR_UNAVAILABLE"

  declare BL64_ARC_SET_TAR_VERBOSE=''

  declare BL64_ARC_SET_UNZIP_OVERWRITE=''
}

#######################################
# BashLib64 / Module / Globals / Interact with AWS
#######################################

# shellcheck disable=SC2034
{
  declare BL64_AWS_VERSION='4.0.4'

  declare BL64_AWS_MODULE='0'

  declare BL64_AWS_CMD_AWS="$BL64_VAR_UNAVAILABLE"

  declare BL64_AWS_DEF_SUFFIX_TOKEN=''
  declare BL64_AWS_DEF_SUFFIX_HOME=''
  declare BL64_AWS_DEF_SUFFIX_CACHE=''
  declare BL64_AWS_DEF_SUFFIX_CONFIG=''
  declare BL64_AWS_DEF_SUFFIX_CREDENTIALS=''

  declare BL64_AWS_CLI_MODE='0700'
  declare BL64_AWS_CLI_HOME=''
  declare BL64_AWS_CLI_CONFIG=''
  declare BL64_AWS_CLI_CREDENTIALS=''
  declare BL64_AWS_CLI_REGION=''

  declare BL64_AWS_SET_FORMAT_JSON=''
  declare BL64_AWS_SET_FORMAT_TEXT=''
  declare BL64_AWS_SET_FORMAT_TABLE=''
  declare BL64_AWS_SET_FORMAT_YAML=''
  declare BL64_AWS_SET_FORMAT_STREAM=''
  declare BL64_AWS_SET_DEBUG=''
  declare BL64_AWS_SET_OUPUT_NO_PAGER=''

  declare BL64_AWS_ACCESS_PROFILE=''
  declare BL64_AWS_ACCESS_KEY_ID=''
  declare BL64_AWS_ACCESS_KEY_SECRET=''
  declare BL64_AWS_ACCESS_TOKEN=''
  declare BL64_AWS_ACCESS_ROLE=''
  declare BL64_AWS_ACCESS_MODE=''
  declare BL64_AWS_ACCESS_MODE_PROFILE='P'
  declare BL64_AWS_ACCESS_MODE_SSO='S'
  declare BL64_AWS_ACCESS_MODE_KEY='K'
  declare BL64_AWS_ACCESS_MODE_TOKEN='T'
}

#######################################
# BashLib64 / Module / Globals / Interact with Bash shell
#######################################

# shellcheck disable=SC2034
{
  declare BL64_BSH_VERSION='3.10.0'

  declare BL64_BSH_MODULE='0'

  declare BL64_BSH_VERSION_BASH=''
  declare BL64_BSH_ENV_STORE='.env.d'

  declare BL64_BSH_XDG_PATH_BIN=''
  declare BL64_BSH_XDG_PATH_CONFIG=''
  declare BL64_BSH_XDG_PATH_CACHE=''
  declare BL64_BSH_XDG_PATH_LOCAL=''

  declare BL64_BSH_JOB_SET_MAX_RETRIES='5'
  declare BL64_BSH_JOB_SET_WAIT='5'
}

#######################################
# BashLib64 / Module / Globals / Interact with container engines
#######################################

# shellcheck disable=SC2034
{
  declare BL64_CNT_VERSION='4.0.0'

  declare BL64_CNT_MODULE='0'

  declare BL64_CNT_DRIVER_DOCKER='docker'
  declare BL64_CNT_DRIVER_PODMAN='podman'
  declare BL64_CNT_DRIVER=''

  declare BL64_CNT_FLAG_STDIN='-'

  declare BL64_CNT_CMD_PODMAN=''
  declare BL64_CNT_CMD_DOCKER=''

  declare BL64_CNT_SET_DEBUG=''
  declare BL64_CNT_SET_ENTRYPOINT=''
  declare BL64_CNT_SET_FILE=''
  declare BL64_CNT_SET_FILTER=''
  declare BL64_CNT_SET_INTERACTIVE=''
  declare BL64_CNT_SET_LOG_LEVEL=''
  declare BL64_CNT_SET_NO_CACHE=''
  declare BL64_CNT_SET_PASSWORD_STDIN=''
  declare BL64_CNT_SET_PASSWORD=''
  declare BL64_CNT_SET_QUIET=''
  declare BL64_CNT_SET_RM=''
  declare BL64_CNT_SET_TAG=''
  declare BL64_CNT_SET_TTY=''
  declare BL64_CNT_SET_USERNAME=''
  declare BL64_CNT_SET_VERSION=''

  declare BL64_CNT_SET_FILTER_ID=''
  declare BL64_CNT_SET_FILTER_NAME=''
  declare BL64_CNT_SET_LOG_LEVEL_DEBUG=''
  declare BL64_CNT_SET_LOG_LEVEL_ERROR=''
  declare BL64_CNT_SET_LOG_LEVEL_INFO=''
  declare BL64_CNT_SET_STATUS_RUNNING=''
}

#######################################
# BashLib64 / Module / Globals / Cryptography tools
#######################################

# shellcheck disable=SC2034
{
  declare BL64_CRYP_VERSION='2.5.0'

  declare BL64_CRYP_MODULE='0'

  declare BL64_CRYP_CMD_GPG="$BL64_VAR_UNAVAILABLE"
  declare BL64_CRYP_CMD_OPENSSL="$BL64_VAR_UNAVAILABLE"
  declare BL64_CRYP_CMD_MD5SUM="$BL64_VAR_UNAVAILABLE"
  declare BL64_CRYP_CMD_SHA256SUM="$BL64_VAR_UNAVAILABLE"
}

#######################################
# BashLib64 / Module / Globals / Format text data
#######################################

# shellcheck disable=SC2034
{
  declare BL64_FMT_VERSION='5.1.0'

  declare BL64_FMT_MODULE='0'
}

#######################################
# BashLib64 / Module / Globals / Manage local filesystem
#######################################

# shellcheck disable=SC2034
{
  declare BL64_FS_VERSION='6.4.2'

  declare BL64_FS_MODULE='0'

  declare BL64_FS_PATH_TEMPORAL=''
  declare BL64_FS_PATH_CACHE=''
  # Location for temporary files generated by bashlib64 functions
  declare BL64_FS_PATH_TMP='/tmp'

  declare BL64_FS_CMD_CHMOD=''
  declare BL64_FS_CMD_CHOWN=''
  declare BL64_FS_CMD_CP=''
  declare BL64_FS_CMD_FIND=''
  declare BL64_FS_CMD_LN=''
  declare BL64_FS_CMD_LS=''
  declare BL64_FS_CMD_MKDIR=''
  declare BL64_FS_CMD_MKTEMP=''
  declare BL64_FS_CMD_MV=''
  declare BL64_FS_CMD_RM=''
  declare BL64_FS_CMD_TOUCH=''

  declare BL64_FS_ALIAS_CHOWN_DIR=''
  declare BL64_FS_ALIAS_CP_FILE=''
  declare BL64_FS_ALIAS_LN_SYMBOLIC=''
  declare BL64_FS_ALIAS_LS_FILES=''
  declare BL64_FS_ALIAS_MKDIR_FULL=''
  declare BL64_FS_ALIAS_MV=''
  declare BL64_FS_ALIAS_RM_FILE=''
  declare BL64_FS_ALIAS_RM_FULL=''

  declare BL64_FS_SET_CHMOD_RECURSIVE=''
  declare BL64_FS_SET_CHMOD_VERBOSE=''
  declare BL64_FS_SET_CHOWN_RECURSIVE=''
  declare BL64_FS_SET_CHOWN_VERBOSE=''
  declare BL64_FS_SET_CP_DEREFERENCE=''
  declare BL64_FS_SET_CP_FORCE=''
  declare BL64_FS_SET_CP_RECURSIVE=''
  declare BL64_FS_SET_CP_VERBOSE=''
  declare BL64_FS_SET_FIND_NAME=''
  declare BL64_FS_SET_FIND_PRINT=''
  declare BL64_FS_SET_FIND_RUN=''
  declare BL64_FS_SET_FIND_STAY=''
  declare BL64_FS_SET_FIND_TYPE_DIR=''
  declare BL64_FS_SET_FIND_TYPE_FILE=''
  declare BL64_FS_SET_LN_FORCE=''
  declare BL64_FS_SET_LN_SYMBOLIC=''
  declare BL64_FS_SET_LN_VERBOSE=''
  declare BL64_FS_SET_LS_NOCOLOR=''
  declare BL64_FS_SET_MKDIR_PARENTS=''
  declare BL64_FS_SET_MKDIR_VERBOSE=''
  declare BL64_FS_SET_MKTEMP_DIRECTORY=''
  declare BL64_FS_SET_MKTEMP_QUIET=''
  declare BL64_FS_SET_MKTEMP_TMPDIR=''
  declare BL64_FS_SET_MV_FORCE=''
  declare BL64_FS_SET_MV_VERBOSE=''
  declare BL64_FS_SET_RM_FORCE=''
  declare BL64_FS_SET_RM_RECURSIVE=''
  declare BL64_FS_SET_RM_VERBOSE=''

  #
  # File permission modes
  #
  # shellcheck disable=SC2034
  declare BL64_FS_UMASK_RW_USER='u=rwx,g=,o='
  declare BL64_FS_UMASK_RW_GROUP='u=rwx,g=rwx,o='
  declare BL64_FS_UMASK_RW_ALL='u=rwx,g=rwx,o=rwx'
  declare BL64_FS_UMASK_RW_USER_RO_ALL='u=rwx,g=rx,o=rx'
  declare BL64_FS_UMASK_RW_GROUP_RO_ALL='u=rwx,g=rwx,o=rx'

  declare BL64_FS_ARCHIVE_POSTFIX='-ARCHIVE'
  declare BL64_FS_BACKUP_POSTFIX='-BACKUP'

  declare BL64_FS_TMP_PREFIX='bl64tmp'
}

#######################################
# BashLib64 / Module / Globals / Interact with GCP
#######################################

# shellcheck disable=SC2034
{
  declare BL64_GCP_VERSION='3.0.1'

  declare BL64_GCP_MODULE='0'

  declare BL64_GCP_CMD_GCLOUD="$BL64_VAR_UNAVAILABLE"

  declare BL64_GCP_CONFIGURATION_NAME='bl64_gcp_configuration_private'
  declare BL64_GCP_CONFIGURATION_CREATED="$BL64_VAR_FALSE"

  declare BL64_GCP_SET_FORMAT_YAML=''
  declare BL64_GCP_SET_FORMAT_TEXT=''
  declare BL64_GCP_SET_FORMAT_JSON=''

  declare BL64_GCP_CLI_PROJECT=''
  declare BL64_GCP_CLI_IMPERSONATE_SA=''
}

#######################################
# BashLib64 / Module / Globals / Interact with HLM
#######################################

# shellcheck disable=SC2034
{
  declare BL64_HLM_VERSION='3.0.1'

  declare BL64_HLM_MODULE='0'

  declare BL64_HLM_CMD_HELM="$BL64_VAR_UNAVAILABLE"

  declare BL64_HLM_SET_DEBUG=''
  declare BL64_HLM_SET_OUTPUT_TABLE=''
  declare BL64_HLM_SET_OUTPUT_JSON=''
  declare BL64_HLM_SET_OUTPUT_YAML=''

  declare BL64_HLM_RUN_TIMEOUT=''
}

#######################################
# BashLib64 / Module / Globals / Manage OS identity and access service
#######################################

# shellcheck disable=SC2034
{
  declare BL64_IAM_VERSION='6.1.0'

  declare BL64_IAM_MODULE='0'

  declare BL64_IAM_CMD_USERADD="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_USERMOD="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_GROUPADD="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_GROUPMOD="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_ADDUSER="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_ADDGROUP="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_SYSADMINCTL="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_ID=''

  declare BL64_IAM_SET_USERADD_CREATE_HOME=''
  declare BL64_IAM_SET_USERADD_GROUP=''
  declare BL64_IAM_SET_USERADD_HOME_PATH=''
  declare BL64_IAM_SET_USERADD_SHELL=''
  declare BL64_IAM_SET_USERADD_UID=''

  declare BL64_IAM_ALIAS_USERADD=''

  declare BL64_IAM_SYSTEM_USER=''
  declare BL64_IAM_SYSTEM_GROUP=''
}

#######################################
# BashLib64 / Module / Globals / Interact with Kubernetes
#######################################

# shellcheck disable=SC2034
{
  declare BL64_K8S_VERSION='3.1.6'

  declare BL64_K8S_MODULE='0'

  declare BL64_K8S_CMD_KUBECTL="$BL64_VAR_UNAVAILABLE"

  declare BL64_K8S_CFG_KUBECTL_OUTPUT=''
  declare BL64_K8S_CFG_KUBECTL_OUTPUT_JSON='j'
  declare BL64_K8S_CFG_KUBECTL_OUTPUT_YAML='y'

  declare BL64_K8S_SET_VERBOSE_NONE="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_VERBOSE_NORMAL="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_VERBOSE_DEBUG="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_OUTPUT_JSON="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_OUTPUT_YAML="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_OUTPUT_TXT="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_OUTPUT_NAME="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_DRY_RUN_SERVER="$BL64_VAR_UNAVAILABLE"
  declare BL64_K8S_SET_DRY_RUN_CLIENT="$BL64_VAR_UNAVAILABLE"

  declare BL64_K8S_VERSION_KUBECTL=''

  declare BL64_K8S_RESOURCE_NS='namespace'
  declare BL64_K8S_RESOURCE_SA='serviceaccount'
  declare BL64_K8S_RESOURCE_SECRET='secret'
}

#######################################
# BashLib64 / Module / Setup / Interact with MongoDB
#######################################

# shellcheck disable=SC2034
{
  declare BL64_MDB_VERSION='2.0.2'

  declare BL64_MDB_MODULE='0'

  declare BL64_MDB_CMD_MONGOSH="$BL64_VAR_UNAVAILABLE"
  declare BL64_MDB_CMD_MONGORESTORE="$BL64_VAR_UNAVAILABLE"
  declare BL64_MDB_CMD_MONGOEXPORT="$BL64_VAR_UNAVAILABLE"

  declare BL64_MDB_SET_VERBOSE=''
  declare BL64_MDB_SET_QUIET=''
  declare BL64_MDB_SET_NORC=''

  declare BL64_MDB_REPLICA_WRITE=''
  declare BL64_MDB_REPLICA_TIMEOUT=''
}

#######################################
# BashLib64 / Module / Globals / Manage native OS packages
#######################################

# shellcheck disable=SC2034
{
  declare BL64_PKG_VERSION='6.6.0'

  declare BL64_PKG_MODULE='0'

  declare BL64_PKG_CMD_APK="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_APT="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_DPKG="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_BREW="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_DNF="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_INSTALLER="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_PACMAN="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_RPM="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_SOFTWAREUPDATE="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_YUM="$BL64_VAR_INCOMPATIBLE"
  declare BL64_PKG_CMD_ZYPPER="$BL64_VAR_INCOMPATIBLE"

  declare BL64_PKG_ALIAS_APK_CLEAN=''
  declare BL64_PKG_ALIAS_APK_INSTALL=''
  declare BL64_PKG_ALIAS_APK_CACHE=''
  declare BL64_PKG_ALIAS_APT_CLEAN=''
  declare BL64_PKG_ALIAS_APT_INSTALL=''
  declare BL64_PKG_ALIAS_APT_CACHE=''
  declare BL64_PKG_ALIAS_BRW_CLEAN=''
  declare BL64_PKG_ALIAS_BRW_INSTALL=''
  declare BL64_PKG_ALIAS_BRW_CACHE=''
  declare BL64_PKG_ALIAS_DNF_CACHE=''
  declare BL64_PKG_ALIAS_DNF_CLEAN=''
  declare BL64_PKG_ALIAS_DNF_INSTALL=''
  declare BL64_PKG_ALIAS_YUM_CACHE=''
  declare BL64_PKG_ALIAS_YUM_CLEAN=''
  declare BL64_PKG_ALIAS_YUM_INSTALL=''

  declare BL64_PKG_SET_ASSUME_YES=''
  declare BL64_PKG_SET_QUIET=''
  declare BL64_PKG_SET_SLIM=''
  declare BL64_PKG_SET_VERBOSE=''

  #
  # Common paths
  #

  declare BL64_PKG_PATH_APT_SOURCES_LIST_D=''
  declare BL64_PKG_PATH_BREW_HOME=''
  declare BL64_PKG_PATH_GPG_KEYRINGS=''
  declare BL64_PKG_PATH_YUM_REPOS_D=''

  declare BL64_PKG_DEF_SUFIX_APT_REPOSITORY='list'
  declare BL64_PKG_DEF_SUFIX_GPG_FILE='gpg'
  declare BL64_PKG_DEF_SUFIX_YUM_REPOSITORY='repo'
}

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

#######################################
# BashLib64 / Module / Globals / Manage role based access service
#######################################

# shellcheck disable=SC2034
{
  declare BL64_RBAC_VERSION='2.3.1'

  declare BL64_RBAC_MODULE='0'

  declare BL64_RBAC_CMD_SUDO=''
  declare BL64_RBAC_CMD_VISUDO=''
  declare BL64_RBAC_FILE_SUDOERS=''

  declare BL64_RBAC_ALIAS_SUDO_ENV=''

  declare BL64_RBAC_SET_SUDO_CHECK=''
  declare BL64_RBAC_SET_SUDO_FILE=''
  declare BL64_RBAC_SET_SUDO_QUIET=''
}

#######################################
# BashLib64 / Module / Globals / Generate random data
#######################################

# shellcheck disable=SC2034,SC2155
{
  declare BL64_RND_VERSION='2.0.1'

  declare BL64_RND_MODULE='0'

  declare -i BL64_RND_LENGTH_1=1
  declare -i BL64_RND_LENGTH_20=20
  declare -i BL64_RND_LENGTH_100=100
  declare -i BL64_RND_RANDOM_MIN=0
  declare -i BL64_RND_RANDOM_MAX=32767

  declare BL64_RND_POOL_UPPERCASE="$(printf '%b' "$(printf '\\%o' {65..90})")"
  declare BL64_RND_POOL_UPPERCASE_MAX_IDX="$((${#BL64_RND_POOL_UPPERCASE} - 1))"
  declare BL64_RND_POOL_LOWERCASE="$(printf '%b' "$(printf '\\%o' {97..122})")"
  declare BL64_RND_POOL_LOWERCASE_MAX_IDX="$((${#BL64_RND_POOL_LOWERCASE} - 1))"
  declare BL64_RND_POOL_DIGITS="$(printf '%b' "$(printf '\\%o' {48..57})")"
  declare BL64_RND_POOL_DIGITS_MAX_IDX="$((${#BL64_RND_POOL_DIGITS} - 1))"
  declare BL64_RND_POOL_ALPHANUMERIC="${BL64_RND_POOL_UPPERCASE}${BL64_RND_POOL_LOWERCASE}${BL64_RND_POOL_DIGITS}"
  declare BL64_RND_POOL_ALPHANUMERIC_MAX_IDX="$((${#BL64_RND_POOL_ALPHANUMERIC} - 1))"
}

#######################################
# BashLib64 / Module / Globals / Transfer and Receive data over the network
#######################################

# shellcheck disable=SC2034
{
  declare BL64_RXTX_VERSION='2.6.3'

  declare BL64_RXTX_MODULE='0'

  declare BL64_RXTX_CMD_CURL=''
  declare BL64_RXTX_CMD_WGET=''

  declare BL64_RXTX_ALIAS_CURL=''
  declare BL64_RXTX_ALIAS_WGET=''

  declare BL64_RXTX_SET_CURL_FAIL=''
  declare BL64_RXTX_SET_CURL_HEADER=''
  declare BL64_RXTX_SET_CURL_INCLUDE=''
  declare BL64_RXTX_SET_CURL_OUTPUT=''
  declare BL64_RXTX_SET_CURL_REDIRECT=''
  declare BL64_RXTX_SET_CURL_REQUEST=''
  declare BL64_RXTX_SET_CURL_SECURE=''
  declare BL64_RXTX_SET_CURL_SILENT=''
  declare BL64_RXTX_SET_CURL_VERBOSE=''
  declare BL64_RXTX_SET_WGET_OUTPUT=''
  declare BL64_RXTX_SET_WGET_SECURE=''
  declare BL64_RXTX_SET_WGET_VERBOSE=''

  #
  # GitHub specific parameters
  #

  # Public server
  declare BL64_RXTX_GITHUB_URL='https://github.com'
}

#######################################
# BashLib64 / Module / Globals / Interact with Terraform
#######################################

# shellcheck disable=SC2034
{
  declare BL64_TF_VERSION='3.1.0'

  declare BL64_TF_MODULE='0'

  declare BL64_TF_LOG_PATH=''
  declare BL64_TF_LOG_LEVEL=''

  declare BL64_TF_CMD_TERRAFORM="$BL64_VAR_UNAVAILABLE"
  declare BL64_TF_CMD_TOFU="$BL64_VAR_UNAVAILABLE"

  declare BL64_TF_VERSION_CLI=''

  # Output export formats
  declare BL64_TF_OUTPUT_RAW='0'
  declare BL64_TF_OUTPUT_JSON='1'
  declare BL64_TF_OUTPUT_TEXT='2'

  declare BL64_TF_SET_LOG_TRACE=''
  declare BL64_TF_SET_LOG_DEBUG=''
  declare BL64_TF_SET_LOG_INFO=''
  declare BL64_TF_SET_LOG_WARN=''
  declare BL64_TF_SET_LOG_ERROR=''
  declare BL64_TF_SET_LOG_OFF=''

  declare BL64_TF_DEF_PATH_LOCK=''
  declare BL64_TF_DEF_PATH_RUNTIME=''
}

#######################################
# BashLib64 / Module / Globals / Manage date-time data
#######################################

# shellcheck disable=SC2034
{
  declare BL64_TM_VERSION='2.0.1'

  declare BL64_TM_MODULE='0'
}

#######################################
# BashLib64 / Module / Globals / Manipulate text files content
#######################################

# shellcheck disable=SC2034
{
  declare BL64_TXT_VERSION='2.7.0'

  declare BL64_TXT_MODULE='0'

  declare BL64_TXT_CMD_AWK_POSIX="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_AWK="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_BASE64="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_CUT="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_ENVSUBST="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_FMT="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_GAWK="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_GREP="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_SED="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_SORT="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_TAIL="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_TR="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_UNIQ="$BL64_VAR_UNAVAILABLE"

  declare BL64_TXT_SET_AWK_POSIX="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_AWS_FS="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_ERE="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_INVERT="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_LINE="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_NO_CASE="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_ONLY_MATCHING="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_QUIET="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_SHOW_FILE_ONLY="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_STDIN="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_STRING="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_SED_EXPRESSION="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_SED_INLINE="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_SORT_NATURAL="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_TAIL_LINES="$BL64_VAR_UNAVAILABLE"

  declare BL64_TXT_FLAG_STDIN='STDIN'
}

#######################################
# BashLib64 / Module / Globals / User Interface
#######################################

# shellcheck disable=SC2034
{
  declare BL64_UI_VERSION='3.3.0'

  declare BL64_UI_MODULE='0'

  declare BL64_UI_CONFIRMATION_TIMEOUT='60'
  declare BL64_UI_CONFIRMATION_SKIP="$BL64_VAR_NO"
}

#######################################
# BashLib64 / Module / Globals / Manage Version Control System
#######################################

# shellcheck disable=SC2034
{
  declare BL64_VCS_VERSION='3.2.1'

  declare BL64_VCS_MODULE='0'

  declare BL64_VCS_CMD_GIT=''

  declare BL64_VCS_SET_GIT_NO_PAGER=''
  declare BL64_VCS_SET_GIT_QUIET=''

  #
  # GitHub related parameters
  #

  # GitHub API FQDN
  declare BL64_VCS_GITHUB_API_URL='https://api.github.com'
  # Target GitHub public API version
  declare BL64_VCS_GITHUB_API_VERSION='2022-11-28'
  # Special tag for latest release
  declare BL64_VCS_GITHUB_LATEST='latest'
}

#######################################
# BashLib64 / Module / Globals / Manipulate CSV like text files
#######################################

# shellcheck disable=SC2034
{
  declare BL64_XSV_VERSION='2.2.0'

  declare BL64_XSV_MODULE='0'

  declare BL64_XSV_CMD_PKL="$BL64_VAR_UNAVAILABLE"
  declare BL64_XSV_CMD_YQ="$BL64_VAR_UNAVAILABLE"
  declare BL64_XSV_CMD_JQ="$BL64_VAR_UNAVAILABLE"

  #
  # Field separators
  #
  # shellcheck disable=SC2034
  declare BL64_XSV_FS='_@64@_'
  declare BL64_XSV_FS_SPACE=' '
  declare BL64_XSV_FS_NEWLINE=$'\n'
  declare BL64_XSV_FS_TAB=$'\t'
  declare BL64_XSV_FS_COLON=':'
  declare BL64_XSV_FS_SEMICOLON=';'
  declare BL64_XSV_FS_COMMA=','
  declare BL64_XSV_FS_PIPE='|'
  declare BL64_XSV_FS_AT='@'
  declare BL64_XSV_FS_DOLLAR='$'
  declare BL64_XSV_FS_SLASH='/'
}

#######################################
# BashLib64 / Module / Setup / Check for conditions and report status
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_check_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    BL64_CHECK_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'check'
}

#######################################
# BashLib64 / Module / Functions / Check for conditions and report status
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_check_module_imported() {
  bl64_msg_show_deprecated 'bl64_check_module_imported' '_bl64_lib_module_is_imported'
  _bl64_lib_module_is_imported "$@"
}

function bl64_check_user() {
  bl64_msg_show_deprecated 'bl64_check_user' 'bl64_iam_check_user'
  bl64_iam_check_user "$@"
}

#
# Public functions
#

#######################################
# Check and report if the command is present and has execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the command to check
#   $2: (optional) Not found error message
#   $3: (optional) Command name. Displayed in the error message when not found
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Command found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#   $BL64_LIB_ERROR_APP_MISSING
#   $BL64_LIB_ERROR_FILE_NOT_FOUND
#   $BL64_LIB_ERROR_FILE_NOT_EXECUTE
#######################################
function bl64_check_command() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-$BL64_VAR_DEFAULT}"
  local command_name="${3:-}"

  bl64_lib_var_is_default "$message" && message='command not found. Please install it and try again'
  bl64_check_parameter 'path' ${command_name:+"command: ${command_name}"} || return $?

  if [[ "$path" == "$BL64_VAR_INCOMPATIBLE" ]]; then
    bl64_msg_show_check "command not compatible with the current OS (OS: ${BL64_OS_DISTRO}${command_name:+ | command: ${command_name}})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
  fi

  if [[ "$path" == "$BL64_VAR_UNAVAILABLE" ]]; then
    bl64_msg_show_check "${message}${command_name:+ (command: ${command_name})}"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_APP_MISSING"
  fi

  if [[ ! -e "$path" ]]; then
    bl64_msg_show_check "${message} (command: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi

  if [[ ! -x "$path" ]]; then
    bl64_msg_show_check "invalid command permissions. Set the execution permission and try again (command: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_EXECUTE"
  fi

  return 0
}

#######################################
# Check that the file is present and has read permissions for the current user.
#
# Arguments:
#   $1: Full path to the file
#   $2: Not found error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_FILE_NOT_FOUND
#   $BL64_LIB_ERROR_FILE_NOT_READ
#######################################
function bl64_check_file() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required file is not present}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_check "path is present but is not a regular file (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi
  if [[ ! -r "$path" ]]; then
    bl64_msg_show_check "required file is present but has no read permission (file: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_READ"
  fi
  return 0
}

#######################################
# Check that the directory is present and has read and execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the directory
#   $2: Not found error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
#   $BL64_LIB_ERROR_DIRECTORY_NOT_READ
#######################################
function bl64_check_directory() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required directory is not present}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_DIRECTORY_NOT_FOUND"
  fi
  if [[ ! -d "$path" ]]; then
    bl64_msg_show_check "path is present but is not a directory (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_DIRECTORY_NOT_FOUND"
  fi
  if [[ ! -r "$path" || ! -x "$path" ]]; then
    bl64_msg_show_check "required directory is present but has no read permission (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_DIRECTORY_NOT_READ"
  fi
  return 0
}

#######################################
# Check that the path is present
#
# * The target must can be of any type
#
# Arguments:
#   $1: Full path
#   $2: Not found error message.
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_FOUND
#######################################
function bl64_check_path() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required path is not present}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PATH_NOT_FOUND"
  fi
  return 0
}

#######################################
# Check for mandatory shell function parameters
#
# * Check that:
#   * variable is defined
#   * parameter is not empty
#   * parameter is not using null value
#   * parameter is not using default value: this is to allow the calling function to have several mandatory parameters before optionals
#
# Arguments:
#   $1: parameter name
#   $2: (optional) parameter description. Shown on error messages
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PARAMETER_EMPTY
#######################################
function bl64_check_parameter() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local parameter_name="${1:-}"
  local description="${2:-parameter: ${parameter_name}}"
  local parameter_ref=''

  if [[ -z "$parameter_name" ]]; then
    bl64_msg_show_check "required parameter is missing (parameter: ${parameter_name})"
    return "$BL64_LIB_ERROR_PARAMETER_EMPTY"
  fi

  if [[ ! -v "$parameter_name" ]]; then
    bl64_msg_show_check "required shell variable is not set (${description})"
    return "$BL64_LIB_ERROR_PARAMETER_MISSING"
  fi

  parameter_ref="${!parameter_name}"
  if [[ -z "$parameter_ref" || "$parameter_ref" == "${BL64_VAR_NULL}" ]]; then
    bl64_msg_show_check "required parameter is missing (${description})"
    return "$BL64_LIB_ERROR_PARAMETER_EMPTY"
  fi

  if [[ "$parameter_ref" == "${BL64_VAR_DEFAULT}" ]]; then
    bl64_msg_show_check "required parameter value must be other than default (${description})"
    return "$BL64_LIB_ERROR_PARAMETER_INVALID"
  fi
  return 0
}

#######################################
# Check shell exported environment variable:
#   - exported variable is not empty
#   - exported variable is set
#
# Arguments:
#   $1: parameter name
#   $2: parameter description. Shown on error messages
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_EXPORT_EMPTY
#   $BL64_LIB_ERROR_EXPORT_SET
#######################################
function bl64_check_export() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local export_name="${1:-}"
  local description="${2:-export: $export_name}"
  local export_ref=''

  bl64_check_parameter 'export_name' || return $?

  if [[ ! -v "$export_name" ]]; then
    bl64_msg_show_check "required shell exported variable is not set (${description})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_EXPORT_SET"
  fi

  export_ref="${!export_name}"
  if [[ -z "$export_ref" ]]; then
    bl64_msg_show_check "required shell exported variable is empty (${description})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_EXPORT_EMPTY"
  fi
  return 0
}

#######################################
# Check that the given path is relative
#
# * String check only
# * Path is not tested for existance
#
# Arguments:
#   $1: Path string
#   $2: Failed check error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_RELATIVE
#######################################
function bl64_check_path_relative() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required path must be relative}"

  bl64_check_parameter 'path' || return $?
  if [[ "$path" == '/' || "$path" == /* ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PATH_NOT_RELATIVE"
  fi
  return 0
}

#######################################
# Check that the given path is not present
#
# * The target must can be of any type
#
# Arguments:
#   $1: Full path
#   $2: Failed check error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_PRESENT
#######################################
function bl64_check_path_not_present() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-requested path is already present}"

  bl64_check_parameter 'path' || return $?
  if [[ -e "$path" ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PATH_PRESENT"
  fi
  return 0
}

#######################################
# Check that the given path is absolute
#
# * String check only
# * Path is not tested for existance
#
# Arguments:
#   $1: Path string
#   $2: Failed check error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_ABSOLUTE
#######################################
function bl64_check_path_absolute() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-required path must be absolute}"

  bl64_check_parameter 'path' || return $?
  if [[ "$path" != '/' && "$path" != /* ]]; then
    bl64_msg_show_check "${message} (path: ${path})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PATH_NOT_ABSOLUTE"
  fi
  return 0
}

#######################################
# Check that the effective user running the current process is root
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_PRIVILEGE_IS_ROOT
#######################################
function bl64_check_privilege_root() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function
  if [[ "$EUID" != '0' ]]; then
    bl64_msg_show_check "the task requires root privilege. Please run the script as root or with SUDO (current id: $EUID)"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT"
  fi
  return 0
}

#######################################
# Check that the effective user running the current process is not root
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT
#######################################
function bl64_check_privilege_not_root() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function

  if [[ "$EUID" == '0' ]]; then
    bl64_msg_show_check 'the task should not be run with root privilege. Please run the script as a regular user and not using SUDO'
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PRIVILEGE_IS_ROOT"
  fi
  return 0
}

#######################################
# Check file/dir overwrite condition and fail if not meet
#
# * Use for tasks that needs to ensure that previous content will not overwriten unless requested
# * Target path can be of any type
#
# Arguments:
#   $1: Full path to the object
#   $2: Overwrite flag. Must be ON(1) or OFF(0). Default: OFF
#   $3: Error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: no previous file/dir or overwrite is requested
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED
#######################################
function bl64_check_overwrite() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local overwrite="${2:-$BL64_VAR_OFF}"
  local message="${3:-target is already present and overwrite is not permitted. Unable to continue}"

  bl64_check_parameter 'path' || return $?

  if ! bl64_lib_flag_is_enabled "$overwrite" || bl64_lib_var_is_default "$overwrite"; then
    if [[ -e "$path" ]]; then
      bl64_msg_show_check "${message} (path: ${path})"
      return "$BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED"
    fi
  fi

  return 0
}

#######################################
# Check file/dir overwrite condition and warn if not meet
#
# * Use for tasks that will do nothing if the target is already present
# * Warning: Caller is responsible for checking that path parameter is valid
# * Target path can be of any type
#
# Arguments:
#   $1: Full path to the object
#   $2: Overwrite flag. Must be ON(1) or OFF(0). Default: OFF
#   $3: Warning message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: skip since previous file/dir is present
#   1: no previous file/dir present or overwrite is requested
#######################################
function bl64_check_overwrite_skip() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local overwrite="${2:-$BL64_VAR_OFF}"
  local message="${3:-}"

  bl64_check_parameter 'path'

  if ! bl64_lib_flag_is_enabled "$overwrite" || bl64_lib_var_is_default "$overwrite"; then
    if [[ -e "$path" ]]; then
      bl64_msg_show_warning "${message:-target is already present and overwrite is not requested. Target is left as is} (path: ${path})"
      return 0
    fi
  fi

  return 1
}

#######################################
# Raise error: invalid parameter
#
# * Use to raise an error when the calling function has verified that the parameter is not valid
# * This is a generic enough message to capture most validation use cases when there is no specific bl64_check_*
# * Can be used as the default value (*) for the bash command "case" to capture invalid options
#
# Arguments:
#   $1: parameter name
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
# shellcheck disable=SC2120
function bl64_check_alert_parameter_invalid() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local parameter="${1:-${BL64_VAR_DEFAULT}}"
  local message="${2:-the requested operation was provided with an invalid parameter value}"

  bl64_lib_var_is_default "$parameter" && parameter=''
  bl64_msg_show_check "${message} ${parameter:+(parameter: ${parameter})}"
  return "$BL64_LIB_ERROR_PARAMETER_INVALID"
}

#######################################
# Raise unsupported platform error
#
# Arguments:
#   $1: extra error message. Added to the error detail between (). Default: none
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_OS_INCOMPATIBLE
#######################################
function bl64_check_alert_unsupported() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local extra="${1:-}"

  bl64_msg_show_check "the requested operation is not supported on the current OS (${extra:+${extra} ${BL64_MSG_COSMETIC_PIPE} }os: ${BL64_OS_DISTRO})"
  return "$BL64_LIB_ERROR_OS_INCOMPATIBLE"
}

#######################################
# Check that the compatibility mode is enabled to support untested command
#
# * If enabled, show a warning and continue OK
# * If not enabled, fail
#
# Arguments:
#   $1: extra error message. Added to the error detail between (). Default: none
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: using compatibility mode
#   >0: command is incompatible and compatibility mode is disabled
#######################################
function bl64_check_compatibility_mode() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local extra="${1:-}"

  if bl64_lib_mode_compability_is_enabled; then
    bl64_msg_show_warning "using generic compatibility mode for untested command version (${extra:+${extra} ${BL64_MSG_COSMETIC_PIPE} }os: ${BL64_OS_DISTRO})"
  else
    bl64_check_alert_unsupported "$extra"
    return $?
  fi
}

#######################################
# Raise resource not detected error
#
# * Generic error used when a required external resource is not found on the system
# * Common use case: module setup looking for command in known locations
#
# Arguments:
#   $1: resource name. Default: none
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_APP_MISSING
#######################################
function bl64_check_alert_resource_not_found() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local resource="${1:-}"

  bl64_msg_show_check "required resource was not found on the system (${resource:+resource: ${resource} ${BL64_MSG_COSMETIC_PIPE} }os: ${BL64_OS_DISTRO})"
  return "$BL64_LIB_ERROR_APP_MISSING"
}

#######################################
# Raise undefined command error
#
# * Commonly used in the default branch of case statements to catch undefined options
#
# Arguments:
#   $1: command
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
# shellcheck disable=SC2119,SC2120
function bl64_check_alert_undefined() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local target="${1:-}"

  bl64_msg_show_check "requested command is not defined or implemented (${target:+ ${BL64_MSG_COSMETIC_PIPE} command: ${target}})"
  return "$BL64_LIB_ERROR_TASK_UNDEFINED"
}

#######################################
# Raise module setup error
#
# * Helper to check if the module was correctly setup and raise error if not
# * Use as last function of bl64_*_setup
# * Will take the last exit status
#
# Arguments:
#   $1: bashlib64 module alias
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   $status
#######################################
function bl64_check_alert_module_setup() {
  local -i last_status=$? # must be first line to catch $?
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local module="${1:-}"

  bl64_check_parameter 'module' || return $?

  if [[ "$last_status" != '0' ]]; then
    bl64_msg_show_check "BashLib64 module setup failure (module: ${module})"
    return "$last_status"
  else
    return 0
  fi
}

#######################################
# Check that at least 1 parameter is passed when using dynamic arguments
#
# Arguments:
#   $1: must be $# to capture number of parameters from the calling function
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_parameters_none() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local count="${1:-}"
  local message="${2:-the requested operation requires at least one parameter and none was provided}"

  bl64_check_parameter 'count' || return $?

  if [[ "$count" == '0' ]]; then
    bl64_msg_show_check "${message}"
    return "$BL64_LIB_ERROR_PARAMETER_MISSING"
  else
    return 0
  fi
}

#######################################
# Check that the module is loaded and has been setup
#
# * Use in functions that depends on module resources being present before execution
#
# Arguments:
#   $1: module id (eg: BL64_XXXX_MODULE)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_MODULE_SETUP_MISSING
#######################################
function bl64_check_module() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local module="${1:-}"
  local setup_status=''

  bl64_check_parameter 'module' &&
    _bl64_lib_module_is_imported "$module" ||
    return $?

  setup_status="${!module}"
  if [[ "$setup_status" == "$BL64_VAR_OFF" ]]; then
    bl64_msg_show_check "required BashLib64 module is not setup. Call the bl64_<MODULE>_setup function before using the module (module: ${module})"
    return "$BL64_LIB_ERROR_MODULE_SETUP_MISSING"
  fi

  return 0
}

#######################################
# Check exit status
#
# * Helper to check for exit status of the last executed command and show error if failed
# * Return the same status as the latest command. This is to facilitate chaining with && return $? or be the last command of the function
#
# Arguments:
#   $1: exit status
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   $status
#######################################
function bl64_check_status() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local status="${1:-}"
  local message="${2:-task execution failed}"

  bl64_check_parameter 'status' || return $?

  if [[ "$status" != '0' ]]; then
    bl64_msg_show_check "${message} (status: ${status})"
    # shellcheck disable=SC2086
    return "$status"
  else
    return 0
  fi
}

#######################################
# Check that the HOME variable is present and the path is valid
#
# * HOME is the standard shell variable for current user's home
#
# Arguments:
#   None
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: home is valid
#   >0: home is not valid
#######################################
function bl64_check_home() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function

  bl64_check_export 'HOME' 'standard shell variable HOME is not defined' &&
    bl64_check_directory "$HOME" "unable to find user's HOME directory"
}

#######################################
# Check and report if the command is available using the current search path
#
# * standar PATH variable is used for the search
# * aliases and built-in commands will always return true
# * if the command is in the search path, then bl64_check_command is used to ensure it can be used
#
# Arguments:
#   $1: command file name
#   $2: Not found error message.
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Command found
#   BL64_LIB_ERROR_FILE_NOT_FOUND
#######################################
function bl64_check_command_search_path() {
  _bl64_dbg_lib_check_is_enabled && bl64_dbg_lib_show_function "$@"
  local file="${1:-}"
  local message="${2:-required command is not found in any of the search paths}"
  local full_path=''

  bl64_check_parameter 'file' || return $?

  full_path="$(type -p "${file}")"
  # shellcheck disable=SC2181
  if (($? != 0)); then
    bl64_msg_show_check "${message} (command: ${file})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi

  bl64_check_command "$full_path"
}

#######################################
# BashLib64 / Module / Setup / Show shell debugging inlevelion
#######################################

#
# Debugging level status
#
function bl64_dbg_app_task_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_TASK" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_task_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_TASK" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_command_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CMD" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_command_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_CMD" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_trace_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_TRACE" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_trace_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_TRACE" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_custom_1_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_1" ]]; }
function bl64_dbg_app_custom_2_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_2" ]]; }
function bl64_dbg_app_custom_3_is_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_3" ]]; }
function _bl64_dbg_lib_check_is_enabled { [[ "$BL64_DBG_EXCLUDE_CHECK" == "$BL64_VAR_OFF" ]]; }
function _bl64_dbg_lib_log_is_enabled { [[ "$BL64_DBG_EXCLUDE_LOG" == "$BL64_VAR_OFF" ]]; }
function _bl64_dbg_lib_msg_is_enabled { [[ "$BL64_DBG_EXCLUDE_MSG" == "$BL64_VAR_OFF" ]]; }

#
# Debugging level control
#
function bl64_dbg_all_disable { BL64_DBG_TARGET="$BL64_DBG_TARGET_NONE"; }
function bl64_dbg_all_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_ALL"; }
function bl64_dbg_app_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_ALL"; }
function bl64_dbg_lib_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_ALL"; }
function bl64_dbg_app_task_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_TASK"; }
function bl64_dbg_lib_task_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_TASK"; }
function bl64_dbg_app_command_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CMD"; }
function bl64_dbg_lib_command_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_CMD"; }
function bl64_dbg_app_trace_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_TRACE"; }
function bl64_dbg_lib_trace_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_TRACE"; }
function bl64_dbg_app_custom_1_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_1"; }
function bl64_dbg_app_custom_2_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_2"; }
function bl64_dbg_app_custom_3_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_3"; }

function _bl64_dbg_lib_check_enable { BL64_DBG_EXCLUDE_CHECK="$BL64_VAR_OFF"; }
function _bl64_dbg_lib_log_enable { BL64_DBG_EXCLUDE_LOG="$BL64_VAR_OFF"; }
function _bl64_dbg_lib_msg_enable { BL64_DBG_EXCLUDE_MSG="$BL64_VAR_OFF"; }

#
# Dry-Run execution control
#
function bl64_dbg_app_dryrun_is_enabled { [[ "$BL64_DBG_DRYRUN" == "$BL64_DBG_DRYRUN_ALL" || "$BL64_DBG_DRYRUN" == "$BL64_DBG_DRYRUN_APP" ]]; }
function bl64_dbg_lib_dryrun_is_enabled { [[ "$BL64_DBG_DRYRUN" == "$BL64_DBG_DRYRUN_ALL" || "$BL64_DBG_DRYRUN" == "$BL64_DBG_DRYRUN_LIB" ]]; }
function bl64_dbg_all_dryrun_disable { BL64_DBG_DRYRUN="$BL64_DBG_DRYRUN_NONE"; }
function bl64_dbg_all_dryrun_enable { BL64_DBG_DRYRUN="$BL64_DBG_DRYRUN_ALL"; }
function bl64_dbg_app_dryrun_enable { BL64_DBG_DRYRUN="$BL64_DBG_DRYRUN_APP"; }
function bl64_dbg_lib_dryrun_enable { BL64_DBG_DRYRUN="$BL64_DBG_DRYRUN_LIB"; }

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
# * Warning: keep this module independant (do not depend on other bl64 modules)
# * Debugging messages are disabled by default
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_dbg_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  bl64_dbg_all_disable &&
    bl64_dbg_all_dryrun_disable &&
    BL64_DBG_MODULE="$BL64_VAR_ON"
}

#######################################
# Set debugging level
#
# Arguments:
#   $1: target level. One of BL64_DBG_TARGET_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_dbg_set_level() {
  local level="$1"
  case "$level" in
  "$BL64_DBG_TARGET_NONE") bl64_dbg_all_disable ;;
  "$BL64_DBG_TARGET_APP_TRACE") bl64_dbg_app_trace_enable ;;
  "$BL64_DBG_TARGET_APP_TASK") bl64_dbg_app_task_enable ;;
  "$BL64_DBG_TARGET_APP_CMD") bl64_dbg_app_command_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_1") bl64_dbg_app_custom_1_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_2") bl64_dbg_app_custom_2_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_3") bl64_dbg_app_custom_3_enable ;;
  "$BL64_DBG_TARGET_APP_ALL") bl64_dbg_app_enable ;;
  "$BL64_DBG_TARGET_LIB_TRACE") bl64_dbg_lib_trace_enable ;;
  "$BL64_DBG_TARGET_LIB_TASK") bl64_dbg_lib_task_enable ;;
  "$BL64_DBG_TARGET_LIB_CMD") bl64_dbg_lib_command_enable ;;
  "$BL64_DBG_TARGET_LIB_ALL") bl64_dbg_lib_enable ;;
  "$BL64_DBG_TARGET_ALL") bl64_dbg_all_enable ;;
  *)
    _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] invalid debugging level. Must be one of: ${BL64_DBG_TARGET_ALL}|${BL64_DBG_TARGET_APP_ALL}|${BL64_DBG_TARGET_LIB_ALL}|${BL64_DBG_TARGET_NONE}"
    return "$BL64_LIB_ERROR_PARAMETER_INVALID"
    ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Show shell debugging information
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_dbg_app_show_variables() {
  bl64_msg_show_deprecated 'bl64_dbg_app_show_variables' 'bl64_dbg_app_show_globals'
  bl64_dbg_app_show_globals "$@"
}
function bl64_dbg_lib_show_variables() {
  bl64_msg_show_deprecated 'bl64_dbg_lib_show_variables' 'bl64_dbg_lib_show_globals'
  bl64_dbg_lib_show_globals "$@"
}
function bl64_dbg_app_task_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_task_enabled' 'bl64_dbg_app_task_is_enabled'
  bl64_dbg_app_task_is_enabled
}
function bl64_dbg_lib_task_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_task_enabled' 'bl64_dbg_lib_task_is_enabled'
  bl64_dbg_lib_task_is_enabled
}
function bl64_dbg_app_command_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_command_enabled' 'bl64_dbg_app_command_is_enabled'
  bl64_dbg_app_command_is_enabled
}
function bl64_dbg_lib_command_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_command_enabled' 'bl64_dbg_lib_command_is_enabled'
  bl64_dbg_lib_command_is_enabled
}
function bl64_dbg_app_trace_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_trace_enabled' 'bl64_dbg_app_trace_is_enabled'
  bl64_dbg_app_trace_is_enabled
}
function bl64_dbg_lib_trace_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_trace_enabled' 'bl64_dbg_lib_trace_is_enabled'
  bl64_dbg_lib_trace_is_enabled
}
function bl64_dbg_app_custom_1_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_custom_1_enabled' 'bl64_dbg_app_custom_1_is_enabled'
  bl64_dbg_app_custom_1_is_enabled
}
function bl64_dbg_app_custom_2_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_custom_2_enabled' 'bl64_dbg_app_custom_2_is_enabled'
  bl64_dbg_app_custom_2_is_enabled
}
function bl64_dbg_app_custom_3_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_app_custom_3_enabled' 'bl64_dbg_app_custom_3_is_enabled'
  bl64_dbg_app_custom_3_is_enabled
}
function bl64_dbg_lib_check_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_check_enabled' '_bl64_dbg_lib_check_is_enabled'
  _bl64_dbg_lib_check_is_enabled
}
function bl64_dbg_lib_log_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_log_enabled' '_bl64_dbg_lib_log_is_enabled'
  _bl64_dbg_lib_log_is_enabled
}
function bl64_dbg_lib_msg_enabled {
  bl64_msg_show_deprecated 'bl64_dbg_lib_msg_enabled' '_bl64_dbg_lib_msg_is_enabled'
  _bl64_dbg_lib_msg_is_enabled
}

#
# Internal functions
#

function _bl64_dbg_show() {
  local message="$1"
  printf '%s: %s\n' '[Debug]' "$message" >&2
}

function _bl64_dbg_dryrun_show() {
  local message="$1"
  printf '%s: %s\n' '[Dry-Run]' "$message"
}

#
# Public functions
#

#######################################
# Show runtime info
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: runtime info
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show() {
  local -i last_status=$?
  local label="${_BL64_DBG_TXT_LABEL_BASH_RUNTIME}"
  bl64_dbg_app_command_is_enabled || return "$last_status"

  _bl64_dbg_show "${label} Bash / Interpreter path: [${BASH}]"
  _bl64_dbg_show "${label} Bash / ShOpt Options: [${BASHOPTS:-NONE}]"
  _bl64_dbg_show "${label} Bash / Set -o Options: [${SHELLOPTS:-NONE}]"
  _bl64_dbg_show "${label} Bash / Version: [${BASH_VERSION}]"
  _bl64_dbg_show "${label} Bash / Detected OS: [${OSTYPE:-NONE}]"
  _bl64_dbg_show "${label} Shell / Locale setting: [${LC_ALL:-NONE}]"
  _bl64_dbg_show "${label} Shell / Hostname: [${HOSTNAME:-EMPTY}]"
  _bl64_dbg_show "${label} Script / User ID: [${EUID}]"
  _bl64_dbg_show "${label} Script / Effective User ID: [${UID}]"
  _bl64_dbg_show "${label} Script / Arguments: [${BASH_ARGV[*]:-NONE}]"
  _bl64_dbg_show "${label} Script / Last executed command: [${BASH_COMMAND:-NONE}]"
  _bl64_dbg_show "${label} Script / Last exit status: [${last_status}]"

  bl64_dbg_runtime_show_paths
  bl64_dbg_runtime_show_callstack
  bl64_dbg_runtime_show_bashlib64

  # shellcheck disable=SC2248
  return "$last_status"
}

#######################################
# Show BashLib64 runtime information
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: bl64 runtime info
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show_bashlib64() {
  local label='[bl64-runtime]'
  bl64_dbg_app_task_is_enabled || bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${label} BL64_SCRIPT_NAME: [${BL64_SCRIPT_NAME:-NOTSET}]"
  _bl64_dbg_show "${label} BL64_SCRIPT_SID: [${BL64_SCRIPT_SID:-NOTSET}]"
  _bl64_dbg_show "${label} BL64_SCRIPT_ID: [${BL64_SCRIPT_ID:-NOTSET}]"
  _bl64_dbg_show "${label} BL64_SCRIPT_VERSION: [${BL64_SCRIPT_VERSION:-NOTSET}]"
}

#######################################
# Show runtime call stack
#
# * Show previous 3 functions from the current caller
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: callstack
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show_callstack() {
  local label="${_BL64_DBG_TXT_LABEL_BASH_RUNTIME}"
  bl64_dbg_app_task_is_enabled || bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${label} ${_BL64_DBG_TXT_CALLSTACK}(2): [${BASH_SOURCE[1]:-NONE}:${FUNCNAME[2]:-NONE}:${BASH_LINENO[2]:-0}]"
  _bl64_dbg_show "${label} ${_BL64_DBG_TXT_CALLSTACK}(3): [${BASH_SOURCE[2]:-NONE}:${FUNCNAME[3]:-NONE}:${BASH_LINENO[3]:-0}]"
  _bl64_dbg_show "${label} ${_BL64_DBG_TXT_CALLSTACK}(4): [${BASH_SOURCE[3]:-NONE}:${FUNCNAME[4]:-NONE}:${BASH_LINENO[4]:-0}]"
  _bl64_dbg_show "${label} ${_BL64_DBG_TXT_CALLSTACK}(5): [${BASH_SOURCE[4]:-NONE}:${FUNCNAME[5]:-NONE}:${BASH_LINENO[5]:-0}]"
}

#######################################
# Show runtime paths
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: callstack
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show_paths() {
  local label="${_BL64_DBG_TXT_LABEL_BASH_RUNTIME}"
  bl64_dbg_app_task_is_enabled || bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${label} Initial script path (BL64_SCRIPT_PATH): [${BL64_SCRIPT_PATH:-EMPTY}]"
  _bl64_dbg_show "${label} Home directory (HOME): [${HOME:-EMPTY}]"
  _bl64_dbg_show "${label} Search path (PATH): [${PATH:-EMPTY}]"
  _bl64_dbg_show "${label} Current cd working directory (PWD): [${PWD:-EMPTY}]"
  _bl64_dbg_show "${label} Previous cd working directory (OLDPWD): [${OLDPWD:-EMPTY}]"
  _bl64_dbg_show "${label} Current working directory (pwd command): [$(pwd)]"
  _bl64_dbg_show "${label} Temporary path (TMPDIR): [${TMPDIR:-NONE}]"
}

#######################################
# Stop app  shell tracing
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   exit status from previous command
#######################################
function bl64_dbg_app_trace_stop() {
  local -i state=$?
  bl64_dbg_app_trace_is_enabled || return "$state"
  set +x
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"
  return "$state"
}

#######################################
# Start app  shell tracing if target is in scope
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_trace_start() {
  bl64_dbg_app_trace_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
  set -x
  return 0
}

#######################################
# Stop bashlib64 shell tracing
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   Saved exit status
#######################################
function bl64_dbg_lib_trace_stop() {
  local -i state=$?
  bl64_dbg_lib_trace_is_enabled || return "$state"

  set +x
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"

  return "$state"
}

#######################################
# Start bashlib64 shell tracing if target is in scope
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_trace_start() {
  bl64_dbg_lib_trace_is_enabled || return 0

  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
  set -x

  return 0
}

#######################################
# Show bashlib64 task level debugging information
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_info() {
  bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_INFO}: ${*}"
  return 0
}

#######################################
# Show app task level debugging information
#
# Arguments:
#   $@: messages
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_info() {
  bl64_dbg_app_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_INFO}: ${*}"
  return 0
}

#######################################
# Show bashlib64 task level variable values
#
# Arguments:
#   $@: variable names
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_vars() {
  local variable=''
  local value=''
  bl64_dbg_lib_task_is_enabled || return 0

  for variable in "$@"; do
    if [[ ! -v "$variable" ]]; then
      value="${variable}->**UNSET**"
    else
      value="${variable}=${!variable}"
    fi

    _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_SHELL_VAR}: [${value}]"
  done

  return 0
}

#######################################
# Show app task level variable values
#
# Arguments:
#   $@: variable names
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_vars() {
  local variable=''
  local value=''
  bl64_dbg_app_task_is_enabled || return 0

  for variable in "$@"; do
    if [[ ! -v "$variable" ]]; then
      value="${variable}->**UNSET**"
    else
      value="${variable}=${!variable}"
    fi

    _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_SHELL_VAR}: [${value}]"
  done

  return 0
}

#######################################
# Show bashlib64 function name and parameters
#
# Arguments:
#   $@: parameters
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2120
function bl64_dbg_lib_show_function() {
  bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_FUNCTION} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CALL} parameters: ${*}"
  return 0
}

#######################################
# Show app function name and parameters
#
# Arguments:
#   $@: parameters
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2120
function bl64_dbg_app_show_function() {
  bl64_dbg_app_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_FUNCTION} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CALL} parameters: (${*})"
  return 0
}

#######################################
# Stop bashlib64 external command tracing
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   Saved exit status
#######################################
function bl64_dbg_lib_command_trace_stop() {
  local -i state=$?
  bl64_dbg_lib_task_is_enabled || return "$state"

  set +x
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"

  return "$state"
}

#######################################
# Start bashlib64 external command tracing if target is in scope
#
# * Use in functions: bl64_*_run_*
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_command_trace_start() {
  bl64_dbg_lib_task_is_enabled || return 0

  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_TRACE} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
  set -x

  return 0
}

#######################################
# Show developer comments in bashlib64 functions
#
# Arguments:
#   $1: comments
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_comments() {
  bl64_dbg_lib_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_COMMENTS}: ${*}"
  return 0
}

#######################################
# Show developer comments in app functions
#
# Arguments:
#   $@: comments
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_comments() {
  bl64_dbg_app_task_is_enabled || return 0
  _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_INFO} (${#FUNCNAME[*]})[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_COMMENTS}: ${*}"
  return 0
}

#######################################
# Show non BL64 global variables and attributes
#
# Arguments:
#   None
# Outputs:
#   STDOUT: declare -p output
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_globals() {
  bl64_dbg_app_task_is_enabled || return 0
  local filter='^declare .*BL64_.*=.*'

  IFS=$'\n'
  for variable in $(declare -p); do
    unset IFS
    [[ "$variable" =~ $filter || "$variable" =~ "declare -- filter=" ]] && continue
    _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_BASH_VARIABLE} ${variable}"
  done
  return 0
}

#######################################
# Show BL64 global variables and attributes
#
# Arguments:
#   None
# Outputs:
#   STDOUT: declare -p output
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_globals() {
  bl64_dbg_lib_task_is_enabled || return 0
  local filter='^declare .*BL64_.*=.*'

  IFS=$'\n'
  for variable in $(declare -p); do
    unset IFS
    [[ ! "$variable" =~ $filter || "$variable" =~ "declare -- filter=" ]] && continue
    _bl64_dbg_show "${_BL64_DBG_TXT_LABEL_BASH_VARIABLE} ${variable}"
  done
  return 0
}

#######################################
# Show app level dryrun information
#
# Arguments:
#   $@: messages
# Outputs:
#   STDOUT: Dryrun message
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_dryrun_show() {
  bl64_dbg_app_dryrun_is_enabled || return 0
  _bl64_dbg_dryrun_show "$@"
  return 0
}

#######################################
# Show lib level dryrun information
#
# Arguments:
#   $@: messages
# Outputs:
#   STDOUT: Dryrun message
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_dryrun_show() {
  bl64_dbg_lib_dryrun_is_enabled || return 0
  _bl64_dbg_dryrun_show "$@"
  return 0
}

#######################################
# BashLib64 / Module / Setup / Write messages to logs
#######################################

function _bl64_log_set_target_single() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local target="$1"
  local destination="${BL64_LOG_REPOSITORY}/${target}.log"

  [[ "$BL64_LOG_DESTINATION" == "$destination" ]] && return 0
  bl64_fs_file_create "$destination" "$BL64_LOG_TARGET_MODE" &&
    BL64_LOG_DESTINATION="$destination"
}

function _bl64_log_set_target_multiple() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local target="$1"
  local destination="${BL64_LOG_REPOSITORY}/${target}_"

  destination+="$(printf '%(%FT%TZ%z)T' '-1').log" || return $?
  [[ "$BL64_LOG_DESTINATION" == "$destination" ]] && return 0

  bl64_fs_file_create "$destination" "$BL64_LOG_TARGET_MODE" &&
    BL64_LOG_DESTINATION="$destination"
}

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: log repository. Full path
#   $2: log target. Default: BL64_SCRIPT_ID
#   $3: target type. One of BL64_LOG_TYPE_*
#   $4: level. One of BL64_LOG_CATEGORY_*
#   $5: format. One of BL64_LOG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function bl64_log_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local log_repository="${1:-}"
  local log_target="${2:-${BL64_VAR_DEFAULT}}"
  local log_type="${3:-${BL64_VAR_DEFAULT}}"
  local log_level="${4:-${BL64_VAR_DEFAULT}}"
  local log_format="${5:-${BL64_VAR_DEFAULT}}"

  bl64_lib_var_is_default "$log_target" && log_target="$BL64_SCRIPT_ID"
  bl64_lib_var_is_default "$log_type" && log_type="$BL64_LOG_TYPE_SINGLE"
  bl64_lib_var_is_default "$log_level" && log_level="$BL64_LOG_CATEGORY_NONE"
  bl64_lib_var_is_default "$log_format" && log_format="$BL64_LOG_FORMAT_CSV"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    bl64_check_parameter 'log_repository' &&
    bl64_log_set_repository "$log_repository" &&
    bl64_log_set_target "$log_target" "$log_type" &&
    bl64_log_set_level "$log_level" &&
    bl64_log_set_format "$log_format" &&
    BL64_LOG_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'log'
}

#######################################
# Set log repository
#
# * Create the repository directory
#
# Arguments:
#   $1: repository path
# Outputs:
#   STDOUT: None
#   STDERR: command stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_repository() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local log_repository="$1"

  bl64_check_parameter 'log_repository' || return $?
  [[ "$BL64_LOG_REPOSITORY" == "$log_repository" ]] && return 0

  bl64_fs_dir_create \
    "$BL64_LOG_REPOSITORY_MODE" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$log_repository" ||
    return $?

  BL64_LOG_REPOSITORY="$log_repository"
}

#######################################
# Set logging level
#
# Arguments:
#   $1: target level. One of BL64_LOG_CATEGORY_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_level() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local log_level="$1"

  case "$log_level" in
  "$BL64_LOG_CATEGORY_NONE") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_NONE" ;;
  "$BL64_LOG_CATEGORY_INFO") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_INFO" ;;
  "$BL64_LOG_CATEGORY_DEBUG") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_DEBUG" ;;
  "$BL64_LOG_CATEGORY_WARNING") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_WARNING" ;;
  "$BL64_LOG_CATEGORY_ERROR") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_ERROR" ;;
  *) bl64_check_alert_parameter_invalid 'log_level' ;;
  esac
}

#######################################
# Set log format
#
# Arguments:
#   $1: log format. One of BL64_LOG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_format() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local log_format="$1"

  case "$log_format" in
  "$BL64_LOG_FORMAT_CSV")
    BL64_LOG_FORMAT="$BL64_LOG_FORMAT_CSV"
    BL64_LOG_FS=':'
    ;;
  *) bl64_check_alert_parameter_invalid 'log_format' ;;
  esac
}

#######################################
# Set log target
#
# * Target is created or appended on the log repository
#
# Arguments:
#   $1: log target. Format: file name
#   $2: target type
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_target() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local log_target="$1"
  local log_type="$2"

  bl64_check_parameter 'log_target' &&
    bl64_check_parameter 'log_type' ||
    return $?

  case "$log_type" in
  "$BL64_LOG_TYPE_SINGLE")
    _bl64_log_set_target_single "$log_target"
    ;;
  "$BL64_LOG_TYPE_MULTIPLE")
    _bl64_log_set_target_multiple "$log_target"
    ;;
  *)
    bl64_check_alert_parameter_invalid 'log_type'
    return $?
    ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Write messages to logs
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_log_set_runtime() {
  bl64_msg_show_deprecated 'bl64_log_set_runtime' 'bl64_log_set_target'
  bl64_log_set_target "$1" "$BL64_LOG_TYPE_MULTIPLE"
}

#
# Private functions
#

#######################################
# Save a log record to the logs repository
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: log message category. Use any of $BL64_LOG_CATEGORY_*
#   $3: message
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#   BL64_LIB_ERROR_MODULE_SETUP_MISSING
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function _bl64_log_register() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local source="$1"
  local category="$2"
  local payload="$3"

  [[ "$BL64_LOG_MODULE" == "$BL64_VAR_OFF" ]] && return 0
  [[ -z "$source" || -z "$category" || -z "$payload" ]] && return "$BL64_LIB_ERROR_PARAMETER_MISSING"

  case "$BL64_LOG_FORMAT" in
  "$BL64_LOG_FORMAT_CSV")
    printf '%(%FT%TZ%z)T%s%s%s%s%s%s%s%s%s%s%s%s\n' \
      '-1' \
      "$BL64_LOG_FS" \
      "$BL64_SCRIPT_SID" \
      "$BL64_LOG_FS" \
      "$HOSTNAME" \
      "$BL64_LOG_FS" \
      "$BL64_SCRIPT_ID" \
      "$BL64_LOG_FS" \
      "${source}" \
      "$BL64_LOG_FS" \
      "$category" \
      "$BL64_LOG_FS" \
      "$payload" >>"$BL64_LOG_DESTINATION"
    ;;
  *) return "$BL64_LIB_ERROR_MODULE_SETUP_INVALID" ;;
  esac
}

#
# Public functions
#

#######################################
# Save a single log record of type 'info' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: message (when BL64_LOG_VERBOSE='1')
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_info() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_ERROR" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_WARNING" ]] &&
    return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_INFO" \
    "$payload"
}

#######################################
# Save a single log record of type 'error' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when BL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_error() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ]] && return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_ERROR" \
    "$payload"
}

#######################################
# Save a single log record of type 'warning' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when BL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_warning() {
  _bl64_dbg_lib_log_is_enabled && bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_ERROR" ]] &&
    return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_WARNING" \
    "$payload"
}

#######################################
# BashLib64 / Module / Setup / Display messages
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_msg_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_LOG_MODULE' &&
    bl64_msg_set_output "$BL64_VAR_DEFAULT" &&
    bl64_msg_app_enable_verbose &&
    BL64_MSG_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'msg'
}

#######################################
# Set verbosity level
#
# Arguments:
#   $1: target level. One of BL64_MSG_VERBOSE_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_msg_set_level() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local level="$1"

  bl64_check_parameter 'level' || return $?

  case "$level" in
    "$BL64_MSG_VERBOSE_NONE") bl64_msg_all_disable_verbose ;;
    "$BL64_MSG_VERBOSE_APP") bl64_msg_app_enable_verbose ;;
    "$BL64_MSG_VERBOSE_DETAIL") bl64_msg_app_enable_detail ;;
    "$BL64_MSG_VERBOSE_LIB") bl64_msg_app_detail_is_enabled ;;
    "$BL64_MSG_VERBOSE_ALL") bl64_msg_all_enable_verbose ;;
    *)
      bl64_check_alert_parameter_invalid 'BL64_MSG_VERBOSE' \
        "invalid value. Not one of: ${BL64_MSG_VERBOSE_NONE}|${BL64_MSG_VERBOSE_ALL}|${BL64_MSG_VERBOSE_APP}|${BL64_MSG_VERBOSE_DETAIL}|${BL64_MSG_VERBOSE_LIB}"
      return $?
      ;;
  esac
}

#######################################
# Set message format
#
# Arguments:
#   $1: format. One of BL64_MSG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_format() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local format="$1"
  local legacy_BL64_MSG_FORMAT_PLAIN='R'
  local legacy_BL64_MSG_FORMAT_HOST='H'
  local legacy_BL64_MSG_FORMAT_TIME='T'
  local legacy_BL64_MSG_FORMAT_CALLER='C'
  local legacy_BL64_MSG_FORMAT_FULL='F'

  bl64_check_parameter 'format' || return $?

  case "$format" in
    "$BL64_MSG_FORMAT_PLAIN" | "$legacy_BL64_MSG_FORMAT_PLAIN") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_PLAIN" ;;
    "$BL64_MSG_FORMAT_HOST" | "$legacy_BL64_MSG_FORMAT_HOST") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_HOST" ;;
    "$BL64_MSG_FORMAT_TIME" | "$legacy_BL64_MSG_FORMAT_TIME") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_TIME" ;;
    "$BL64_MSG_FORMAT_CALLER" | "$legacy_BL64_MSG_FORMAT_CALLER") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_CALLER" ;;
    "$BL64_MSG_FORMAT_FULL" | "$legacy_BL64_MSG_FORMAT_FULL") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_FULL" ;;
    "$BL64_MSG_FORMAT_TIME2" | "$BL64_MSG_FORMAT_FULL2" | "$BL64_MSG_FORMAT_SCRIPT" | "$BL64_MSG_FORMAT_SCRIPT2") BL64_MSG_FORMAT="$format" ;;
    *)
      bl64_check_alert_parameter_invalid 'BL64_MSG_FORMAT' 'invalid value. Not one of: BL64_MSG_FORMAT_*'
      return $?
      ;;
  esac
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_vars 'BL64_MSG_FORMAT'
  return 0
}

#######################################
# Set message display theme
#
# Arguments:
#   $1: theme name. One of BL64_MSG_THEME_ID_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_theme() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local theme="$1"

  bl64_check_parameter 'theme' || return $?

  case "$theme" in
    "$BL64_MSG_THEME_ID_ASCII_STD") BL64_MSG_THEME='BL64_MSG_THEME_ASCII_STD' ;;
    "$BL64_MSG_THEME_ID_ANSI_STD") BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD' ;;
    *)
      bl64_check_alert_parameter_invalid 'BL64_MSG_THEME' \
        "invalid value. Not one of: ${BL64_MSG_THEME_ID_ASCII_STD}|${BL64_MSG_THEME_ID_ANSI_STD}"
      return $?
      ;;
  esac
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_vars 'BL64_MSG_THEME'
  return 0
}

#######################################
# Set message output type
#
# * Will also setup the theme
# * If no theme is provided then the STD is used (ansi or ascii)
# * If no output is provided then the default is used.
# * Default output is ANSI if the script is interactive, otherwise ASCII
#
# Arguments:
#   $1: output type. One of BL64_MSG_OUTPUT_*. Default: BL64_MSG_OUTPUT_ANSI
#   $2: (optional) theme. Default: STD
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_output() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local output="${1:-}"
  local theme="${2:-${BL64_VAR_DEFAULT}}"
  local legacy_BL64_MSG_OUTPUT_ASCII='A'
  local legacy_BL64_MSG_OUTPUT_ANSI='N'

  if bl64_lib_var_is_default "$output"; then
    if bl64_lib_mode_cicd_is_enabled; then
      output="$BL64_MSG_OUTPUT_ASCII"
    else
      output="$BL64_MSG_OUTPUT_ANSI"
    fi
  else
    if bl64_lib_mode_cicd_is_enabled; then
      output="$BL64_MSG_OUTPUT_ASCII"
    fi
  fi

  case "$output" in
    "$BL64_MSG_OUTPUT_ASCII" | "$legacy_BL64_MSG_OUTPUT_ASCII")
      bl64_lib_var_is_default "$theme" && theme="$BL64_MSG_THEME_ID_ASCII_STD"
      BL64_MSG_LABEL="$output"
      BL64_MSG_OUTPUT="$output"
      ;;
    "$BL64_MSG_OUTPUT_ANSI" | "$legacy_BL64_MSG_OUTPUT_ANSI")
      bl64_lib_var_is_default "$theme" && theme="$BL64_MSG_THEME_ID_ANSI_STD"
      BL64_MSG_OUTPUT="$output"
      ;;
    "$BL64_MSG_OUTPUT_EMOJI")
      bl64_lib_var_is_default "$theme" && theme="$BL64_MSG_THEME_ID_ANSI_STD"
      BL64_MSG_LABEL="$output"
      BL64_MSG_OUTPUT="$output"
      ;;
    *)
      bl64_check_alert_parameter_invalid 'BL64_MSG_OUTPUT' \
        "invalid value. Not one of: ${BL64_MSG_OUTPUT_ASCII}|${BL64_MSG_OUTPUT_ANSI}|${BL64_MSG_OUTPUT_EMOJI}"
      return $?
      ;;
  esac
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_vars 'BL64_MSG_OUTPUT'
  bl64_msg_set_theme "$theme"
}

#
# Verbosity control
#

function bl64_msg_app_verbose_is_enabled {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_APP" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]
}

function bl64_msg_app_run_is_enabled {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  bl64_msg_app_detail_is_enabled && ! bl64_lib_mode_cicd_is_enabled
}

function bl64_msg_app_detail_is_enabled {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_LIB" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_DETAIL" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]
}

function bl64_msg_all_disable_verbose {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_NONE"
}

function bl64_msg_all_enable_verbose {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_ALL"
}

function bl64_msg_app_enable_verbose {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_APP"
}

function bl64_msg_app_enable_detail {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_DETAIL"
}

#
# Help attributes
#

function bl64_msg_help_usage_set() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local content="${1:-$BL64_VAR_DEFAULT}"
  BL64_MSG_HELP_USAGE="$content"
}

function bl64_msg_help_about_set() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local content="${1:-$BL64_VAR_DEFAULT}"
  BL64_MSG_HELP_ABOUT="$content"
}

function bl64_msg_help_description_set() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local content="${1:-$BL64_VAR_DEFAULT}"
  BL64_MSG_HELP_DESCRIPTION="$content"
}

function bl64_msg_help_parameters_set() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local content="${1:-$BL64_VAR_DEFAULT}"
  BL64_MSG_HELP_PARAMETERS="$content"
}

#######################################
# BashLib64 / Module / Functions / Display messages
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_msg_app_verbose_enabled {
  bl64_msg_show_deprecated 'bl64_msg_app_verbose_enabled' 'bl64_msg_app_verbose_is_enabled'
  bl64_msg_app_verbose_is_enabled
}
function bl64_msg_lib_verbose_enabled {
  bl64_msg_show_deprecated 'bl64_msg_lib_verbose_enabled' 'bl64_msg_app_detail_is_enabled'
  bl64_msg_app_detail_is_enabled
}
function bl64_msg_lib_enable_verbose {
  bl64_msg_show_deprecated 'bl64_msg_lib_enable_verbose' 'bl64_msg_app_enable_detail'
  bl64_msg_app_enable_detail
}
function bl64_msg_lib_verbose_is_enabled {
  bl64_msg_show_deprecated 'bl64_msg_lib_verbose_is_enabled' 'bl64_msg_app_detail_is_enabled'
  bl64_msg_app_detail_is_enabled
}
function bl64_msg_show_usage() {
  bl64_msg_show_deprecated 'bl64_msg_show_usage' 'bl64_msg_help_show'
  local usage="${1:-${BL64_VAR_NULL}}"
  local description="${2:-${BL64_VAR_DEFAULT}}"
  local commands="${3:-}"
  local flags="${4:-}"
  local parameters="${5:-}"

  bl64_msg_help_usage_set "$usage"
  bl64_msg_help_description_set "$description"
  bl64_msg_help_parameters_set \
    "${commands}
${flags}
${parameters}"
  bl64_msg_help_show
}

#
# Internal functions
#

function _bl64_msg_module_check_setup() {
  local module="${1:-}"
  local setup_status=''
  [[ -z "$module" ]] && return "$BL64_LIB_ERROR_PARAMETER_MISSING"
  _bl64_lib_module_is_imported "$module" || return $?

  setup_status="${!module}"
  if [[ "$setup_status" == "$BL64_VAR_OFF" ]]; then
    printf 'Error: required BashLib64 module is not setup. Call the bl64_<MODULE>_setup function before using the module (module-id: %s | function: %s)\n' \
      "${module}" \
      "${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NA}.${FUNCNAME[2]:-NONE}@${BASH_LINENO[2]:-NA}" \
      >&2
    return "$BL64_LIB_ERROR_MODULE_SETUP_MISSING"
  fi
  return 0
}

function _bl64_msg_alert_show_parameter() {
  local parameter="${1:-${BL64_VAR_DEFAULT}}"
  local message="${2:-${BL64_VAR_DEFAULT}}"
  local value="${3:-${BL64_VAR_DEFAULT}}"

  bl64_lib_var_is_default "$parameter" && parameter=''
  bl64_lib_var_is_default "$message" && message='Error: the requested operation was provided with an invalid parameter value'
  bl64_lib_var_is_default "$value" && value=''
  printf '%s (%s%scaller: %s)\n' \
    "$message" \
    "${parameter:+parameter: ${parameter} | }" \
    "${value:+value: ${value} | }" \
    "${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NA}.${FUNCNAME[2]:-NONE}@${BASH_LINENO[2]:-NA}" \
    >&2
  return "$BL64_LIB_ERROR_PARAMETER_INVALID"
}

#######################################
# Display message helper
#
# Arguments:
#   $1: style attribute
#   $2: type of message
#   $3: message to show
# Outputs:
#   STDOUT: message
#   STDERR: message when type is error or warning
# Returns:
#   printf exit status
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function _bl64_msg_print() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"

  _bl64_msg_module_check_setup 'BL64_MSG_MODULE' || return $?
  [[ -n "$attribute" && -n "$type" ]] || return "$BL64_LIB_ERROR_PARAMETER_MISSING"

  case "$BL64_MSG_OUTPUT" in
    "$BL64_MSG_OUTPUT_ASCII") _bl64_msg_format_ascii "$attribute" "$type" "$message" ;;
    "$BL64_MSG_OUTPUT_ANSI") _bl64_msg_format_ansi "$attribute" "$type" "$message" ;;
    "$BL64_MSG_OUTPUT_EMOJI") _bl64_msg_format_emoji "$attribute" "$type" "$message" ;;
    *) _bl64_msg_alert_show_parameter 'BL64_MSG_OUTPUT' "$BL64_VAR_DEFAULT" "$BL64_MSG_OUTPUT" ;;
  esac
}

function _bl64_msg_format_ansi() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local style=''
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'

  style="${BL64_MSG_THEME}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  # shellcheck disable=SC2059
  case "$BL64_MSG_FORMAT" in
    "$BL64_MSG_FORMAT_PLAIN")
      printf "%b: %s${linefeed}" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_HOST")
      printf "[%b] %b: %s${linefeed}" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME")
      printf "[%b] %b: %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME2")
      printf "%b %b: %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_CALLER")
      printf "[%b] %b: %s${linefeed}" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT")
      printf "[%b] %b | %b: %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT2")
      printf "%b|%b|%b| %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL")
      printf "[%b] %b:%b | %b: %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL2")
      printf "%b|%b|%b|%b| %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "$message"
      ;;
    *) _bl64_msg_alert_show_parameter 'BL64_MSG_FORMAT' "$BL64_VAR_DEFAULT" "$BL64_MSG_FORMAT" ;;
  esac
}

function _bl64_msg_format_ascii() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local label=''
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'

  label="BL64_MSG_LABEL_${BL64_MSG_LABEL}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  # shellcheck disable=SC2059
  case "$BL64_MSG_FORMAT" in
    "$BL64_MSG_FORMAT_PLAIN")
      printf "%s %s${linefeed}" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_HOST")
      printf "[%s] %s %s${linefeed}" \
        "${HOSTNAME}" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME")
      printf "[${BL64_MSG_TIME_DMY_HMS_FULL}] %s %s${linefeed}" \
        '-1' \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME2")
      printf "${BL64_MSG_TIME_DMY_HMS_COMPACT} %s %s${linefeed}" \
        '-1' \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_CALLER")
      printf "[%s] %s %s${linefeed}" \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT")
      printf "[${BL64_MSG_TIME_DMY_HMS_FULL}] %s %s %s${linefeed}" \
        '-1' \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT2")
      printf "${BL64_MSG_TIME_DMY_HMS_COMPACT}|%s %s %s${linefeed}" \
        '-1' \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL")
      printf "[${BL64_MSG_TIME_DMY_HMS_FULL}] %s:%s %s %s${linefeed}" \
        '-1' \
        "$HOSTNAME" \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL2")
      printf "${BL64_MSG_TIME_DMY_HMS_COMPACT}|%s|%s %s %s${linefeed}" \
        '-1' \
        "$HOSTNAME" \
        "$BL64_SCRIPT_ID" \
        "${!label}" \
        "$message"
      ;;
    *) _bl64_msg_alert_show_parameter 'BL64_MSG_FORMAT' "$BL64_VAR_DEFAULT" "$BL64_MSG_FORMAT" ;;
  esac
}

function _bl64_msg_format_emoji() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'
  local label=''

  label="BL64_MSG_LABEL_${BL64_MSG_LABEL}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  # shellcheck disable=SC2059
  case "$BL64_MSG_FORMAT" in
    "$BL64_MSG_FORMAT_PLAIN")
      printf "%b %s${linefeed}" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_HOST")
      printf "[%b] %b %s${linefeed}" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME")
      printf "[%b] %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_TIME2")
      printf "%b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_CALLER")
      printf "[%b] %b %s${linefeed}" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT")
      printf "[%b] %b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_SCRIPT2")
      printf "%b|%b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL")
      printf "[%b] %b:%b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_FULL" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    "$BL64_MSG_FORMAT_FULL2")
      printf "%b|%b|%b %b %s${linefeed}" \
        "\e[${!style_fmttime}m$(printf "$BL64_MSG_TIME_DMY_HMS_COMPACT" '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
        "${!label}" \
        "$message"
      ;;
    *) _bl64_msg_alert_show_parameter 'BL64_MSG_FORMAT' "$BL64_VAR_DEFAULT" "$BL64_MSG_FORMAT" ;;
  esac
}

#
# Public functions
#

#######################################
# Display check error message
#
# Arguments:
#   $1: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_check() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[2]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Error  ' "$message [task: ${FUNCNAME[2]:-main}@${BASH_LINENO[2]:-NA}.${FUNCNAME[3]:-main}@${BASH_LINENO[3]:-NA}]" >&2
}

#######################################
# Display error message
#
# Arguments:
#   $1: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_error() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Error  ' "$message" >&2
}

#######################################
# Display application function error message
#
# Arguments:
#   $1: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_app_error() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Error  ' "$message [task: ${FUNCNAME[2]:-main}.${FUNCNAME[3]:-main}]" >&2
}

#######################################
# Display bashlib64 function error message
#
# Arguments:
#   $1: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_lib_error() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Error  ' "$message [task: ${FUNCNAME[2]:-main}.${FUNCNAME[3]:-main}]" >&2
}

#######################################
# Display fatal error message
#
# * Use before halting the script with exit
# Arguments:
#   $1: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_fatal() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_ERROR" 'Fatal  ' "$message" >&2
}

#######################################
# Display warning message
#
# Arguments:
#   $1: warning message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_warning() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_warning "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_WARNING" 'Warning' "$message" >&2
}

#######################################
# Display attention message
#
# Arguments:
#   $1: warning message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_attention() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_print "$BL64_MSG_TYPE_WARNING" 'Attention' "$message"
}

#######################################
# Display script initialization message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_init() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_INIT" 'Init   ' "$message"
}

#######################################
# Display info message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_info() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_detail_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_INFO" 'Info   ' "$message"
}

#######################################
# Display phase message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_phase() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_PHASE}:${message}" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_PHASE" 'Phase  ' "${BL64_MSG_COSMETIC_PHASE_PREFIX2}  ${message}  ${BL64_MSG_COSMETIC_PHASE_SUFIX2}"
}

#######################################
# Display task message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_task() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_TASK}:${message}" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_TASK" 'Task   ' "$message"
}

#######################################
# Display subtask message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_subtask() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_SUBTASK}:${message}" &&
    bl64_msg_app_detail_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_SUBTASK" 'Subtask' "${BL64_MSG_COSMETIC_ARROW2} ${message}"
}

#######################################
# Display task message for bash64lib functions
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_lib_task() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBTASK}:${message}" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_LIBTASK" 'Task   ' "$message"
}

#######################################
# Display subtask message for bash64lib functions
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_lib_subtask() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBSUBTASK}:${message}" &&
    bl64_msg_app_detail_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_LIBSUBTASK" 'Subtask' "${BL64_MSG_COSMETIC_ARROW2} ${message}"
}

#######################################
# Display info message for bash64lib functions
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_lib_info() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBINFO}:${message}" &&
    bl64_msg_app_detail_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_LIBINFO" 'Info   ' "$message"
}

#######################################
# Display message. Plain output, no extra info.
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_text() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_is_enabled || return 0

  printf '%s\n' "$message"
}

#######################################
# Display batch process start message
#
# * Use in the main section of task oriented scripts to show start/end of batch process
#
# Arguments:
#   $2: batch short description
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_batch_start() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="${1:-$BL64_SCRIPT_ID}"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_BATCH}:${message}" &&
    bl64_msg_app_verbose_is_enabled || return 0

  _bl64_msg_print "$BL64_MSG_TYPE_BATCH" 'Process' "[${message}] started"
}

#######################################
# Display batch process complete message
#
# * Use in the main section of task oriented scripts to show start/end of batch process
# * Can be used as last command in shell script to both show result and return exit status
#
# Arguments:
#   $1: process exit status.
#   $2: batch short description. Default: BL64_SCRIPT_ID
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_batch_finish() {
  local -i status=$1
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="${2:-$BL64_SCRIPT_ID}"

  # shellcheck disable=SC2086
  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_BATCH}:${status}:${message}" &&
    bl64_msg_app_verbose_is_enabled ||
    return "$status"

  if ((status == 0)); then
    _bl64_msg_print "$BL64_MSG_TYPE_BATCHOK" 'Process' "[${message}] finished successfully"
  else
    _bl64_msg_print "$BL64_MSG_TYPE_BATCHERR" 'Process' "[${message}] finished with errors: exit-status-${status}"
  fi
  # shellcheck disable=SC2086
  return "$status"
}

#######################################
# Display user input message
#
# * Used exclusively by the io module to show messages for user input from stdin
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_input() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="$1"

  _bl64_msg_print "$BL64_MSG_TYPE_INPUT" 'Input  ' "$message"
}

#######################################
# Show separator line
#
# Arguments:
#   $1: Prefix string. Default: none
#   $2: character used to build the line. Default: =
#   $3: separator length (without prefix). Default: 60
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_separator() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="${1:-$BL64_VAR_DEFAULT}"
  local separator="${2:-$BL64_VAR_DEFAULT}"
  local length="${3:-$BL64_VAR_DEFAULT}"
  local -i counter=0
  local output=''

  bl64_lib_var_is_default "$message" && message=''
  bl64_lib_var_is_default "$separator" && separator='='
  bl64_lib_var_is_default "$length" && length=60

  output="$(
    while true; do
      counter=$((counter + 1))
      printf '%c' "$separator"
      ((counter == length)) && break
    done
  )"

  _bl64_msg_print "$BL64_MSG_TYPE_SEPARATOR" '>>>>>>>' "${separator}${separator}[ ${message} ]${output}"
}

#######################################
# Display deprecation message
#
# Arguments:
#   $1: function_name
#   $2: function_replacement
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_deprecated() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local function_name="${1:-}"
  local function_replacement="${2:-non-available}"

  bl64_log_warning "${FUNCNAME[1]:-MAIN}" "legacy: ${function_name}" &&
    _bl64_msg_print "$BL64_MSG_TYPE_WARNING" 'Legacy ' "Function to be removed from future versions. Please upgrade. (${function_name} :replace-with: ${function_replacement})" >&2
}

#######################################
# Display setup information
#
# * Skip empty variables
#
# Arguments:
#   $1: (optional) message
#   $@: variable names
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_setup() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function "$@"
  local message="${1:-$BL64_VAR_DEFAULT}"
  local variable=''

  bl64_msg_app_detail_is_enabled || return 0
  bl64_lib_var_is_default "$message" && message='Executing task with the following parameters'
  shift

  bl64_msg_show_info "$message"
  for variable in "$@"; do
    [[ -z "${!variable:-}" || ! -v "$variable" ]] && continue
    bl64_msg_show_info "${BL64_MSG_COSMETIC_TAB2}${variable}=${!variable}"
  done
}

#######################################
# Show help message
#
# Arguments:
#   NONE
# Outputs:
#   STDOUT: help message
#   STDERR: NONE
# Returns:
#   0: Always OK
#######################################
function bl64_msg_help_show() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  local current_format="$BL64_MSG_FORMAT"

  bl64_msg_set_format "$BL64_MSG_FORMAT_PLAIN"

  _bl64_msg_show_script
  if [[ "$BL64_MSG_HELP_USAGE" != "$BL64_VAR_DEFAULT" ]]; then
    _bl64_msg_print "$BL64_MSG_TYPE_HELP" 'Usage  ' "${BL64_SCRIPT_ID} ${BL64_MSG_HELP_USAGE}"
  fi

  _bl64_msg_show_about

  if [[ "$BL64_MSG_HELP_DESCRIPTION" != "$BL64_VAR_DEFAULT" ]]; then
    printf '\n%s\n' "$BL64_MSG_HELP_DESCRIPTION"
  fi

  if [[ "$BL64_MSG_HELP_PARAMETERS" != "$BL64_VAR_DEFAULT" ]]; then
    printf '\n%s\n' "$BL64_MSG_HELP_PARAMETERS"
  fi
  bl64_msg_set_format "$current_format"
  return 0
}

#######################################
# Display about the script message
#
# * bl64_msg_help_about_set must be run before
#
# Arguments:
#   None
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: Always ok
#######################################
function bl64_msg_show_about() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  bl64_msg_app_verbose_is_enabled || return 0
  _bl64_msg_show_script &&
    _bl64_msg_show_about
}

function _bl64_msg_show_script() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  _bl64_msg_print "$BL64_MSG_TYPE_HELP" 'Script ' "${BL64_SCRIPT_ID} v${BL64_SCRIPT_VERSION}"
}

function _bl64_msg_show_about() {
  _bl64_dbg_lib_msg_is_enabled && bl64_dbg_lib_show_function
  if [[ "$BL64_MSG_HELP_ABOUT" != "$BL64_VAR_DEFAULT" ]]; then
    _bl64_msg_print "$BL64_MSG_TYPE_HELP" 'About  ' "$BL64_MSG_HELP_ABOUT"
  fi
}

#######################################
# BashLib64 / Module / Setup / OS / Identify OS attributes and provide command aliases
#######################################

#
# Internal functions
#

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_os_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_FLAVOR" in
    "$BL64_OS_FLAVOR_DEBIAN")
      BL64_OS_CMD_BASH='/bin/bash'
      BL64_OS_CMD_CAT='/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/bin/false'
      BL64_OS_CMD_HOSTNAME='/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/bin/true'
      BL64_OS_CMD_UNAME='/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_FEDORA" | "$BL64_OS_FLAVOR_REDHAT")
      BL64_OS_CMD_BASH='/bin/bash'
      BL64_OS_CMD_CAT='/usr/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/usr/bin/false'
      BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/usr/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/usr/bin/true'
      BL64_OS_CMD_UNAME='/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_SUSE")
      BL64_OS_CMD_BASH='/usr/bin/bash'
      BL64_OS_CMD_CAT='/usr/bin/cat'
      BL64_OS_CMD_DATE='/usr/bin/date'
      BL64_OS_CMD_FALSE='/usr/bin/false'
      BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/usr/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/usr/bin/true'
      BL64_OS_CMD_UNAME='/usr/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_ALPINE")
      BL64_OS_CMD_BASH='/bin/bash'
      BL64_OS_CMD_CAT='/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/bin/false'
      BL64_OS_CMD_HOSTNAME='/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/bin/true'
      BL64_OS_CMD_UNAME='/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_ARCH")
      BL64_OS_CMD_BASH='/bin/bash'
      BL64_OS_CMD_CAT='/usr/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/usr/bin/false'
      BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/usr/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/usr/bin/true'
      BL64_OS_CMD_UNAME='/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_MACOS")
      # Homebrew used when no native option available
      BL64_OS_CMD_BASH='/opt/homebre/bin/bash'
      BL64_OS_CMD_CAT='/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/usr/bin/false'
      BL64_OS_CMD_HOSTNAME='/bin/hostname'
      BL64_OS_CMD_GETENT="$BL64_VAR_INCOMPATIBLE"
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/usr/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/usr/bin/true'
      BL64_OS_CMD_UNAME='/usr/bin/uname'
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_os_set_options() {
  bl64_dbg_lib_show_function

  BL64_OS_SET_LOCALE_ALL='--all-locales'
}

#######################################
# Set runtime defaults
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_os_set_runtime() {
  bl64_dbg_lib_show_function

  # Reset language to modern specification of C locale
  if bl64_lib_lang_is_enabled; then
    case "$BL64_OS_FLAVOR" in
      "${BL64_OS_FLAVOR_DEBIAN}" | "${BL64_OS_FLAVOR_FEDORA}" | "${BL64_OS_FLAVOR_REDHAT}" | "${BL64_OS_FLAVOR_SUSE}" | "${BL64_OS_FLAVOR_ARCH}")
        bl64_os_set_lang 'C.UTF-8'
        ;;
      "${BL64_OS_FLAVOR_MACOS}" | "${BL64_OS_FLAVOR_ALPINE}")
        bl64_dbg_lib_show_comments 'UTF locale not installed by default, skipping'
        ;;
      *) bl64_check_alert_unsupported ;;
    esac
  fi
}

#######################################
# Obtain OS type
#
# * Used before setting paths, must use plain uname
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: OS Type
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_os_set_type() {
  bl64_dbg_lib_show_function
  BL64_OS_TYPE="$(uname -o)"
  case "$BL64_OS_TYPE" in
    'Darwin') BL64_OS_TYPE="$BL64_OS_TYPE_MACOS" ;;
    'GNU/Linux' | 'Linux') BL64_OS_TYPE="$BL64_OS_TYPE_LINUX" ;;
    *)
      bl64_msg_show_warning \
        "BashLib64 was unable to identify the current OS type (${BL64_OS_TYPE})"
      BL64_OS_TYPE="$BL64_OS_TYPE_UNK"
      ;;
  esac
}

#######################################
# Obtain Machine type
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: OS Type
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_os_set_machine() {
  bl64_dbg_lib_show_function
  local machine=''
  machine="$("$BL64_OS_CMD_UNAME" -m)"
  if [[ -z "$machine" ]]; then
    bl64_msg_show_lib_error 'failed to get machine type from uname'
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi
  case "$machine" in
    'x86_64' | 'amd64') BL64_OS_MACHINE="$BL64_OS_MACHINE_AMD64" ;;
    'aarch64' | 'arm64') BL64_OS_MACHINE="$BL64_OS_MACHINE_ARM64" ;;
    *)
      bl64_msg_show_warning \
        "BashLib64 was unable to identify the current machine type (${machine})"
      # shellcheck disable=SC2034
      BL64_OS_MACHINE="$BL64_OS_MACHINE_UNK"
      ;;
  esac
}

#######################################
# Get normalized OS distro and version from uname
#
# * Warning: bootstrap function
# * Use only for OS that do not have /etc/os-release
# * Normalized data is stored in the global variable BL64_OS_DISTRO
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   >0: error or os not recognized
#######################################
function _bl64_os_get_distro_from_uname() {
  bl64_dbg_lib_show_function
  local os_version=''
  local cmd_sw_vers='/usr/bin/sw_vers'

  case "$BL64_OS_TYPE" in
    "$BL64_OS_TYPE_MACOS")
      os_version="$("$cmd_sw_vers" -productVersion)" &&
        BL64_OS_DISTRO="$(_bl64_os_release_normalize "$BL64_VAR_NONE" "$os_version")" ||
        return $?

      BL64_OS_DISTRO="DARWIN-${BL64_OS_DISTRO}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_MACOS"
      bl64_dbg_lib_show_vars 'BL64_OS_DISTRO'
      ;;
    *)
      BL64_OS_DISTRO="$BL64_OS_UNK"
      bl64_msg_show_lib_error \
        "BashLib64 not supported on the current OS. Please check the OS compatibility matrix (OS: ${BL64_OS_TYPE})"
      return "$BL64_LIB_ERROR_OS_INCOMPATIBLE"
      ;;
  esac
  return 0
}

#######################################
# Get normalized OS distro and version from os-release
#
# * Warning: bootstrap function
# * Normalized data is stored in the global variable BL64_OS_DISTRO
# * Version is normalized to the format: OS_ID-V.S
#   * OS_ID: one of the OS standard tags
#   * V: Major version, number
#   * S: Minor version, number
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   >0: error or os not recognized
#######################################
function _bl64_os_get_distro_from_os_release() {
  bl64_dbg_lib_show_function
  local version_normalized=''
  local os_id=''
  local version_id=''

  _bl64_os_release_load &&
    os_id="${ID:-$BL64_VAR_NONE}" &&
    version_id="${VERSION_ID:-$BL64_VAR_NONE}" &&
    version_normalized="$(_bl64_os_release_normalize "$os_id" "$version_id")" ||
    return $?

  bl64_dbg_lib_show_info 'set BL_OS_DISTRO'
  case "${os_id^^}" in
    'ARCH' | 'CACHYOS' | 'MANJARO')
      bl64_dbg_lib_show_comments "treat all arch based distros as arch (ID=${os_id})"
      BL64_OS_DISTRO="${BL64_OS_ARC}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_ARCH"
      ;;
    'ALMALINUX')
      BL64_OS_DISTRO="${BL64_OS_ALM}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'ALPINE')
      BL64_OS_DISTRO="${BL64_OS_ALP}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_ALPINE"
      ;;
    'AMZN')
      BL64_OS_DISTRO="${BL64_OS_AMZ}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_FEDORA"
      ;;
    'CENTOS')
      BL64_OS_DISTRO="${BL64_OS_CNT}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'DEBIAN')
      BL64_OS_DISTRO="${BL64_OS_DEB}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
      ;;
    'FEDORA')
      BL64_OS_DISTRO="${BL64_OS_FD}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_FEDORA"
      ;;
    'DARWIN')
      BL64_OS_DISTRO="${BL64_OS_MCOS}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_MACOS"
      ;;
    'KALI')
      BL64_OS_DISTRO="${BL64_OS_KL}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
      ;;
    'OL')
      BL64_OS_DISTRO="${BL64_OS_OL}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'ROCKY')
      BL64_OS_DISTRO="${BL64_OS_RCK}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'RHEL')
      BL64_OS_DISTRO="${BL64_OS_RHEL}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'SLES')
      BL64_OS_DISTRO="${BL64_OS_SLES}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_SUSE"
      ;;
    'UBUNTU')
      BL64_OS_DISTRO="${BL64_OS_UB}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
      ;;
    *)
      bl64_msg_show_lib_error \
        "current OS is not supported. Please check the OS compatibility matrix (ID=${ID:-NONE} | VERSION_ID=${VERSION_ID:-NONE})"
      return "$BL64_LIB_ERROR_OS_INCOMPATIBLE"
      ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_OS_DISTRO' 'BL64_OS_FLAVOR'
  return 0
}

function _bl64_os_release_load() {
  bl64_dbg_lib_show_function
  bl64_dbg_lib_show_info 'parse /etc/os-release'
  # shellcheck disable=SC1091
  if ! source '/etc/os-release'; then
    bl64_msg_show_lib_error 'failed to load OS information from /etc/os-release file'
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi
  bl64_dbg_lib_show_vars 'ID' 'VERSION_ID'
}

function _bl64_os_release_normalize() {
  bl64_dbg_lib_show_function "$@"
  local os_id="${1:-}"
  local version_raw="${2:-}"
  local version_normalized=''
  local version_pattern_single='^[0-9]+$'
  local version_pattern_major_minor='^[0-9]+\.[0-9]+$'
  local version_pattern_semver='^[0-9]+\.[0-9]+\.[0-9]+$'

  bl64_check_parameter 'os_id' &&
    bl64_check_parameter 'version_raw' ||
    return $?

  bl64_dbg_lib_show_comments 'normalize OS version to match X.Y'
  if [[ "$version_raw" =~ $version_pattern_single ]]; then
    bl64_dbg_lib_show_info "version_pattern_single:  ${version_pattern_single}"
    version_normalized="${version_raw}.0"
  elif [[ "$version_raw" =~ $version_pattern_major_minor ]]; then
    bl64_dbg_lib_show_info "version_pattern_major_minor: ${version_pattern_major_minor}"
    version_normalized="${version_raw}"
  elif [[ "$version_raw" =~ $version_pattern_semver ]]; then
    bl64_dbg_lib_show_info "version_pattern_semver: ${version_pattern_semver}"
    if [[ "${os_id^^}" =~ ^(ARCH|CACHYOS|MANJARO)$ ]]; then
      bl64_dbg_lib_show_comments 'convert version format from YYYYMMDD to YYYY.MM'
      version_normalized="${version_raw:0:4}.${version_raw:4:2}"
    else
      version_normalized="${version_raw%.*}"
    fi
  elif [[ "$version_raw" == "$BL64_VAR_NONE" ]]; then
    bl64_dbg_lib_show_info "no version definition. Assume rolling OS"
    if [[ "${os_id^^}" =~ ^(ARCH|CACHYOS|MANJARO)$ ]]; then
      bl64_dbg_lib_show_info 'define version as the year-month when the OS was added to bl64'
      version_normalized='2025.10'
    fi
  else
    bl64_dbg_lib_show_info "pattern: raw"
    version_normalized="$version_raw"
  fi

  if [[ "$version_normalized" =~ $version_pattern_major_minor ]]; then
    echo "$version_normalized"
    return 0
  fi
  bl64_msg_show_lib_error "unable to normalize OS version (${version_raw} != Major.Minor != ${version_normalized})"
  return "$BL64_LIB_ERROR_TASK_FAILED"
}

#
# Public functions
#

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_os_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  [[ "${BASH_VERSINFO[0]}" != '4' && "${BASH_VERSINFO[0]}" != '5' ]] &&
    bl64_msg_show_lib_error "BashLib64 is not supported in the current Bash version (${BASH_VERSINFO[0]})" &&
    return "$BL64_LIB_ERROR_OS_BASH_VERSION"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_os_set_type &&
    _bl64_os_set_distro &&
    _bl64_os_set_runtime &&
    _bl64_os_set_command &&
    _bl64_os_set_options &&
    _bl64_os_set_machine &&
    BL64_OS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'os'
}

#######################################
# Identify and normalize Linux OS distribution name and version
#
# * Warning: bootstrap function
# * OS name format: OOO-V.V
#   * OOO: OS short name (tag)
#   * V.V: Version (Major, Minor)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_os_set_distro() {
  bl64_dbg_lib_show_function
  if [[ -r '/etc/os-release' ]]; then
    _bl64_os_get_distro_from_os_release
  else
    _bl64_os_get_distro_from_uname
  fi
}

#######################################
# Set locale related shell variables
#
# * Locale variables are set as is, no extra validation on the locale availability
#
# Arguments:
#   $1: locale name
# Outputs:
#   STDOUT: None
#   STDERR: Validation errors
# Returns:
#   0: set ok
#   >0: set error
#######################################
function bl64_os_set_lang() {
  bl64_dbg_lib_show_function "$@"
  local locale="$1"

  bl64_check_parameter 'locale' || return $?

  LANG="$locale"
  LC_ALL="$locale"
  LANGUAGE="$locale"
  bl64_dbg_lib_show_vars 'LANG' 'LC_ALL' 'LANGUAGE'

  return 0
}

#######################################
# BashLib64 / Module / Functions / OS / Identify OS attributes and provide command aliases
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_os_match() {
  bl64_msg_show_deprecated 'bl64_os_match' 'bl64_os_is_distro'
  bl64_os_is_distro "$@"
}
function bl64_os_match_compatible() {
  bl64_msg_show_deprecated 'bl64_os_match_compatible' 'bl64_os_is_compatible'
  bl64_os_is_compatible "$@"
}

#
# Public functions
#

#######################################
# Compare the current OS against the provided flavor
#
# Arguments:
#   $1: flavor ID: BL64_OS_FLAVOR_*
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: flavor match
#   BL64_LIB_ERROR_OS_NOT_MATCH
#   BL64_LIB_ERROR_OS_TAG_INVALID
#######################################
function bl64_os_is_flavor() {
  bl64_dbg_lib_show_function "$@"
  local os_flavor="$1"

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_parameter 'os_flavor' ||
    return $?

  [[ "$BL64_OS_FLAVOR" == "$os_flavor" ]] && return 0
  return "$BL64_LIB_ERROR_OS_NOT_MATCH"
}

#######################################
# Compare the current OS version against a list of OS versions
#
# * There is a match if both distro and version are equal to any target on the list
#
# Arguments:
#   $@: each argument is an OS target. The list is any combintation of the formats: "$BL64_OS_<ALIAS>" "${BL64_OS_<ALIAS>}-V" "${BL64_OS_<ALIAS>}-V.S"
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   BL64_LIB_ERROR_OS_NOT_MATCH
#   BL64_LIB_ERROR_OS_TAG_INVALID
#######################################
function bl64_os_is_distro() {
  bl64_dbg_lib_show_function "$@"
  local item=''
  local -i status=$BL64_LIB_ERROR_OS_NOT_MATCH

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_parameters_none $# ||
    return $?
  bl64_dbg_lib_show_info "Look for [BL64_OS_DISTRO=${BL64_OS_DISTRO}] in [OSList=${*}}]"
  # shellcheck disable=SC2086
  for item in "$@"; do
    _bl64_os_is_distro "$BL64_VAR_OFF" "$item"
    status=$?
    ((status == 0)) && break
  done
  return "$status"
}

#######################################
# Compare the current OS version against a list of compatible OS versions
#
# * Compatibility is only verified if BL64_LIB_COMPATIBILITY == ON
# * The OS is considered compatible if there is a Distro match, regardles of the version
#
# Arguments:
#   $@: each argument is an OS target. The list is any combintation of the formats: "$BL64_OS_<ALIAS>" "${BL64_OS_<ALIAS>}-V" "${BL64_OS_<ALIAS>}-V.S"
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   BL64_LIB_ERROR_OS_NOT_MATCH
#   BL64_LIB_ERROR_OS_TAG_INVALID
#######################################
function bl64_os_is_compatible() {
  bl64_dbg_lib_show_function "$@"
  local item=''
  local -i status=$BL64_LIB_ERROR_OS_NOT_MATCH

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_parameters_none $# ||
    return $?
  bl64_dbg_lib_show_info "Look for exact match [BL64_OS_DISTRO=${BL64_OS_DISTRO}] in [OSList=${*}}]"
  # shellcheck disable=SC2086
  for item in "$@"; do
    _bl64_os_is_distro "$BL64_VAR_OFF" "$item"
    status=$?
    ((status == 0)) && break
  done
  if ((status != 0)); then
    bl64_dbg_lib_show_info "No exact match, look for compatibility"
    for item in "$@"; do
      _bl64_os_is_distro "$BL64_VAR_ON" "$item"
      status=$?
      if ((status == 0)); then
        break
      elif ((status == 1)); then
        bl64_dbg_lib_show_info \
          "current OS version is not supported. Execution will continue since compatibility-mode was requested. (current-os: ${BL64_OS_DISTRO} ${BL64_MSG_COSMETIC_PIPE} supported-os: ${*}) ${BL64_MSG_COSMETIC_PIPE})"
        status=0
        break
      fi
    done
  fi
  return "$status"
}

#######################################
# Determine if locale resources for language are installed in the OS
#
# Arguments:
#   $1: locale name
# Outputs:
#   STDOUT: None
#   STDERR: Validation errors
# Returns:
#   0: resources are installed
#   >0: no resources
#######################################
function bl64_os_lang_is_available() {
  bl64_dbg_lib_show_function "$@"
  local locale="$1"
  local line=''

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_parameter 'locale' &&
    bl64_check_command "$BL64_OS_CMD_LOCALE" ||
    return $?

  bl64_dbg_lib_show_info 'look for the requested locale using the locale command'
  IFS=$'\n'
  for line in $("$BL64_OS_CMD_LOCALE" "$BL64_OS_SET_LOCALE_ALL"); do
    unset IFS
    bl64_dbg_lib_show_info "checking [${line}] == [${locale}]"
    [[ "$line" == "$locale" ]] && return 0
  done

  return "$BL64_LIB_ERROR_IS_NOT"
}

#######################################
# Check the current OS version is in the supported list
#
# * Target use case is script compatibility. Use in the init part to halt execution if OS is not supported
# * Not recommended for checking individual functions. Instead, use if or case structures to support multiple values based on the OS version
# * The check is done against the provided list, exact match
# * Check is strict, ignores BL64_LIB_COMPATIBILITY global flag. If you need to check for compatibility, use bl64_os_check_compatibility() instead
# * This is a wrapper to the bl64_os_is_distro so it can be used as a check function
#
# Arguments:
#   $@: list of OS versions to check against. Format: same as bl64_os_is_distro
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#######################################
function bl64_os_check_version() {
  bl64_dbg_lib_show_function "$@"

  bl64_os_is_distro "$@" && return 0

  bl64_msg_show_check \
    "task not supported by the current OS version (current-os: ${BL64_OS_DISTRO} ${BL64_MSG_COSMETIC_PIPE} supported-os: ${*}))"
  return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
}

#######################################
# Check the current OS version is compatible against the supported list
#
# * Same as bl64_os_check_version() but obeys the global BL64_LIB_COMPATIBILITY flag
#
# Arguments:
#   $@: list of OS versions to check against. Format: same as bl64_os_is_distro
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#######################################
function bl64_os_check_compatibility() {
  bl64_dbg_lib_show_function "$@"

  bl64_os_is_compatible "$@" && return 0

  bl64_msg_show_check \
    "task not supported by the current OS version (current-os: ${BL64_OS_DISTRO} ${BL64_MSG_COSMETIC_PIPE} supported-os: ${*}))"
  return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_os_run_sleep() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_OS_MODULE' ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_OS_CMD_SLEEP" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_os_run_getent() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_command "$BL64_OS_CMD_GETENT" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_OS_CMD_GETENT" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_os_run_date() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_command "$BL64_OS_CMD_DATE" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_OS_CMD_DATE" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_os_run_cat() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_command "$BL64_OS_CMD_CAT" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_OS_CMD_CAT" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Check the current OS version is not in the unsupported list
#
# * Same as bl64_os_check_version, but for the opposite purpose
#
# Arguments:
#   $@: list of OS versions to check against. Format: same as bl64_os_is_distro
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#######################################
function bl64_os_check_not_version() {
  bl64_dbg_lib_show_function "$@"

  bl64_os_is_distro "$@" || return 0

  bl64_msg_show_check \
    "task not supported by the current OS version (${BL64_OS_DISTRO})"
  return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_os_run_uname() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_command "$BL64_OS_CMD_CAT" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_OS_CMD_UNAME" \
    "$@"
  bl64_dbg_lib_trace_stop
}

function _bl64_os_is_distro() {
  bl64_dbg_lib_show_function "$@"
  local check_compatibility="$1"
  local target="$2"
  local target_os=''
  local target_major=''
  local target_minor=''
  local current_major=''
  local current_minor=''

  if [[ "$target" == +([[:alpha:]])-+([[:digit:]]).+([[:digit:]]) ]]; then
    bl64_dbg_lib_show_info 'Analyze Pattern: match OS, Major and Minor'
    target_os="${target%%-*}"
    target_major="${target##*-}"
    target_minor="${target_major##*\.}"
    target_major="${target_major%%\.*}"
    current_major="${BL64_OS_DISTRO##*-}"
    current_minor="${current_major##*\.}"
    current_major="${current_major%%\.*}"
    bl64_dbg_lib_show_vars 'target_os' 'target_major' 'target_minor' 'current_major' 'current_minor'

    bl64_dbg_lib_show_info "[${BL64_OS_DISTRO}] == [${target_os}-${target_major}.${target_minor}]"
    if [[ "$BL64_OS_DISTRO" == ${target_os}-+([[:digit:]]).+([[:digit:]]) ]] &&
      ((current_major == target_major && current_minor == target_minor)); then
      :
    else
      if bl64_lib_flag_is_enabled "$check_compatibility" &&
        bl64_lib_mode_compability_is_enabled &&
        [[ "$BL64_OS_DISTRO" == ${target_os}-+([[:digit:]]).+([[:digit:]]) ]]; then
        return 1
      else
        return "$BL64_LIB_ERROR_OS_NOT_MATCH"
      fi
    fi

  elif [[ "$target" == +([[:alpha:]])-+([[:digit:]]) ]]; then
    bl64_dbg_lib_show_info 'Pattern: match OS and Major'
    target_os="${target%%-*}"
    target_major="${target##*-}"
    target_major="${target_major%%\.*}"
    current_major="${BL64_OS_DISTRO##*-}"
    current_major="${current_major%%\.*}"
    bl64_dbg_lib_show_vars 'target_os' 'target_major' 'current_major'

    bl64_dbg_lib_show_info "[${BL64_OS_DISTRO}] == [${target_os}-${target_major}]"
    if [[ "$BL64_OS_DISTRO" == ${target_os}-+([[:digit:]]).+([[:digit:]]) ]] &&
      ((current_major == target_major)); then
      :
    else
      if bl64_lib_flag_is_enabled "$check_compatibility" &&
        bl64_lib_mode_compability_is_enabled &&
        [[ "$BL64_OS_DISTRO" == ${target_os}-+([[:digit:]]).+([[:digit:]]) ]]; then
        return 1
      else
        return "$BL64_LIB_ERROR_OS_NOT_MATCH"
      fi
    fi

  elif [[ "$target" == +([[:alpha:]]) ]]; then
    bl64_dbg_lib_show_info 'Pattern: match OS ID'
    target_os="$target"

    bl64_dbg_lib_show_info "[${BL64_OS_DISTRO}] == [${target_os}]"
    [[ "$BL64_OS_DISTRO" == ${target_os}-+([[:digit:]]).+([[:digit:]]) ]] ||
      return "$BL64_LIB_ERROR_OS_NOT_MATCH"

  else
    bl64_msg_show_lib_error "invalid OS pattern (${target})"
    return "$BL64_LIB_ERROR_OS_TAG_INVALID"
  fi

  return 0
}

#######################################
# Check the current OS version is compatible against the supported flavor list
#
# Arguments:
#   $@: list of OS flavors to check against. Format: BL64_OS_FLAVOR_*
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#######################################
function bl64_os_check_flavor() {
  bl64_dbg_lib_show_function "$@"
  local flavor=''

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_parameters_none $# ||
    return $?

  for flavor in "$@"; do
    bl64_dbg_lib_show_info "checking flavor [${BL64_OS_FLAVOR}] == [${flavor}]"
    [[ "$BL64_OS_FLAVOR" == "$flavor" ]] && return 0
  done

  bl64_msg_show_check \
    "task not supported by the current OS flavor (current-flavor: ${BL64_OS_FLAVOR} ${BL64_MSG_COSMETIC_PIPE} supported-flavor: ${*}))"
  return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
}

#######################################
# Raise OS and CPU not supported error
#
# * Commonly used in the default branch of case statements or else if
#
# Arguments:
#   None
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
# shellcheck disable=SC2119,SC2120
function bl64_os_raise_platform_unsupported() {
  bl64_dbg_lib_show_function
  bl64_msg_show_error "current OS and CPU architecture are not supported by the script (OS_TYPE:${BL64_OS_TYPE} / MACHINE: ${BL64_OS_MACHINE})"
  return "$BL64_LIB_ERROR_OS_INCOMPATIBLE"
}

#######################################
# BashLib64 / Module / Setup / Interact with Ansible CLI
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: required in order to use the module
# * Check for core commands, fail if not available
#
# Arguments:
#   $1: (optional) Full path where commands are
#   $2: (optional) Full path to the ansible configuration file
#   $3: (optional) Ignore inherited shell environment? Default: BL64_VAR_ON
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_ans_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local ansible_bin="${1:-${BL64_VAR_DEFAULT}}"
  local ansible_config="${2:-${BL64_VAR_DEFAULT}}"
  local env_ignore="${3:-${BL64_VAR_ON}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_XSV_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_PY_MODULE' &&
    _bl64_ans_set_command "$ansible_bin" &&
    _bl64_ans_set_runtime "$ansible_config" &&
    _bl64_ans_set_options &&
    _bl64_ans_set_version &&
    BL64_ANS_ENV_IGNORE="$env_ignore" &&
    BL64_ANS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'ans'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_ans_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_ANS_CMD_ANSIBLE="$(bl64_bsh_command_import 'ansible' '/opt/ansible/bin' "${HOME}/.local/bin" "$@")" &&
    BL64_ANS_CMD_ANSIBLE_GALAXY="$(bl64_bsh_command_import 'ansible-galaxy' '/opt/ansible/bin' "${HOME}/.local/bin" "$@")" &&
    BL64_ANS_CMD_ANSIBLE_PLAYBOOK="$(bl64_bsh_command_import 'ansible-playbook' '/opt/ansible/bin' "${HOME}/.local/bin" "$@")"
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
function _bl64_ans_set_options() {
  bl64_dbg_lib_show_function
  BL64_ANS_SET_VERBOSE='-v'
  BL64_ANS_SET_DIFF='--diff'
  BL64_ANS_SET_DEBUG='-vvvvv'
}

#######################################
# Set runtime defaults
#
# Arguments:
#   $1: path to ansible_config
# Outputs:
#   STDOUT: None
#   STDERR: setting errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function _bl64_ans_set_runtime() {
  bl64_dbg_lib_show_function "$@"
  local config="$1"
  bl64_ans_set_paths "$config"
}

#######################################
# Set and prepare module paths
#
# * Global paths only
# * If preparation fails the whole module fails
#
# Arguments:
#   $1: path to ansible_config
#   $2: path to ansible collections
#   $3: path to ansible workdir
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
function bl64_ans_set_paths() {
  bl64_dbg_lib_show_function "$@"
  local config="${1:-${BL64_VAR_DEFAULT}}"
  local collections="${2:-${BL64_VAR_DEFAULT}}"
  local ansible="${3:-${BL64_VAR_DEFAULT}}"

  if bl64_lib_var_is_default "$config"; then
    BL64_ANS_PATH_USR_CONFIG=''
  else
    bl64_check_file "$config" || return $?
    BL64_ANS_PATH_USR_CONFIG="$config"
  fi

  if bl64_lib_var_is_default "$ansible"; then
    BL64_ANS_PATH_USR_ANSIBLE="${HOME}/.ansible"
  else
    BL64_ANS_PATH_USR_ANSIBLE="$ansible"
  fi

  # shellcheck disable=SC2034
  if bl64_lib_var_is_default "$collections"; then
    BL64_ANS_PATH_USR_COLLECTIONS="${BL64_ANS_PATH_USR_ANSIBLE}/collections/ansible_collections"
  else
    bl64_check_directory "$collections" || return $?
    BL64_ANS_PATH_USR_COLLECTIONS="$ansible"
  fi

  bl64_dbg_lib_show_vars 'BL64_ANS_PATH_USR_CONFIG' 'BL64_ANS_PATH_USR_ANSIBLE' 'BL64_ANS_PATH_USR_COLLECTIONS'
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
function _bl64_ans_set_version() {
  bl64_dbg_lib_show_function
  local cli_version=''

  bl64_dbg_lib_show_info "run ansible to obtain ansible-core version (${BL64_ANS_CMD_ANSIBLE} --version)"
  cli_version="$("$BL64_ANS_CMD_ANSIBLE" --version | bl64_txt_run_awk '/^ansible..core.*$/ { gsub( /\[|\]/, "" ); print $3 }')"
  bl64_dbg_lib_show_vars 'cli_version'

  if [[ -n "$cli_version" ]]; then
    # shellcheck disable=SC2034
    BL64_ANS_VERSION_CORE="$cli_version"
  else
    bl64_msg_show_lib_error "'failed to get CLI version' (${BL64_ANS_CMD_ANSIBLE} --version)"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
  fi

  bl64_dbg_lib_show_vars 'BL64_ANS_VERSION_CORE'
  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with Ansible CLI
#######################################

#######################################
# Install Ansible Collections
#
# Arguments:
#   $@: list of ansible collections to install
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_ans_collections_install() {
  bl64_dbg_lib_show_function "$@"
  local collection=''

  bl64_check_parameters_none "$#" || return $?

  for collection in "$@"; do
    bl64_ans_run_ansible_galaxy \
      collection \
      install \
      --upgrade \
      "$collection" ||
      return $?
  done
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_ans_run_ansible() {
  bl64_dbg_lib_show_function "$@"
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_ANS_MODULE' ||
    return $?

  bl64_msg_app_detail_is_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_is_enabled && debug="$BL64_ANS_SET_DEBUG"

  _bl64_ans_harden_ansible

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ANS_CMD_ANSIBLE" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Use default config
#
# Arguments:
#   $1: command
#   $2: subcommand
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_ans_run_ansible_galaxy() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-${BL64_VAR_NULL}}"
  local subcommand="${2:-${BL64_VAR_NULL}}"
  local debug=' '

  bl64_check_module 'BL64_ANS_MODULE' &&
    bl64_check_parameter 'command' &&
    bl64_check_parameter 'subcommand' ||
    return $?

  bl64_msg_app_detail_is_enabled && debug="$BL64_ANS_SET_VERBOSE"

  _bl64_ans_harden_ansible

  shift
  shift
  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ANS_CMD_ANSIBLE_GALAXY" \
    "$command" \
    "$subcommand" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Use default config
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
function bl64_ans_run_ansible_playbook() {
  bl64_dbg_lib_show_function "$@"
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_ANS_MODULE' ||
    return $?

  bl64_msg_app_detail_is_enabled && debug="${BL64_ANS_SET_VERBOSE} ${BL64_ANS_SET_DIFF}"
  bl64_dbg_lib_command_is_enabled && debug="$BL64_ANS_SET_DEBUG"

  _bl64_ans_harden_ansible

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" \
    $debug \
    "$@"
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
function _bl64_ans_harden_ansible() {
  bl64_dbg_lib_show_function

  if [[ "$BL64_ANS_ENV_IGNORE" == "$BL64_VAR_ON" ]]; then
    bl64_dbg_lib_show_info 'unset inherited ANSIBLE_* shell variables'
    bl64_dbg_lib_trace_start
    unset ANSIBLE_CACHE_PLUGIN_CONNECTION
    unset ANSIBLE_COLLECTIONS_PATHS
    unset ANSIBLE_CONFIG
    unset ANSIBLE_GALAXY_CACHE_DIR
    unset ANSIBLE_GALAXY_TOKEN_PATH
    unset ANSIBLE_INVENTORY
    unset ANSIBLE_LOCAL_TEMP
    unset ANSIBLE_LOG_PATH
    unset ANSIBLE_PERSISTENT_CONTROL_PATH_DIR
    unset ANSIBLE_PLAYBOOK_DIR
    unset ANSIBLE_PRIVATE_KEY_FILE
    unset ANSIBLE_ROLES_PATH
    unset ANSIBLE_SSH_CONTROL_PATH_DIR
    unset ANSIBLE_VAULT_PASSWORD_FILE
    unset ANSIBLE_RETRY_FILES_SAVE_PATH
    bl64_dbg_lib_trace_stop
  fi

  [[ -n "$BL64_ANS_PATH_USR_CONFIG" ]] && export ANSIBLE_CONFIG="$BL64_ANS_PATH_USR_CONFIG"

  return 0
}

#######################################
# BashLib64 / Module / Setup / Interact with RESTful APIs
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_api_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_RXTX_MODULE' &&
    BL64_API_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'api'
}

#######################################
# BashLib64 / Module / Functions / Interact with RESTful APIs
#######################################

#######################################
# Call RESTful API using Curl
#
# * API calls are executed using Curl
# * Curl is used directly instead of the wrapper to minimize shell expansion unintented modifications
# * The caller is responsible for properly url-encoding the query when needed
# * Using curl --fail option to capture HTTP errors
#
# Arguments:
#   $1: API server FQDN. Format: PROTOCOL://FQDN
#   $2: API path. Format: Full path (/X/Y/Z)
#   $3: RESTful method. Format: $BL64_API_METHOD_*. Default: $BL64_API_METHOD_GET
#   $4: API query to be appended to the API path. Format: url encoded string. Default: none
#   $@: additional arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: API call executed. Warning: curl exit status only, not the HTTP status code
#   >: API call failed or unable to call API
#######################################
function bl64_api_call() {
  bl64_dbg_lib_show_function "$@"
  local api_url="$1"
  local api_path="$2"
  local api_method="${3:-${BL64_API_METHOD_GET}}"
  local api_query="${4:-${BL64_VAR_NULL}}"
  local debug="$BL64_RXTX_SET_CURL_SILENT"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_command "$BL64_RXTX_CMD_CURL" &&
    bl64_check_parameter 'api_url' &&
    bl64_check_parameter 'api_path' || return $?

  [[ "$api_query" == "${BL64_VAR_NULL}" ]] && api_query=''
  shift
  shift
  shift
  shift

  bl64_dbg_lib_command_is_enabled && debug="${BL64_RXTX_SET_CURL_VERBOSE} ${BL64_RXTX_SET_CURL_INCLUDE}"
  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  bl64_bsh_job_try "$BL64_API_CALL_SET_MAX_RETRIES" "$BL64_API_CALL_SET_WAIT" \
    "$BL64_RXTX_CMD_CURL" \
    $BL64_RXTX_SET_CURL_FAIL \
    $BL64_RXTX_SET_CURL_REDIRECT \
    $BL64_RXTX_SET_CURL_SECURE \
    $BL64_RXTX_SET_CURL_REQUEST ${api_method} \
    $debug \
    "${api_url}${api_path}${api_query}" \
    "$@"
  bl64_dbg_lib_trace_stop
  status=$?
  ((status != 0)) && bl64_msg_show_lib_error "API call failed (${api_url}${api_path})"
  return "$status"
}

#######################################
# Converts ASCII-127 string to URL compatible format
#
# * Target is the QUERY segment of the URL:
# *   PROTOCOL://FQDN/QUERY
# * Conversion is done using sed
# * Input is assumed to be encoded in ASCII-127
# * Conversion is done as per RFC3986
# *  unreserved: left as is
# *  reserved: converted
# *  remaining ascii-127 non-control chars: converted
# * Warning: sed regexp is not consistent across versions and vendors. Using [] when \ is not possible to scape special chars
#
# Arguments:
#   $1: String to convert. Must be terminated by \n
# Outputs:
#   STDOUT: encoded string
#   STDERR: execution errors
# Returns:
#   0: successfull execution
#   >0: failed to convert
#######################################
function bl64_api_url_encode() {
  bl64_dbg_lib_show_function "$@"
  local raw_string="$1"

  bl64_check_parameter 'raw_string' || return $?

  echo "$raw_string" |
    bl64_txt_run_sed \
      -e 's/%/%25/g' \
      -e 's/ /%20/g' \
      -e 's/:/%3A/g' \
      -e 's/\//%2F/g' \
      -e 's/[?]/%3F/g' \
      -e 's/#/%23/g' \
      -e 's/@/%40/g' \
      -e 's/\[/%5B/g' \
      -e 's/\]/%5D/g' \
      -e 's/\!/%21/g' \
      -e 's/\$/%24/g' \
      -e 's/&/%26/g' \
      -e "s/'/%27/g" \
      -e 's/[(]/%28/g' \
      -e 's/[)]/%29/g' \
      -e 's/\*/%2A/g' \
      -e 's/[+]/%2B/g' \
      -e 's/,/%2C/g' \
      -e 's/;/%3B/g' \
      -e 's/=/%3D/g' \
      -e 's/"/%22/g' \
      -e 's/</%3C/g' \
      -e 's/>/%3E/g' \
      -e 's/\^/%5E/g' \
      -e 's/`/%60/g' \
      -e 's/{/%7B/g' \
      -e 's/}/%7D/g' \
      -e 's/[|]/%7C/g' \
      -e 's/[\]/%5C/g'
}

#######################################
# BashLib64 / Module / Setup / Manage archive files
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_arc_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_arc_set_command &&
    _bl64_arc_set_options &&
    BL64_ARC_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'arc'
}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_arc_set_command() {
  bl64_dbg_lib_show_comments 'detect optional commands. No error if not found'
  BL64_ARC_CMD_BUNZIP2="$(bl64_bsh_command_locate 'bunzip2')"
  BL64_ARC_CMD_GUNZIP="$(bl64_bsh_command_locate 'gunzip')"
  BL64_ARC_CMD_UNXZ="$(bl64_bsh_command_locate 'unxz')"
  BL64_ARC_CMD_7ZZ="$(bl64_bsh_command_locate '7zz')"

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    BL64_ARC_CMD_ZIP='/usr/bin/zip'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    BL64_ARC_CMD_ZIP='/usr/bin/zip'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    BL64_ARC_CMD_ZIP='/usr/bin/zip'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    BL64_ARC_CMD_ZIP='/usr/bin/zip'
    ;;
  ${BL64_OS_ARC}-*)
    BL64_ARC_CMD_TAR='/usr/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    BL64_ARC_CMD_ZIP='/usr/bin/zip'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_ARC_CMD_TAR='/usr/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    BL64_ARC_CMD_ZIP='/usr/bin/zip'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_arc_set_options() {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_ARC_SET_TAR_VERBOSE='-v'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_ARC}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Manage archive files
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_arc_open_tar() {
  bl64_msg_show_deprecated 'bl64_arc_open_tar' 'bl64_arc_tar_open'
  bl64_arc_tar_open "$@"
}

function bl64_arc_open_zip() {
  bl64_msg_show_deprecated 'bl64_arc_open_zip' 'bl64_arc_zip_open'
  bl64_arc_zip_open "$@"
}

#
# Private functions
#

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
function _bl64_arc_harden_unzip() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset UNZIP
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_arc_harden_zip() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset ZIP
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_arc_harden_gzip() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset GZIP
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_arc_harden_bzip2() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset BZIP
  unset BZIP2
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_arc_harden_unxz() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset XZ_DEFAULTS
  unset XZ_OPT
  bl64_dbg_lib_trace_stop

  return 0
}

#
# Public functions
#

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_unzip() {
  bl64_dbg_lib_show_function "$@"
  local verbose='-qq'

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_UNZIP" || return $?

  bl64_msg_app_run_is_enabled && verbose=' '

  _bl64_arc_harden_unzip

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_UNZIP" \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_zip() {
  bl64_dbg_lib_show_function "$@"
  local verbose=' '

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_ZIP" || return $?

  bl64_msg_app_run_is_enabled && verbose='--verbose'

  _bl64_arc_harden_zip

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_ZIP" \
    $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_7zz() {
  bl64_dbg_lib_show_function "$@"
  local verbose='-bso0 -bd'

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_7ZZ" || return $?

  bl64_msg_app_run_is_enabled &&
    verbose='-bso1'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_7ZZ" \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_arc_run_tar() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_command "$BL64_ARC_CMD_TAR" ||
    return $?

  bl64_msg_app_run_is_enabled && verbose="$BL64_ARC_SET_TAR_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_TAR" \
    "$@" $verbose
  bl64_dbg_lib_trace_stop
}

#######################################
# Open tar files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_tar_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local -i status=0

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open tar archive ($source)"

  bl64_bsh_run_pushd "$destination" ||
    return $?

  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_arc_run_tar \
        --overwrite \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --force-local \
        --auto-compress \
        --file="$source"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      bl64_arc_run_tar \
        --overwrite \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --force-local \
        --auto-compress \
        --file="$source"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_arc_run_tar \
        --overwrite \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --force-local \
        --auto-compress \
        --file="$source"
      ;;
    ${BL64_OS_ALP}-*)
      bl64_arc_run_tar \
        x \
        --overwrite \
        -f "$source" \
        -o
      ;;
    ${BL64_OS_ARC}-*)
      bl64_arc_run_tar \
        --overwrite \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --force-local \
        --auto-compress \
        --file="$source"
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_arc_run_tar \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --file="$source"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
  status=$?

  if ((status == 0)); then
    bl64_fs_file_remove "$source"
    bl64_bsh_run_popd
  fi
  return "$status"
}

#######################################
# Open zip files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_zip_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local -i status=0

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open zip archive ($source)"
  # shellcheck disable=SC2086
  bl64_arc_run_unzip \
    $BL64_ARC_SET_UNZIP_OVERWRITE \
    -d "$destination" \
    "$source"
  status=$?

  ((status == 0)) && bl64_fs_file_remove "$source"

  return "$status"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_unxz() {
  bl64_dbg_lib_show_function "$@"
  local verbose=' '

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_UNXZ" || return $?

  bl64_msg_app_run_is_enabled && verbose='-v'

  _bl64_arc_harden_unxz

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_UNXZ" \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_bunzip2() {
  bl64_dbg_lib_show_function "$@"
  local verbose='--quiet'

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_BUNZIP2" || return $?

  bl64_msg_app_detail_is_enabled && verbose='--verbose'

  _bl64_arc_harden_bzip2

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_BUNZIP2" \
    $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_gunzip() {
  bl64_dbg_lib_show_function "$@"
  local verbose='--quiet'

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_GUNZIP" || return $?

  bl64_msg_app_run_is_enabled && verbose='--verbose'

  _bl64_arc_harden_gzip

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_GUNZIP" \
    $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Open gzip files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_gzip_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open gzip archive ($source)"
  # shellcheck disable=SC2086
  cd "$destination" &&
    bl64_arc_run_gunzip \
      --decompress \
      "$source"
}

#######################################
# Open 7z files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_7z_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open 7z archive ($source)"
  # shellcheck disable=SC2086
  bl64_arc_run_7zz \
    -aoa \
    -y \
    "-o${destination}" \
    x \
    "$source"
}

#######################################
# Open bzip2 files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_bzip2_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open bzip2 archive ($source)"
  # shellcheck disable=SC2086
  cd "$destination" &&
    bl64_arc_run_bunzip2 \
      --decompress \
      --force \
      "$source"
}

#######################################
# BashLib64 / Module / Setup / Interact with AWS
#######################################

#
# Module attributes getters
#

function bl64_aws_get_cli_config() {
  bl64_dbg_lib_show_function
  bl64_check_module 'BL64_AWS_MODULE' || return $?
  echo "$BL64_AWS_CLI_CONFIG"
}

function bl64_aws_get_cli_credentials() {
  bl64_dbg_lib_show_function
  bl64_check_module 'BL64_AWS_MODULE' || return $?
  echo "$BL64_AWS_CLI_CREDENTIALS"
}

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: CLI Path. Format: Full path. Default: $PATH
#   $2: AWS_HOME. Format: full path. Default: AWS CLI default
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_aws_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local aws_bin="${1:-${BL64_VAR_DEFAULT}}"
  local aws_home="${2:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_aws_set_command "$aws_bin" &&
    bl64_check_command "$BL64_AWS_CMD_AWS" &&
    _bl64_aws_set_options &&
    _bl64_aws_set_resources &&
    _bl64_aws_set_runtime "$aws_home" &&
    BL64_AWS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'aws'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_aws_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_AWS_CMD_AWS="$(bl64_bsh_command_locate 'aws' '/opt/aws/bin' "$@")"
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
function _bl64_aws_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  {
    BL64_AWS_SET_FORMAT_JSON='--output json'
    BL64_AWS_SET_FORMAT_TEXT='--output text'
    BL64_AWS_SET_FORMAT_TABLE='--output table'
    BL64_AWS_SET_FORMAT_YAML='--output yaml'
    BL64_AWS_SET_FORMAT_STREAM='--output yaml-stream'
    BL64_AWS_SET_DEBUG='--debug'
    BL64_AWS_SET_OUPUT_NO_PAGER='--no-cli-pager'
    BL64_AWS_SET_OUPUT_NO_COLOR='--color off'
    BL64_AWS_SET_INPUT_NO_PROMPT='--no-cli-auto-prompt'
  }
  return 0
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
function _bl64_aws_set_resources() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  {
    BL64_AWS_DEF_SUFFIX_TOKEN='json'
    BL64_AWS_DEF_SUFFIX_HOME='.aws'
    BL64_AWS_DEF_SUFFIX_CACHE='sso/cache'
    BL64_AWS_DEF_SUFFIX_CONFIG='cfg'
    BL64_AWS_DEF_SUFFIX_CREDENTIALS='secret'
  }
  return 0
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: setting errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function _bl64_aws_set_runtime() {
  bl64_dbg_lib_show_function "$@"
  local aws_home="$1"
  bl64_aws_set_home "$aws_home" &&
    bl64_aws_set_paths "$aws_home"
}

#######################################
# Set AWS_HOME
#
# * Use a different path to avoid inheriting or altering user's current setup
# * Home is created if not present. Current user and groups are used
#
# Arguments:
#   $1: Full path. Default: $HOME/.aws
# Outputs:
#   STDOUT: verbose operation
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
# shellcheck disable=SC2120
function bl64_aws_set_home() {
  bl64_dbg_lib_show_function "$@"
  local aws_home="${1:-$BL64_VAR_DEFAULT}"

  if bl64_lib_var_is_default "$aws_home"; then
    bl64_check_home || return $?
    aws_home="${HOME}/${BL64_AWS_DEF_SUFFIX_HOME}"
  fi
  bl64_msg_show_lib_subtask "prepare AWS CLI home (${aws_home})"
  bl64_fs_dir_create "$BL64_AWS_CLI_MODE" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$aws_home" &&
    BL64_AWS_CLI_HOME="$aws_home"
}

#######################################
# Set and prepare module paths
#
# * Global paths only
# * If preparation fails the whole module fails
#
# Arguments:
#   $1: configuration file name
#   $2: credential file name
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
# shellcheck disable=SC2120
function bl64_aws_set_paths() {
  bl64_dbg_lib_show_function "$@"
  local configuration="${1:-${BL64_SCRIPT_ID}}"
  local credentials="${2:-${BL64_SCRIPT_ID}}"

  bl64_dbg_lib_show_info 'set configuration paths'
  BL64_AWS_CLI_CACHE="${BL64_AWS_CLI_HOME}/${BL64_AWS_DEF_SUFFIX_CACHE}"
  BL64_AWS_CLI_CONFIG="${BL64_AWS_CLI_HOME}/${configuration}.${BL64_AWS_DEF_SUFFIX_CONFIG}"
  BL64_AWS_CLI_CREDENTIALS="${BL64_AWS_CLI_HOME}/${credentials}.${BL64_AWS_DEF_SUFFIX_CREDENTIALS}"

  bl64_dbg_lib_show_vars 'BL64_AWS_CLI_CACHE' 'BL64_AWS_CLI_CONFIG' 'BL64_AWS_CLI_CREDENTIALS'
  return 0
}

#######################################
# Set AWS region
#
# * Use anytime you neeto to change the target region
#
# Arguments:
#   $1: AWS region
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_set_region() {
  bl64_dbg_lib_show_function "$@"
  local region="${1:-}"
  bl64_check_parameter 'region' || return $?
  BL64_AWS_CLI_REGION="$region"
  bl64_msg_show_lib_subtask "set AWS region (${BL64_AWS_CLI_REGION})"
  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with AWS
#######################################

#######################################
# Creates a SSO profile in the AWS CLI configuration file
#
# * Equivalent to aws configure sso
#
# Arguments:
#   $1: profile name
#   $2: start url
#   $3: region
#   $4: account id
#   $5: permission set
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################

function bl64_aws_cli_create_sso() {
  bl64_dbg_lib_show_function "$@"
  local profile="${1:-${BL64_VAR_DEFAULT}}"
  local start_url="${2:-${BL64_VAR_DEFAULT}}"
  local sso_region="${3:-${BL64_VAR_DEFAULT}}"
  local sso_account_id="${4:-${BL64_VAR_DEFAULT}}"
  local sso_role_name="${5:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'profile' &&
    bl64_check_parameter 'start_url' &&
    bl64_check_parameter 'sso_region' &&
    bl64_check_parameter 'sso_account_id' &&
    bl64_check_parameter 'sso_role_name' &&
    bl64_check_module 'BL64_AWS_MODULE' ||
    return $?

  bl64_dbg_lib_show_info "create AWS CLI profile for AWS SSO login (${BL64_AWS_CLI_CONFIG})"
  printf '[profile %s]\n' "$profile" >"$BL64_AWS_CLI_CONFIG" &&
    printf 'sso_start_url = %s\n' "$start_url" >>"$BL64_AWS_CLI_CONFIG" &&
    printf 'sso_region = %s\n' "$sso_region" >>"$BL64_AWS_CLI_CONFIG" &&
    printf 'sso_account_id = %s\n' "$sso_account_id" >>"$BL64_AWS_CLI_CONFIG" &&
    printf 'sso_role_name = %s\n' "$sso_role_name" >>"$BL64_AWS_CLI_CONFIG"

}

#######################################
# Login to AWS using SSO
#
# * Run bl64_aws_set_access_sso to set the target profile first
# * Equivalent to aws --profile X sso login
# * The SSO profile must be already created
# * SSO login requires a browser connection. The command will show the URL to open to get the one time code
#
# Arguments:
#   $1: profile name
# Outputs:
#   STDOUT: login process information
#   STDERR: command stderr
# Returns:
#   0: login ok
#   >0: failed to login
#######################################
function bl64_aws_sso_login() {
  bl64_dbg_lib_show_function
  bl64_check_module 'BL64_AWS_MODULE' &&
    bl64_check_parameter 'BL64_AWS_ACCESS_PROFILE' ||
    return $?
  bl64_aws_run_aws \
    sso \
    login \
    --no-browser
}

#######################################
# Get current caller ARN
#
# Arguments:
#   None
# Outputs:
#   STDOUT: ARN
#   STDERR: command stderr
# Returns:
#   0: got value ok
#   >0: failed to get
#######################################
function bl64_aws_sts_get_caller_arn() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2086
  bl64_aws_run_aws \
    $BL64_AWS_SET_FORMAT_TEXT \
    --query '[Arn]' \
    sts \
    get-caller-identity
}

#######################################
# Get file path to the SSO cached token
#
# * Token must first be generated by aws sso login
# * Token is saved in a fixed location, but with random file name
#
# Arguments:
#   $1: profile name
# Outputs:
#   STDOUT: token path
#   STDERR: command stderr
# Returns:
#   0: got value ok
#   >0: failed to get
#######################################
function bl64_aws_sso_get_token() {
  bl64_dbg_lib_show_function "$@"
  local start_url="${1:-}"
  local token_file=''

  bl64_check_module 'BL64_AWS_MODULE' &&
    bl64_check_parameter 'start_url' &&
    bl64_check_directory "$BL64_AWS_CLI_CACHE" ||
    return $?

  bl64_dbg_lib_show_info "search for sso login token (${BL64_AWS_CLI_CACHE})"
  bl64_dbg_lib_trace_start
  token_file="$(bl64_fs_file_search \
    "$BL64_AWS_CLI_CACHE" \
    "*.${BL64_AWS_DEF_SUFFIX_TOKEN}" \
    "$start_url")"
  bl64_dbg_lib_trace_stop

  if [[ -n "$token_file" && -r "$token_file" ]]; then
    echo "$token_file"
  else
    bl64_msg_show_lib_error 'unable to locate temporary access token file'
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi

}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Use bl64_aws_set_access_* to set access mode first. If not, will use defaults
# * Trust no one. Ignore inherited config and use explicit config
# * AWS CLI has no verbosity control other than debug info
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
function bl64_aws_run_aws() {
  bl64_dbg_lib_show_function "$@"
  local verbosity="$BL64_AWS_SET_OUPUT_NO_COLOR"
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_AWS_MODULE' ||
    return $?

  bl64_msg_app_run_is_enabled && verbosity=' '
  bl64_dbg_lib_command_is_enabled && debug="$BL64_AWS_SET_DEBUG"

  _bl64_aws_harden_aws &&
    _bl64_aws_run_aws_prepare ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_AWS_CMD_AWS" \
    $BL64_AWS_SET_INPUT_NO_PROMPT \
    $BL64_AWS_SET_OUPUT_NO_PAGER \
    $verbosity $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Prepare CLI environment for execution
#
# * Sets access credential
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: preparation ok
#   >0: failed to prepare
#######################################
function _bl64_aws_run_aws_prepare() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'Set CLI configuration'
  export AWS_CONFIG_FILE="$BL64_AWS_CLI_CONFIG"
  bl64_dbg_lib_show_vars 'AWS_CONFIG_FILE'

  if [[ -n "$BL64_AWS_CLI_REGION" ]]; then
    bl64_dbg_lib_show_info 'Set Default region'
    export AWS_REGION="$BL64_AWS_CLI_REGION"
    bl64_dbg_lib_show_vars 'AWS_REGION'
  fi

  bl64_dbg_lib_show_info 'Set credentials'
  export AWS_SHARED_CREDENTIALS_FILE="$BL64_AWS_CLI_CREDENTIALS"
  bl64_dbg_lib_show_vars 'AWS_CONFIG_FILE' 'AWS_SHARED_CREDENTIALS_FILE'
  case "$BL64_AWS_ACCESS_MODE" in
    "$BL64_AWS_ACCESS_MODE_PROFILE")
      export AWS_PROFILE="$BL64_AWS_ACCESS_PROFILE"
      bl64_dbg_lib_show_vars 'AWS_PROFILE'
      ;;
    "$BL64_AWS_ACCESS_MODE_SSO")
      export AWS_PROFILE="$BL64_AWS_ACCESS_PROFILE"
      bl64_dbg_lib_show_vars 'AWS_PROFILE'
      ;;
    "$BL64_AWS_ACCESS_MODE_KEY")
      export AWS_ACCESS_KEY_ID="$BL64_AWS_ACCESS_KEY_ID"
      export AWS_SECRET_ACCESS_KEY="$BL64_AWS_ACCESS_KEY_SECRET"
      bl64_dbg_lib_show_vars 'AWS_ACCESS_KEY_ID' 'AWS_SECRET_ACCESS_KEY'
      ;;
    "$BL64_AWS_ACCESS_MODE_TOKEN")
      export AWS_ACCESS_KEY_ID="$BL64_AWS_ACCESS_KEY_ID"
      export AWS_SECRET_ACCESS_KEY="$BL64_AWS_ACCESS_KEY_SECRET"
      export AWS_SESSION_TOKEN="$BL64_AWS_ACCESS_TOKEN"
      bl64_dbg_lib_show_vars 'AWS_ACCESS_KEY_ID' 'AWS_SECRET_ACCESS_KEY' 'AWS_SESSION_TOKEN'
      ;;
    *)
      bl64_dbg_lib_show_info 'No access mode requested, using CLI defaults'
      ;;
  esac
  return 0
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
function _bl64_aws_harden_aws() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited AWS_* shell variables'
  bl64_dbg_lib_trace_start
  unset AWS_PAGER
  unset AWS_PROFILE
  unset AWS_REGION
  unset AWS_CA_BUNDLE
  unset AWS_CONFIG_FILE
  unset AWS_DATA_PATH
  unset AWS_DEFAULT_OUTPUT
  unset AWS_DEFAULT_REGION
  unset AWS_MAX_ATTEMPTS
  unset AWS_RETRY_MODE
  unset AWS_ROLE_ARN
  unset AWS_SESSION_TOKEN
  unset AWS_ACCESS_KEY_ID
  unset AWS_CLI_AUTO_PROMPT
  unset AWS_CLI_FILE_ENCODING
  unset AWS_METADATA_SERVICE_TIMEOUT
  unset AWS_ROLE_SESSION_NAME
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SHARED_CREDENTIALS_FILE
  unset AWS_EC2_METADATA_DISABLED
  unset AWS_METADATA_SERVICE_NUM_ATTEMPTS
  unset AWS_WEB_IDENTITY_TOKEN_FILE
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Set profile credential information
#
# * CLI access mode will be set to use the target profile
# * The profile must be already configure, no check is done to verify it
# * Access mode is tested by calling sts caller id
#
# Arguments:
#   $1: Profile name
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_access_enable_profile() {
  bl64_dbg_lib_show_function "$@"
  local profile_name="${1:-}"

  bl64_check_parameter 'profile_name' &&
    bl64_check_module 'BL64_AWS_MODULE' ||
    return $?

  bl64_msg_show_lib_task "Enable AWS CLI Profile access mode (${profile_name})"
  BL64_AWS_ACCESS_PROFILE="$profile_name"
  BL64_AWS_ACCESS_MODE="$BL64_AWS_ACCESS_MODE_PROFILE"
  bl64_dbg_lib_show_vars 'BL64_AWS_ACCESS_MODE' 'BL64_AWS_ACCESS_PROFILE'
  bl64_aws_sts_get_caller_arn
}

#######################################
# Set sso credential information
#
# * CLI access mode will be set to use the target SSO profile
# * The profile must be already configure, no check is done to verify it
# * SSO Login must be already called before this function
# * Access mode is tested by calling sts caller id
#
# Arguments:
#   $1: Profile name
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_access_enable_sso() {
  bl64_dbg_lib_show_function "$@"
  local profile_name="${1:-}"

  bl64_check_parameter 'profile_name' &&
    bl64_check_module 'BL64_AWS_MODULE' ||
    return $?

  bl64_msg_show_lib_task "Enable AWS SSO access mode (${profile_name})"
  BL64_AWS_ACCESS_PROFILE="$profile_name"
  BL64_AWS_ACCESS_MODE="$BL64_AWS_ACCESS_MODE_SSO"
  bl64_dbg_lib_show_vars 'BL64_AWS_ACCESS_MODE' 'BL64_AWS_ACCESS_PROFILE'
  bl64_aws_sts_get_caller_arn
}

#######################################
# Set Key credential information
#
# * CLI access mode will be set to use IAM API Keys
# * Access mode is tested by calling sts caller id
#
# Arguments:
#   $1: Key ID
#   $2: Key Secret
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_access_enable_key() {
  bl64_dbg_lib_show_function "$@"
  local key_id="${1:-}"
  local key_secret="${2:-}"

  bl64_check_parameter 'key_id' &&
    bl64_check_parameter 'key_secret' &&
    bl64_check_module 'BL64_AWS_MODULE' ||
    return $?

  bl64_msg_show_lib_task "Enable AWS IAM Key access mode (${key_id})"
  BL64_AWS_ACCESS_KEY_ID="$key_id"
  BL64_AWS_ACCESS_KEY_SECRET="$key_secret"
  BL64_AWS_ACCESS_MODE="$BL64_AWS_ACCESS_MODE_KEY"
  bl64_dbg_lib_show_vars 'BL64_AWS_ACCESS_MODE' 'BL64_AWS_ACCESS_KEY_ID'
  bl64_aws_sts_get_caller_arn
}

#######################################
# Set session token credential information
#
# * CLI access mode will be set to use session token
# * Access mode is tested by calling sts caller id
#
# Arguments:
#   $1: Key ID
#   $2: Key Secret
#   $3: Token
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_aws_access_enable_token() {
  bl64_dbg_lib_show_function "$@"
  local key_id="${1:-}"
  local key_secret="${2:-}"
  local token="${3:-}"

  bl64_check_parameter 'key_id' &&
    bl64_check_parameter 'key_secret' &&
    bl64_check_parameter 'token' &&
    bl64_check_module 'BL64_AWS_MODULE' ||
    return $?

  bl64_msg_show_lib_task "Enable AWS Session Token access mode (${key_id})"
  BL64_AWS_ACCESS_KEY_ID="$key_id"
  BL64_AWS_ACCESS_KEY_SECRET="$key_secret"
  BL64_AWS_ACCESS_TOKEN="$token"
  BL64_AWS_ACCESS_MODE="$BL64_AWS_ACCESS_MODE_TOKEN"
  bl64_dbg_lib_show_vars 'BL64_AWS_ACCESS_MODE' 'BL64_AWS_ACCESS_KEY_ID' 'BL64_AWS_ACCESS_TOKEN'
  bl64_aws_sts_get_caller_arn
}

#######################################
# BashLib64 / Module / Setup / Interact with Bash shell
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_bsh_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_XSV_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_bsh_set_options &&
    _bl64_bsh_set_version &&
    BL64_BSH_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'bsh'
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
#   $BL64_LIB_ERROR_OS_BASH_VERSION
#######################################
function _bl64_bsh_set_version() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "${BASH_VERSINFO[0]}" in
  4*) BL64_BSH_VERSION_BASH='4.0' ;;
  5*) BL64_BSH_VERSION_BASH='5.0' ;;
  *)
    bl64_check_alert_unsupported "Bash: ${BASH_VERSINFO[0]}"
    return "$BL64_LIB_ERROR_OS_BASH_VERSION"
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_BSH_VERSION_BASH'

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
function _bl64_bsh_set_options() {
  bl64_dbg_lib_show_function

  bl64_check_home || return $?

  # Default XDG paths. Paths may not exist
  # shellcheck disable=SC2034
  {
    BL64_BSH_XDG_PATH_CONFIG="${HOME}/.config"
    BL64_BSH_XDG_PATH_CACHE="${HOME}/.cache"
    BL64_BSH_XDG_PATH_LOCAL="${HOME}/.local"
    BL64_BSH_XDG_PATH_BIN="${BL64_BSH_XDG_PATH_LOCAL}/bin"
  }
}

#######################################
# BashLib64 / Module / Functions / Interact with Bash shell
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_bsh_script_set_id() {
  bl64_msg_show_deprecated 'bl64_bsh_script_set_id' 'bl64_lib_script_set_id'
  bl64_lib_script_set_id "$@"
}
function bl64_bsh_script_set_identity() {
  bl64_msg_show_deprecated 'bl64_bsh_script_set_identity' 'bl64_lib_script_set_identity'
  bl64_lib_script_set_identity "$@"
}

#
# Public functions
#

#######################################
# Perform safe filename expansion using pattern
#
# * If no patch, return empty string
# * Include hidden files
# * Allow extended patterns
# * Case sensitive
# * Allow ** and */ patterns
#
# Arguments:
#   $*: pattern
# Outputs:
#   STDOUT: pattern match. Empty is none
#   STDERR: Error messages
# Returns:
#   0: task completed
#   >0: validation error
#######################################
function bl64_bsh_pattern_match_file() {
  bl64_dbg_lib_show_function
  local -i current_nullglob=0
  local -i current_nocaseglob=0
  local -i current_dotglob=0
  local -i current_globstar=0
  local -i current_extglob=0
  local flag=''
  local status=''

  bl64_check_parameters_none $# || return $?

  shopt -q nullglob
  # shellcheck disable=SC2034
  current_nullglob=$?
  shopt -q nocaseglob
  # shellcheck disable=SC2034
  current_nocaseglob=$?
  shopt -q dotglob
  # shellcheck disable=SC2034
  current_dotglob=$?
  shopt -q globstar
  # shellcheck disable=SC2034
  current_globstar=$?
  shopt -q extglob
  # shellcheck disable=SC2034
  current_extglob=$?

  shopt -q -s nullglob
  shopt -q -u nocaseglob
  shopt -q -s dotglob
  shopt -q -s globstar
  shopt -q -s extglob

  # shellcheck disable=SC2086,SC2068
  echo $@

  for flag in nullglob nocaseglob dotglob globstar extglob; do
    status="current_${flag}"
    if ((${!status} == 0)); then
      shopt -q -s "$flag"
    else
      shopt -q -u "$flag"
    fi
  done
  return 0
}

#######################################
# Get current script location
#
# Arguments:
#   None
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: full path
#   >0: command error
#######################################
function bl64_bsh_script_get_path() {
  bl64_dbg_lib_show_function
  local -i main=${#BASH_SOURCE[*]}
  local caller=''

  ((main > 0)) && main=$((main - 1))
  caller="${BASH_SOURCE[${main}]}"

  unset CDPATH &&
    [[ -n "$caller" ]] &&
    cd -- "${caller%/*}" >/dev/null &&
    pwd -P ||
    return $?
}

#######################################
# Get current script name
#
# Arguments:
#   None
# Outputs:
#   STDOUT: script name
#   STDERR: Error messages
# Returns:
#   0: name
#   >0: command error
#######################################
function bl64_bsh_script_get_name() {
  bl64_dbg_lib_show_function
  local -i main=${#BASH_SOURCE[*]}

  ((main > 0)) && main=$((main - 1))

  bl64_fmt_path_get_basename "${BASH_SOURCE[${main}]}"
}

#######################################
# Generate a string that can be used to populate shell.env files
#
# * Export format is bash compatible
#
# Arguments:
#   $1: variable name
#   $2: value
# Outputs:
#   STDOUT: export string
#   STDERR: Error messages
# Returns:
#   0: string created
#   >0: creation error
#######################################
function bl64_bsh_env_export_variable() {
  bl64_dbg_lib_show_function "$@"
  local variable="${1:-${BL64_VAR_NULL}}"
  local value="${2:-}"

  bl64_check_parameter 'variable' ||
    return $?

  printf "export %s='%s'\n" "$variable" "$value"
}

#######################################
# Import shell environment variables from YAML file
#
# * Conversion is done using YQ and Awk
# * YAML nested variables are flatten and converted to single shell variables:
#   * first.second: value -> FIRST_SECOND="value"
#   * first.second[2]: value -> FIRST_SECOND_2="value"
# * Shell variable names are created using uppercase and exported
# * Resulting variables are saved to a temporary file which is then sourced into the current script
#
# Arguments:
#   $1: path to the YAML file
# Outputs:
#   STDOUT: none
#   STDERR: conversion errors
# Returns:
#   0: converted and lodaded ok
#   >0: failed to convert
#######################################
function bl64_bsh_env_import_yaml() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local dynamic_env=''

  bl64_check_parameter 'source' &&
    bl64_check_file "$source" ||
    return $?

  # shellcheck disable=SC1090
  bl64_msg_show_subtask "convert and import shell variables from YAML file (${source})"
  # shellcheck disable=SC1090
  dynamic_env="$(bl64_fs_create_tmpfile)" &&
    bl64_xsv_run_yq \
      -o p \
      '.' \
      "$source" |
    bl64_txt_run_awk \
      -F ' = ' '
  {
      gsub( "[.]", "_", $1 )
      print "export " toupper( $1 ) "='"'"'" $2 "'"'"'"
  }' >"$dynamic_env" &&
    source "$dynamic_env" ||
    return $?

  bl64_fs_rm_tmpfile "$dynamic_env"
  return 0
}

#######################################
# Determine the full path of a command
#
# * valid for command type only (type -p)
# * if the command is already a path, nothing else is done
#
# Arguments:
#   $1: command name with/without path
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: full path detected
#   >0: unable to detect or error
#######################################
function bl64_bsh_command_get_path() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-}"
  local full_path=''

  bl64_check_parameter 'command' ||
    return $?

  full_path="$(type -p "${command}")"
  if [[ -n "$full_path" ]]; then
    echo "$full_path"
    return 0
  fi
  return "$BL64_LIB_ERROR_TASK_FAILED"
}

#######################################
# Check if the command is executable
#
# * command is first converted to full path
#
# Arguments:
#   $1: command name with/without path
# Outputs:
#   STDOUT: none
#   STDERR: Error messages
# Returns:
#   0: command is executable
#   >0: command is not present or not executable
#######################################
function bl64_bsh_command_is_executable() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-}"
  local full_path=''

  bl64_check_parameter 'command' ||
    return $?

  full_path="$(bl64_bsh_command_get_path "${command}")" ||
    return $?
  [[ ! -e "$full_path" ]] &&
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  [[ ! -x "$full_path" ]] &&
    return "$BL64_LIB_ERROR_FILE_NOT_EXECUTE"
  [[ -x "$full_path" ]] ||
    return "$BL64_LIB_ERROR_TASK_FAILED"
}

#######################################
# Create env file store
#
# * Use to store .env files that can later be automatically loaded by the shell profile
#
# Arguments:
#   $1: User home path. Default: HOME
#   $2: permissions. Default: 0750
#   $3: user name. Default: current
#   $4: group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: Error messages
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_env_store_create() {
  bl64_dbg_lib_show_function "$@"
  local home="${1:-$HOME}"
  local mode="${2:-$BL64_VAR_DEFAULT}"
  local user="${3:-$BL64_VAR_DEFAULT}"
  local group="${4:-$BL64_VAR_DEFAULT}"
  local mode='0750'

  bl64_check_home || return $?

  bl64_lib_var_is_default "$mode" && mode='0750'
  bl64_fs_dir_create "$mode" "$user" "$group" \
    "${home}/${BL64_BSH_ENV_STORE}"
}

#######################################
# Determines if the env store is present
#
# * Check that the store is presend only (directory path)
# * No check is done to detect if the shell properly configured to auto-load on login from the store
#
# Arguments:
#   $1: User home path. Default: HOME
# Outputs:
#   STDOUT: None
#   STDERR: Error messages
# Returns:
#   0: store is present
#   >0: store is not present or error
#######################################
function bl64_bsh_env_store_is_present() {
  bl64_dbg_lib_show_function
  local home="${1:-$HOME}"

  bl64_check_home || return $?
  [[ -d "${home}/${BL64_BSH_ENV_STORE}" ]]
}

#######################################
# Publish existing .env files to the store
#
# * The source file is sym-linked to the store
# * The source file must have permissions for the user to use it
#
# Arguments:
#   $1: Full path to the source .env file
#   $2: Load priority. Default: 64
#   $3: User home path. Default: HOME
# Outputs:
#   STDOUT: progress
#   STDERR: Error messages
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_env_store_publish() {
  bl64_dbg_lib_show_function "$@"
  local source_env="${1:-}"
  local priority="${2:-64}"
  local home="${3:-$HOME}"
  local target=''

  bl64_check_home &&
    bl64_check_parameter 'source_env' &&
    bl64_check_file "$source_env" &&
    bl64_check_directory "${home}/${BL64_BSH_ENV_STORE}" ||
    return $?

  target="${home}/${BL64_BSH_ENV_STORE}/${priority}_$(bl64_fmt_path_get_basename "$source_env")" &&
    bl64_fs_create_symlink \
      "$source_env" \
      "$target" \
      "$BL64_VAR_ON"
}

#######################################
# Generate env file loader snippet
#
# * Use to generate bash snippet that can be added to user's profile
#
# Arguments:
#   None
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_env_store_generate() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2016
  printf '
# Load .env files from user store
if [[ -d "${HOME}/%s" ]]; then
  _module=""
  for _module in "${HOME}/%s"/*.env; do
    [[ -r "$_module" ]] &&
      source "$_module"
  done
  unset _module
fi\n
' "$BL64_BSH_ENV_STORE" "$BL64_BSH_ENV_STORE"
}

#######################################
# Generate bash rc snippet
#
# * Generic bashrc content to allow modular content
# * System PATH setting only
#
# Arguments:
#   None
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_profile_rc_generate() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2016
  printf '
# Set initial system path
export PATH="/bin:/usr/bin"

# Load global RC
[[ -f '/etc/bashrc' ]] &&
  source '/etc/bashrc'

# Load user RC
if [[ -d "${HOME}/.bashrc.d" ]]; then
  _module=""
  for _module in "${HOME}/.bashrc.d"/*.sh; do
    [[ -r "$_module" ]] &&
      source "$_module"
  done
  unset _module
fi\n
'
}

#######################################
# Generate bash profile snippet
#
# * Generic bash_profile content to allow modular content
#
# Arguments:
#   None
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_profile_bash_generate() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2016
  printf '
# Import BashRC content
if [[ -f "${HOME}/.bashrc" ]]; then
  source "${HOME}/.bashrc"
fi\n
'
}

#######################################
# Generate bash PATH snippet
#
# * Includes common search paths for:
# *  XDG
# *  NPM
#
# Arguments:
#   $1: insecure setting?: ON: user paths first. OFF: user paths last. Default: OFF
#   $2: include system paths?. Default: OFF
#   $3: extra paths, separated by :
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_profile_path_generate() {
  bl64_dbg_lib_show_function "$@"
  local insecure="${1:-$BL64_VAR_OFF}"
  local system="${2:-$BL64_VAR_OFF}"
  local paths_extra="${3:-}"
  local paths_base=''
  local paths_system=''
  local paths_user=''

  paths_base+='/bin:'
  paths_base+='/usr/bin:'
  paths_base+='/usr/local/bin'

  paths_system+='/sbin:'
  paths_system+='/usr/sbin:'
  paths_system+='/usr/local/sbin'

  # shellcheck disable=SC2016
  paths_user+='$HOME/bin:'
  # shellcheck disable=SC2016
  paths_user+='$HOME/.local/bin:'
  # shellcheck disable=SC2016
  paths_user+='$HOME/node_modules/.bin'

  bl64_lib_flag_is_enabled "$system" &&
    paths_base+=":${paths_system}"

  if bl64_lib_flag_is_enabled "$insecure"; then
    printf '\nPATH="%s"\n' "${paths_extra}${paths_extra:+:}${paths_user}:${paths_base}"
  else
    printf '\nPATH="%s"\n' "${paths_base}:${paths_user}${paths_extra:+:}${paths_extra}"
  fi
}

#######################################
# Simplified command wrapper
#
# Arguments:
#   $1: target path
# Outputs:
#   STDOUT: None
#   STDERR: Command error
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_bsh_run_pushd() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  # shellcheck disable=SC2164
  pushd "$path" >/dev/null
}

#######################################
# Simplified command wrapper
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Command error
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_bsh_run_popd() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2164
  popd >/dev/null
}

#######################################
# Search for the command in well known locations, including user paths
#
# Arguments:
#   $1: command name
#   $@: (optional) list of additional paths where to look on
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: full path detected
#   >0: unable to detect or error
#######################################
function bl64_bsh_command_locate_user() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-}"
  shift
  bl64_bsh_command_locate \
    "$command" \
    "${HOME}/bin" \
    "${HOME}/.local/bin" \
    "${HOME}/node_modules/.bin" \
    "$@"
}

#######################################
# Search for the command in well known system locations
#
# Arguments:
#   $1: command name
#   $@: (optional) list of additional paths where to look on
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: operation completed
#   >0: unable to complete operation
#######################################
function bl64_bsh_command_locate() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-}"
  local search_list=''
  local full_path=''
  local current_path=''

  shift
  bl64_check_parameter 'command' ||
    return $?

  search_list+=' /home/linuxbrew/.linuxbrew/bin'
  search_list+=' /opt/homebrew/bin'
  search_list+=' /usr/local/bin'
  search_list+=' /usr/local/sbin'
  search_list+=' /usr/bin'
  search_list+=' /usr/sbin'
  search_list+=' /bin'
  search_list+=' /sbin'

  for current_path in $search_list "${@:-}"; do
    bl64_lib_var_is_default "$current_path" && continue
    [[ ! -d "$current_path" ]] && continue
    bl64_dbg_lib_show_info "search in: ${current_path}/${command}"
    if [[ -x "${current_path}/${command}" ]]; then
      echo "${current_path}/${command}"
      return 0
    fi
  done
  return 0
}

#######################################
# Locate and show the full path of a command
#
#  * Fail if the command is not found
#  * Output is prepared to be imported as a shell variable value
#
# Arguments:
#   $1: command name
#   $@: (optional) list of additional paths where to look on
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: operation completed
#   >0: unable to complete operation
#######################################
function bl64_bsh_command_import() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-}"
  local command_path=''
  command_path="$(bl64_bsh_command_locate "$@")" || return $?
  if [[ -z "$command_path" ]]; then
    bl64_msg_show_lib_error "Unable to find the required command. Please install it and try again (${command})"
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  else
    echo "$command_path"
  fi
}

#######################################
# Create XDG directories in user's home
#
# Arguments:
#   $1: full path to the user's home directory
#   $2: permissions. Default: 0750
#   $3: user name. Default: current
#   $4: group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: execution errors
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_bsh_xdg_create() {
  bl64_dbg_lib_show_function "$@"
  local home_path="${1:-}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local dir_user="${3:-${BL64_VAR_DEFAULT}}"
  local dir_group="${4:-${BL64_VAR_DEFAULT}}"
  local xdg_config="${home_path}/.config"
  local xdg_cache="${home_path}/.cache"
  local xdg_local="${home_path}/.local"

  bl64_check_parameter 'home_path' ||
    return $?

  bl64_msg_show_lib_task "create user XDG directories (${home_path})"
  bl64_lib_var_is_default "$dir_mode" && dir_mode='0750'
  bl64_fs_dir_create "$dir_mode" "$dir_user" "$dir_group" \
    "$xdg_config" \
    "$xdg_local" \
    "$xdg_cache" \
    "${xdg_local}/bin" \
    "${xdg_local}/lib" \
    "${xdg_local}/share" \
    "${xdg_local}/state"
}

#######################################
# Retry a command until it succeeds or the maximum number of retries is reached
#
# Arguments:
#   $1: maximum number of retries. Default: BL64_BSH_JOB_SET_MAX_RETRIES
#   $2: wait time between retries in seconds. Default: BL64_BSH_JOB_SET_WAIT
#   $@: command to execute
# Outputs:
#   STDOUT: progress
#   STDERR: execution errors
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_bsh_job_try() {
  bl64_dbg_lib_show_function "$@"
  local max_retries="${1:-$BL64_VAR_DEFAULT}"
  local wait_time="${2:-$BL64_VAR_DEFAULT}"
  local job_command="${3:-}"
  local attempt=1

  bl64_check_parameter 'job_command' &&
    bl64_check_parameters_none "$#" || return $?
  [[ "$max_retries" == "$BL64_VAR_DEFAULT" ]] && max_retries="$BL64_BSH_JOB_SET_MAX_RETRIES"
  [[ "$wait_time" == "$BL64_VAR_DEFAULT" ]] && wait_time="$BL64_BSH_JOB_SET_WAIT"

  shift
  shift
  shift
  while :; do
    "$job_command" "$@" && return 0
    ((attempt++))
    if ((attempt > max_retries)); then
      bl64_msg_show_lib_error "command failed after ${max_retries} attempts (${job_command})"
      return 1
    fi
    if ((attempt == 2)); then
      bl64_msg_show_warning "command failed. Retrying in ${wait_time} seconds... (attempt ${attempt}/${max_retries})"
    fi
    sleep "$wait_time"
  done
}

#######################################
# BashLib64 / Module / Setup / Interact with container engines
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: required in order to use the module
# * Check for core commands, fail if not available
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_cnt_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local command_location="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_cnt_set_command "$command_location" &&
    _bl64_cnt_set_options &&
    BL64_CNT_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'cnt'
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_cnt_set_command() {
  bl64_dbg_lib_show_function "$@"
  local command_location="$1"

  _bl64_cnt_set_command_podman "$command_location" &&
    _bl64_cnt_set_command_docker "$command_location" ||
    return $?

  bl64_dbg_lib_show_comments 'detect and set current container driver'
  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    BL64_CNT_DRIVER="$BL64_CNT_DRIVER_DOCKER"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    BL64_CNT_DRIVER="$BL64_CNT_DRIVER_PODMAN"
  else
    bl64_msg_show_lib_error "unable to find a container manager CLI location (${BL64_CNT_CMD_DOCKER}, ${BL64_CNT_CMD_PODMAN})"
    return "$BL64_LIB_ERROR_APP_MISSING"
  fi
  bl64_dbg_lib_show_vars 'BL64_CNT_DRIVER'

  return 0
}

function _bl64_cnt_set_command_docker() {
  bl64_dbg_lib_show_function "$@"
  BL64_CNT_CMD_DOCKER="$(bl64_bsh_command_locate 'docker' "${HOME}/.rd/bin" "$@")"
  return 0
}

function _bl64_cnt_set_command_podman() {
  bl64_dbg_lib_show_function "$@"
  BL64_CNT_CMD_PODMAN="$(bl64_bsh_command_locate 'podman' "$@")"
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
function _bl64_cnt_set_options() {
  bl64_dbg_lib_show_function

  #
  # Standard CLI flags
  #
  # * Common to both podman and docker
  #

  # shellcheck disable=SC2034
  BL64_CNT_SET_DEBUG='--debug' &&
    BL64_CNT_SET_ENTRYPOINT='--entrypoint' &&
    BL64_CNT_SET_FILE='--file' &&
    BL64_CNT_SET_FILTER='--filter' &&
    BL64_CNT_SET_INTERACTIVE='--interactive' &&
    BL64_CNT_SET_LOG_LEVEL='--log-level' &&
    BL64_CNT_SET_NO_CACHE='--no-cache' &&
    BL64_CNT_SET_PASSWORD_STDIN='--password-stdin' &&
    BL64_CNT_SET_PASSWORD='--password' &&
    BL64_CNT_SET_QUIET='--quiet' &&
    BL64_CNT_SET_RM='--rm' &&
    BL64_CNT_SET_TAG='--tag' &&
    BL64_CNT_SET_TTY='--tty' &&
    BL64_CNT_SET_USERNAME='--username' &&
    BL64_CNT_SET_VERSION='version'

  #
  # Common parameter values
  #
  # * Common to both podman and docker
  #

  # shellcheck disable=SC2034
  BL64_CNT_SET_FILTER_ID='{{.ID}}' &&
    BL64_CNT_SET_FILTER_NAME='{{.Names}}' &&
    BL64_CNT_SET_LOG_LEVEL_DEBUG='debug' &&
    BL64_CNT_SET_LOG_LEVEL_ERROR='error' &&
    BL64_CNT_SET_LOG_LEVEL_INFO='info' &&
    BL64_CNT_SET_STATUS_RUNNING='running'

  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with container engines
#######################################

#######################################
# Check if the current process is running inside a container
#
# * detection is best effort and not guaranteed to cover all possible implementations
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: it is
#   BL64_LIB_ERROR_IS_NOT
#######################################
function bl64_cnt_is_inside_container() {
  bl64_dbg_lib_show_function

  _bl64_cnt_find_file_marker '/run/.containerenv' && return 0
  _bl64_cnt_find_file_marker '/run/container_id' && return 0
  _bl64_cnt_find_variable_marker 'container' && return 0
  _bl64_cnt_find_variable_marker 'DOCKER_CONTAINER' && return 0
  _bl64_cnt_find_variable_marker 'KUBERNETES_SERVICE_HOST' && return 0

  return "$BL64_LIB_ERROR_IS_NOT"
}

function _bl64_cnt_find_file_marker() {
  bl64_dbg_lib_show_function "$@"
  local marker="$1"
  bl64_dbg_lib_show_info "check for file marker (${marker})"
  [[ -f "$marker" ]]
}

function _bl64_cnt_find_variable_marker() {
  bl64_dbg_lib_show_function "$@"
  local marker="$1"
  bl64_dbg_lib_show_info "check for variable marker (${marker})"
  [[ -v "$marker" ]]
}

#######################################
# Logins the container engine to a container registry. The password is taken from STDIN
#
# Arguments:
#   $1: user
#   $2: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_login_stdin() {
  bl64_dbg_lib_show_function "$@"
  local user="${1:-}"
  local registry="${2:-}"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'user' &&
    bl64_check_parameter 'registry' ||
    return $?

  bl64_msg_show_lib_subtask "login to container registry (${user}@${registry})"
  "_bl64_cnt_${BL64_CNT_DRIVER}_login" "$user" "$BL64_VAR_DEFAULT" "$BL64_CNT_FLAG_STDIN" "$registry"
}

#######################################
# Logins the container engine to a container registry. The password is stored in a regular file
#
# Arguments:
#   $1: user
#   $2: file
#   $3: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_login_file() {
  bl64_dbg_lib_show_function "$@"
  local user="${1:-}"
  local file="${2:-}"
  local registry="${3:-}"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'user' &&
    bl64_check_parameter 'file' &&
    bl64_check_parameter 'registry' &&
    bl64_check_file "$file" ||
    return $?

  bl64_msg_show_lib_subtask "login to container registry (${user}@${registry})"
  "_bl64_cnt_${BL64_CNT_DRIVER}_login" "$user" "$BL64_VAR_DEFAULT" "$file" "$registry"
}

#######################################
# Logins the container engine to a container. The password is passed as parameter
#
# Arguments:
#   $1: user
#   $2: password
#   $3: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_login() {
  bl64_dbg_lib_show_function "$@"
  local user="${1:-}"
  local password="${2:-}"
  local registry="${3:-}"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'user' &&
    bl64_check_parameter 'password' &&
    bl64_check_parameter 'registry' ||
    return $?

  bl64_msg_show_lib_subtask "login to container registry (${user}@${registry})"
  "_bl64_cnt_${BL64_CNT_DRIVER}_login" "$user" "$password" "$BL64_VAR_DEFAULT" "$registry"
}

#######################################
# Open a container image using sh
#
# * Ignores entrypointt
#
# Arguments:
#   $1: container
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_run_sh() {
  bl64_dbg_lib_show_function "$@"
  local container="$1"

  bl64_check_parameter 'container' || return $?
  # shellcheck disable=SC2086
  bl64_cnt_run_interactive $BL64_CNT_SET_ENTRYPOINT 'sh' "$container"
}

#######################################
# Runs a container image using interactive settings
#
# * Allows signals
# * Attaches tty
#
# Arguments:
#   $@: arguments are passed as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CNT_MODULE' ||
    return $?

  "_bl64_cnt_${BL64_CNT_DRIVER}_run_interactive" "$@"
}

#######################################
# Builds a container source
#
# Arguments:
#   $1: ui context. Format: full path
#   $2: dockerfile path. Format: relative to the build context
#   $3: tag to be applied to the resulting source. Format: docker tag
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_build() {
  bl64_dbg_lib_show_function "$@"
  local context="$1"
  local file="${2:-Dockerfile}"
  local tag="${3:-latest}"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'context' &&
    bl64_check_directory "$context" &&
    bl64_check_file "${context}/${file}" ||
    return $?

  # Remove used parameters
  shift
  shift
  shift

  bl64_msg_show_lib_subtask "build container image (Dockerfile: ${file} ${BL64_MSG_COSMETIC_PIPE} Tag: ${tag})"
  bl64_bsh_run_pushd "${context}" &&
    "_bl64_cnt_${BL64_CNT_DRIVER}_build" "$file" "$tag" "$@" &&
    bl64_bsh_run_popd
}

#######################################
# Push a local source to the target container registry
#
# * Image is already present in the local destination
#
# Arguments:
#   $1: source. Format: IMAGE:TAG
#   $2: destination. Format: REPOSITORY/IMAGE:TAG
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' ||
    return $?

  bl64_msg_show_lib_subtask "push container image to registry (${source} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
  "_bl64_cnt_${BL64_CNT_DRIVER}_push" "$source" "$destination"
}

#######################################
# Pull a remote container image to the local registry
#
# Arguments:
#   $1: source. Format: [REPOSITORY/]IMAGE:TAG
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'source' ||
    return $?

  bl64_msg_show_lib_subtask "pull container image from registry (${source})"
  "_bl64_cnt_${BL64_CNT_DRIVER}_pull" "$source"
}

function _bl64_cnt_login_put_password() {
  bl64_dbg_lib_show_function "$@"
  local password="$1"
  local file="$2"

  if [[ "$password" != "$BL64_VAR_DEFAULT" ]]; then
    printf '%s\n' "$password"
  elif [[ "$file" != "$BL64_VAR_DEFAULT" ]]; then
    "$BL64_OS_CMD_CAT" "$file"
  elif [[ "$file" == "$BL64_CNT_FLAG_STDIN" ]]; then
    "$BL64_OS_CMD_CAT"
  fi
}

#######################################
# Assigns a new name to an existing image
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' ||
    return $?

  bl64_msg_show_lib_subtask "add tag to container image (${source} ${BL64_MSG_COSMETIC_ARROW2} ${target})"
  "_bl64_cnt_${BL64_CNT_DRIVER}_tag" "$source" "$target"
}

#######################################
# Runs a container image
#
# Arguments:
#   $@: arguments are passed as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_run() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CNT_MODULE' ||
    return $?

  "_bl64_cnt_${BL64_CNT_DRIVER}_run" "$@"
}

#######################################
# Runs the container manager CLI
#
# * Function provided as-is to catch cases where there is no wrapper
# * Calling function must make sure that the current driver supports provided arguments
#
# Arguments:
#   $@: arguments are passed as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_cli() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CNT_MODULE' ||
    return $?

  "bl64_cnt_run_${BL64_CNT_DRIVER}" "$@"
}

#######################################
# Determine if the container is running
#
# * Look for one or more instances of the container
# * The container status is Running
# * Filter by one of: name, id
#
# Arguments:
#   $1: name. Exact match
#   $2: id
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: true
#   >0: BL64_LIB_ERROR_IS_NOT or cmd error
#######################################
function bl64_cnt_container_is_running() {
  bl64_dbg_lib_show_function "$@"
  local name="${1:-${BL64_VAR_DEFAULT}}"
  local id="${2:-${BL64_VAR_DEFAULT}}"
  local result=''

  if bl64_lib_var_is_default "$name" && bl64_lib_var_is_default "$id"; then
    bl64_check_alert_parameter_invalid "$BL64_VAR_DEFAULT" "no filter was selected. Task requires one of them (ID, Name)"
    return $?
  fi

  bl64_check_module 'BL64_CNT_MODULE' ||
    return $?

  result="$("_bl64_cnt_${BL64_CNT_DRIVER}_ps_filter" "$name" "$id" "$BL64_CNT_SET_STATUS_RUNNING")" ||
    return $?
  bl64_dbg_lib_show_vars 'result'

  if [[ "$name" != "$BL64_VAR_DEFAULT" ]]; then
    [[ "$result" == "$name" ]] || return "$BL64_LIB_ERROR_IS_NOT"
  elif bl64_lib_var_is_default "$id"; then
    [[ "$result" != "$id" ]] || return "$BL64_LIB_ERROR_IS_NOT"
  fi
}

#######################################
# Determine if the container network is defined
#
# Arguments:
#   $1: network name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: defined
#   >0: BL64_LIB_ERROR_IS_NOT or error
#######################################
function bl64_cnt_network_is_defined() {
  bl64_dbg_lib_show_function "$@"
  local network="$1"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'network' ||
    return $?

  "_bl64_cnt_${BL64_CNT_DRIVER}_network_is_defined" "$network"
}

#######################################
# Create a container network
#
# Arguments:
#   $1: network name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_cnt_network_create() {
  bl64_dbg_lib_show_function "$@"
  local network="$1"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'network' ||
    return $?

  if bl64_cnt_network_is_defined "$network"; then
    bl64_msg_show_lib_info "container network already created. No further action needed (${network})"
    return 0
  fi

  bl64_msg_show_lib_subtask "creating container network (${network})"
  "_bl64_cnt_${BL64_CNT_DRIVER}_network_create" "$network"
}

#
# Docker
#

#######################################
# Command wrapper: docker login
#
# Arguments:
#   $1: user
#   $2: password
#   $3: file
#   $4: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_docker_login() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local password="$2"
  local file="$3"
  local registry="$4"

  # shellcheck disable=SC2086
  _bl64_cnt_login_put_password "$password" "$file" |
    bl64_cnt_run_docker \
      login \
      $BL64_CNT_SET_USERNAME "$user" \
      $BL64_CNT_SET_PASSWORD_STDIN \
      "$registry"
}

#######################################
# Command wrapper: docker run
#
# * Provides verbose and debug support
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
function _bl64_cnt_docker_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" || return $?

  # shellcheck disable=SC2086
  bl64_cnt_run_docker \
    run \
    $BL64_CNT_SET_RM \
    $BL64_CNT_SET_INTERACTIVE \
    $BL64_CNT_SET_TTY \
    "$@"

}

#######################################
# Command wrapper: docker
#
# * Provides debug support
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
function bl64_cnt_run_docker() {
  bl64_dbg_lib_show_function "$@"
  local verbose='error'
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_command "$BL64_CNT_CMD_DOCKER" ||
    return $?

  if bl64_dbg_lib_command_is_enabled; then
    verbose="$BL64_CNT_SET_LOG_LEVEL_DEBUG"
    debug="$BL64_CNT_SET_DEBUG"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_CNT_CMD_DOCKER" \
    $BL64_CNT_SET_LOG_LEVEL "$verbose" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper: docker build
#
# Arguments:
#   $1: file
#   $2: tag
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_docker_build() {
  bl64_dbg_lib_show_function "$@"
  local file="$1"
  local tag="$2"

  # Remove used parameters
  shift
  shift

  # shellcheck disable=SC2086
  bl64_cnt_run_docker \
    build \
    --progress plain \
    $BL64_CNT_SET_TAG "$tag" \
    $BL64_CNT_SET_FILE "$file" \
    "$@" .
}

#######################################
# Command wrapper: docker push
#
# Arguments:
#   $1: source
#   $2: destination
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_docker_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_cnt_run_docker \
    tag \
    "$source" \
    "$destination"

  bl64_cnt_run_docker \
    push \
    "$destination"
}

#######################################
# Command wrapper: docker pull
#
# Arguments:
#   $1: source
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_docker_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_cnt_run_docker \
    pull \
    "${source}"
}

#######################################
# Command wrapper: docker tag
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_docker_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_cnt_run_docker \
    tag \
    "$source" \
    "$target"
}

#######################################
# Command wrapper: docker run
#
# * Provides verbose and debug support
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
function _bl64_cnt_docker_run() {
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_cnt_run_docker \
    run \
    "$@"

}

#######################################
# Command wrapper: detect network
#
# Arguments:
#   $1: network name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: defined
#   >0: BL64_LIB_ERROR_IS_NOT or error
#######################################
function _bl64_cnt_docker_network_is_defined() {
  bl64_dbg_lib_show_function "$@"
  local network="$1"
  local network_id=''

  network_id="$(
    bl64_cnt_run_docker \
      network ls \
      "$BL64_CNT_SET_QUIET" \
      "$BL64_CNT_SET_FILTER" "name=${network}"
  )"

  bl64_dbg_lib_show_info "check if the network is defined ([${network}] == [${network_id}])"
  [[ -n "$network_id" ]] || return "$BL64_LIB_ERROR_IS_NOT"
}

#######################################
# Command wrapper: create network
#
# Arguments:
#   $1: network name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_docker_network_create() {
  bl64_dbg_lib_show_function "$@"
  local network="$1"

  bl64_cnt_run_docker \
    network create \
    "$network"
}

#######################################
# Command wrapper: ps with filters
#
# Arguments:
#   $1: name
#   $2: id
#   $3: status
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_docker_ps_filter() {
  bl64_dbg_lib_show_function "$@"
  local name="$1"
  local id="$2"
  local status="$3"
  local format=''
  local filter=''

  if [[ "$name" != "$BL64_VAR_DEFAULT" ]]; then
    filter="$BL64_CNT_SET_FILTER name=${name}"
    format="$BL64_CNT_SET_FILTER_NAME"
  elif [[ "$id" != "$BL64_VAR_DEFAULT" ]]; then
    filter="$BL64_CNT_SET_FILTER id=${id}"
    format="$BL64_CNT_SET_FILTER_ID"
  fi
  [[ "$status" != "$BL64_VAR_DEFAULT" ]] && filter_status="$BL64_CNT_SET_FILTER status=${status}"

  # shellcheck disable=SC2086
  bl64_cnt_run_docker \
    ps \
    ${filter} ${filter_status} --format "$format"
}

#
# Podman
#

#######################################
# Command wrapper: podman login
#
# Arguments:
#   $1: user
#   $2: password
#   $3: file
#   $4: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_podman_login() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local password="$2"
  local file="$3"
  local registry="$4"

  # shellcheck disable=SC2086
  _bl64_cnt_login_put_password "$password" "$file" |
    bl64_cnt_run_podman \
      login \
      $BL64_CNT_SET_USERNAME "$user" \
      $BL64_CNT_SET_PASSWORD_STDIN \
      "$registry"
}

#######################################
# Command wrapper: podman run
#
# * Provides verbose and debug support
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
function _bl64_cnt_podman_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" || return $?

  # shellcheck disable=SC2086
  bl64_cnt_run_podman \
    run \
    $BL64_CNT_SET_RM \
    $BL64_CNT_SET_INTERACTIVE \
    $BL64_CNT_SET_TTY \
    "$@"
}

#######################################
# Command wrapper: podman
#
# * Provides debug support
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
function bl64_cnt_run_podman() {
  bl64_dbg_lib_show_function "$@"
  local verbose='error'

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_command "$BL64_CNT_CMD_PODMAN" ||
    return $?

  bl64_dbg_lib_command_is_enabled && verbose="$BL64_CNT_SET_LOG_LEVEL_DEBUG"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_CNT_CMD_PODMAN" \
    $BL64_CNT_SET_LOG_LEVEL "$verbose" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper: podman build
#
# Arguments:
#   $1: file
#   $2: tag
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_podman_build() {
  bl64_dbg_lib_show_function "$@"
  local file="$1"
  local tag="$2"

  # Remove used parameters
  shift
  shift

  # shellcheck disable=SC2086
  bl64_cnt_run_podman \
    build \
    $BL64_CNT_SET_TAG "$tag" \
    $BL64_CNT_SET_FILE "$file" \
    "$@" .
}

#######################################
# Command wrapper: podman push
#
# Arguments:
#   $1: source
#   $2: destination
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_podman_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_cnt_run_podman \
    push \
    "localhost/${source}" \
    "$destination"
}

#######################################
# Command wrapper: podman pull
#
# Arguments:
#   $1: source
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_podman_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_cnt_run_podman \
    pull \
    "${source}"
}

#######################################
# Command wrapper: podman tag
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_cnt_podman_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_cnt_run_podman \
    tag \
    "$source" \
    "$target"
}

#######################################
# Command wrapper: podman run
#
# * Provides verbose and debug support
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
function _bl64_cnt_podman_run() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_podman \
    run \
    "$@"
}

#######################################
# Command wrapper: detect network
#
# Arguments:
#   $1: network name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: defined
#   >0: BL64_LIB_ERROR_IS_NOT or error
#######################################
function _bl64_cnt_podman_network_is_defined() {
  bl64_dbg_lib_show_function "$@"
  local network="$1"
  local network_id=''

  network_id="$(
    bl64_cnt_run_podman \
      network ls \
      "$BL64_CNT_SET_QUIET" \
      "$BL64_CNT_SET_FILTER" "name=${network}"
  )"

  bl64_dbg_lib_show_info "check if the network is defined ([${network}] == [${network_id}])"
  [[ -n "$network_id" ]] || return "$BL64_LIB_ERROR_IS_NOT"
}

#######################################
# Command wrapper: create network
#
# Arguments:
#   $1: network name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: defined
#   >0: not defined or error
#######################################
function _bl64_cnt_podman_network_create() {
  bl64_dbg_lib_show_function "$@"
  local network="$1"

  bl64_cnt_run_podman \
    network create \
    "$network"
}

#######################################
# Command wrapper: ps with filters
#
# Arguments:
#   $1: name
#   $2: id
#   $3: status
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: defined
#   >0: not defined or error
#######################################
function _bl64_cnt_podman_ps_filter() {
  bl64_dbg_lib_show_function "$@"
  local name="$1"
  local id="$2"
  local status="$3"
  local format=''
  local filter=''

  if [[ "$name" != "$BL64_VAR_DEFAULT" ]]; then
    filter="$BL64_CNT_SET_FILTER name=${name}"
    format='{{.NAME}}'
  elif [[ "$id" != "$BL64_VAR_DEFAULT" ]]; then
    filter="$BL64_CNT_SET_FILTER id=${id}"
    format="$BL64_CNT_SET_FILTER_ID"
  fi
  [[ "$status" != "$BL64_VAR_DEFAULT" ]] && filter_status="$BL64_CNT_SET_FILTER status=${status}"

  # shellcheck disable=SC2086
  bl64_cnt_run_podman \
    ps \
    ${filter} ${filter_status} --format "$format"
}

#######################################
# Check that the script is running inside a container
#
# Arguments:
#   None
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_TASK_REQUIREMENTS
#######################################
function bl64_cnt_check_in_container() {
  bl64_dbg_lib_show_function
  bl64_cnt_is_inside_container && return 0
  bl64_msg_show_check 'current task must be run inside a container'
  return "$BL64_LIB_ERROR_TASK_REQUIREMENTS"
}

#######################################
# Check that the script is not running inside a container
#
# Arguments:
#   None
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_TASK_REQUIREMENTS
#######################################
function bl64_cnt_check_not_in_container() {
  bl64_dbg_lib_show_function
  bl64_cnt_is_inside_container || return 0
  bl64_msg_show_check 'current task must not be run inside a container'
  return "$BL64_LIB_ERROR_TASK_REQUIREMENTS"
}

#######################################
# BashLib64 / Module / Setup / Cryptography tools
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_cryp_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_RXTX_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_cryp_set_command &&
    BL64_CRYP_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'cryp'
}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_cryp_set_command() {
  BL64_CRYP_CMD_MD5SUM="$(bl64_bsh_command_locate 'md5sum')"
  BL64_CRYP_CMD_SHA256SUM="$(bl64_bsh_command_locate 'sha256sum')"
  BL64_CRYP_CMD_GPG="$(bl64_bsh_command_locate 'gpg')"
  BL64_CRYP_CMD_OPENSSL="$(bl64_bsh_command_locate 'openssl')"
}

#######################################
# BashLib64 / Module / Functions / Cryptography tools
#######################################

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_gpg() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=''

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_GPG" || return $?

  bl64_msg_app_detail_is_enabled && verbosity='--verbose'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_CRYP_CMD_GPG" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_openssl() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_OPENSSL" || return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_CRYP_CMD_OPENSSL" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_md5sum() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_MD5SUM" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_CRYP_CMD_MD5SUM" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_cryp_run_sha256sum() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CRYP_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_CRYP_CMD_SHA256SUM" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_CRYP_CMD_SHA256SUM" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Determine if the GPG key file is armored or not
#
# * File is not checked to be a valid key
# * File is considered dearmored if the string is present
#
# Arguments:
#   $1: GPG key file path
# Outputs:
#   STDOUT: none
#   STDERR: command stderr
# Returns:
#   0: file is armored
#   BL64_LIB_ERROR_IS_NOT
#   >0: operation failed
#######################################
function bl64_cryp_gpg_key_is_armored() {
  bl64_dbg_lib_show_function "$@"
  local key_file="$1"

  bl64_check_file "$key_file" ||
    return $?

  # shellcheck disable=SC2086
  bl64_txt_run_grep \
    $BL64_TXT_SET_GREP_QUIET \
    'BEGIN PGP PUBLIC KEY BLOCK' \
    "$key_file" || return "$BL64_LIB_ERROR_IS_NOT"
}

#######################################
# Export (armor) GPG key
#
# * Use --armor option to create base64 distributable file
#
# Arguments:
#   $1: source GPG key file path
#   $2: (optional) destination GPG key file path. If not declared, use source + '.asc'
#   $3: file permissions. Format: chown format. Default: use current umask
#   $4: file user name. Default: current
#   $5: file group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: command stderr
# Returns:
#   0: file is armored
#   BL64_LIB_ERROR_IS_NOT
#   >0: operation failed
#######################################
function bl64_cryp_gpg_key_armor() {
  bl64_dbg_lib_show_function "$@"
  local source_key_file="$1"
  local target_key_file="${2:-${source_key_file}.asc}"
  local file_mode="${3:-${BL64_VAR_DEFAULT}}"
  local file_user="${4:-${BL64_VAR_DEFAULT}}"
  local file_group="${5:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'source_key_file' &&
    bl64_check_file "$source_key_file" ||
    return $?

  bl64_msg_show_lib_subtask "export GPG key file and prepare for distribution (${source_key_file})"
  bl64_cryp_run_gpg \
    --export \
    --armor \
    --output "$target_key_file" \
    "$source_key_file" ||
    return $?

  if [[ -f "$target_key_file" ]]; then
    bl64_fs_path_permission_set "$file_mode" "$BL64_VAR_DEFAULT" "$file_user" "$file_group" "$BL64_VAR_OFF" \
      "$target_key_file"
  fi
}

#######################################
# Dearmor GPG key
#
# * Use --dearmor option to convert base64 distributable file
#
# Arguments:
#   $1: source GPG key file path
#   $2: destination GPG key file path. If not provided replace source
#   $3: file permissions. Format: chown format. Default: use current umask
#   $4: file user name. Default: current
#   $5: file group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: command stderr
# Returns:
#   0: file is armored
#   BL64_LIB_ERROR_IS_NOT
#   >0: operation failed
#######################################
function bl64_cryp_gpg_key_dearmor() {
  bl64_dbg_lib_show_function "$@"
  local source_key_file="$1"
  local target_key_file="${2:-}"
  local file_mode="${3:-${BL64_VAR_DEFAULT}}"
  local file_user="${4:-${BL64_VAR_DEFAULT}}"
  local file_group="${5:-${BL64_VAR_DEFAULT}}"
  local -i replace=0

  bl64_check_parameter 'source_key_file' &&
    bl64_check_file "$source_key_file" ||
    return $?

  if [[ -z "$target_key_file" ]]; then
    bl64_dbg_lib_show_info 'requested to replace existing key'
    target_key_file="${source_key_file}.tmp" &&
      replace=1
  fi

  bl64_msg_show_lib_subtask "dearmor exported GPG key file (${source_key_file})"
  bl64_cryp_run_gpg \
    --dearmor \
    --output "$target_key_file" \
    "$source_key_file" ||
    return $?

  if ((replace == 1)); then
    bl64_dbg_lib_show_info "replacing key (${target_key_file} -> ${source_key_file})"
    "$BL64_OS_CMD_CAT" "$target_key_file" >"$source_key_file" &&
      bl64_fs_file_remove "$target_key_file"
  else
    bl64_fs_path_permission_set "$file_mode" "$BL64_VAR_DEFAULT" "$file_user" "$file_group" "$BL64_VAR_OFF" "$target_key_file"
  fi
}

#######################################
# Download GPG key
#
# * If the key is armored, dearmor it
#
# Arguments:
#   $1: source GPG key URL
#   $2: destination GPG key file path. If not provided replace source
#   $3: replace existing file. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $4: file permissions. Format: chown format. Default: use current umask
#   $5: file user name. Default: current
#   $6: file group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: command stderr
# Returns:
#   0: file is armored
#   BL64_LIB_ERROR_IS_NOT
#   >0: operation failed
#######################################
function bl64_cryp_key_download() {
  bl64_dbg_lib_show_function "$@"
  local source_url="$1"
  local target_key_file="${2:-}"
  local replace="${3:-${BL64_VAR_DEFAULT}}"
  local file_mode="${4:-${BL64_VAR_DEFAULT}}"
  local file_user="${5:-${BL64_VAR_DEFAULT}}"
  local file_group="${6:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'source_url' &&
    bl64_check_parameter 'target_key_file' &&
    bl64_check_module 'BL64_RXTX_MODULE' ||
    return $?

  bl64_rxtx_web_get_file \
    "$source_url" \
    "$target_key_file" \
    "$replace" \
    "$file_mode" \
    "$file_user" \
    "$file_group" ||
    return $?

  if bl64_cryp_gpg_key_is_armored "$target_key_file"; then
    bl64_cryp_gpg_key_dearmor "$target_key_file"
  fi
}

#######################################
# BashLib64 / Module / Setup / Format text data
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_fmt_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    BL64_FMT_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'fmt'
}

#######################################
# BashLib64 / Module / Functions / Format text data
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_fmt_strip_starting_slash() {
  bl64_msg_show_deprecated 'bl64_fmt_strip_starting_slash' 'bl64_fmt_path_strip_starting_slash'
  bl64_fmt_path_strip_starting_slash "$@"
}

function bl64_fmt_strip_ending_slash() {
  bl64_msg_show_deprecated 'bl64_fmt_strip_ending_slash' 'bl64_fmt_path_strip_ending_slash'
  bl64_fmt_path_strip_ending_slash "$@"
}

function bl64_fmt_basename() {
  bl64_msg_show_deprecated 'bl64_fmt_basename' 'bl64_fmt_path_get_basename'
  bl64_fmt_path_get_basename "$@"
}

function bl64_fmt_dirname() {
  bl64_msg_show_deprecated 'bl64_fmt_dirname' 'bl64_fmt_path_get_dirname'
  bl64_fmt_path_get_dirname "$@"
}

function bl64_fmt_list_to_string() {
  bl64_msg_show_deprecated 'bl64_fmt_list_to_string' 'bl64_fmt_list_convert_to_string'
  bl64_fmt_list_convert_to_string "$@"
}

function bl64_fmt_separator_line() {
  bl64_msg_show_deprecated 'bl64_fmt_separator_line' 'bl64_ui_separator_show'
  bl64_ui_separator_show "$@"
}

function bl64_fmt_check_value_in_list() {
  bl64_msg_show_deprecated 'bl64_fmt_check_value_in_list' 'bl64_fmt_list_check_membership'
  bl64_fmt_list_check_membership "$@"
}

#
# Private functions
#

#
# Public functions
#

#######################################
# Removes starting slash from path
#
# * If path is a single slash or relative path no change is done
#
# Arguments:
#   $1: Target path
# Outputs:
#   STDOUT: Updated path
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_path_strip_starting_slash() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return 0
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == /* ]]; then
    printf '%s' "${path:1}"
  else
    printf '%s' "${path}"
  fi
}

#######################################
# Removes ending slash from path
#
# * If path is a single slash or no ending slash is present no change is done
#
# Arguments:
#   $1: Target path
# Outputs:
#   STDOUT: Updated path
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_path_strip_ending_slash() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return 0
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == */ ]]; then
    printf '%s' "${path:0:-1}"
  else
    printf '%s' "${path}"
  fi
}

#######################################
# Show the last part (basename) of a path
#
# * The function operates on text data, it doesn't verify path existance
# * The last part can be either a directory or a file
# * Parts are separated by the / character
# * The basename is defined by taking the text to the right of the last separator
# * Function mimics the linux basename command
#
# Examples:
#
#   bl64_fmt_path_get_basename '/full/path/to/file' -> 'file'
#   bl64_fmt_path_get_basename '/full/path/to/file/' -> ''
#   bl64_fmt_path_get_basename 'path/to/file' -> 'file'
#   bl64_fmt_path_get_basename 'path/to/file/' -> ''
#   bl64_fmt_path_get_basename '/file' -> 'file'
#   bl64_fmt_path_get_basename '/' -> ''
#   bl64_fmt_path_get_basename 'file' -> 'file'
#
# Arguments:
#   $1: Path
# Outputs:
#   STDOUT: Basename
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_path_get_basename() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"
  local base=''

  if [[ -n "$path" && "$path" != '/' ]]; then
    base="${path##*/}"
  fi

  if [[ -z "$base" || "$base" == */* ]]; then
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_PARAMETER_INVALID"
  else
    printf '%s' "$base"
  fi
  return 0
}

#######################################
# Show the directory part of a path
#
# * The function operates on text data, it doesn't verify path existance
# * Parts are separated by the slash (/) character
# * The directory is defined by taking the input string up to the last separator
#
# Examples:
#
#   bl64_fmt_path_get_dirname '/full/path/to/file' -> '/full/path/to'
#   bl64_fmt_path_get_dirname '/full/path/to/file/' -> '/full/path/to/file'
#   bl64_fmt_path_get_dirname '/file' -> '/'
#   bl64_fmt_path_get_dirname '/' -> '/'
#   bl64_fmt_path_get_dirname 'dir' -> 'dir'
#
# Arguments:
#   $1: Path
# Outputs:
#   STDOUT: Dirname
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_path_get_dirname() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return 0
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" != */* ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == /*/* ]]; then
    printf '%s' "${path%/*}"
  elif [[ "$path" == */*/* ]]; then
    printf '%s' "${path%/*}"
  elif [[ "$path" == /* && "${path:1}" != */* ]]; then
    printf '%s' '/'
  fi
}

#######################################
# Convert list to string. Optionally add prefix, postfix to each field
#
# * list: lines separated by \n
# * string: same as original list but with \n replaced with space
#
# Arguments:
#   $1: output field separator. Default: space
#   $2: prefix. Format: string
#   $3: postfix. Format: string
# Inputs:
#   STDIN: list
# Outputs:
#   STDOUT: string
#   STDERR: None
# Returns:
#   always ok
#######################################
function bl64_fmt_list_convert_to_string() {
  bl64_dbg_lib_show_function
  local field_separator="${1:-${BL64_VAR_DEFAULT}}"
  local prefix="${2:-${BL64_VAR_DEFAULT}}"
  local postfix="${3:-${BL64_VAR_DEFAULT}}"

  bl64_lib_var_is_default "$field_separator" && field_separator=' '
  bl64_lib_var_is_default "$prefix" && prefix=''
  bl64_lib_var_is_default "$postfix" && postfix=''

  bl64_txt_run_awk \
    -v field_separator="$field_separator" \
    -v prefix="$prefix" \
    -v postfix="$postfix" \
    '
    BEGIN {
      joined_string = ""
      RS="\n"
    }
    {
      joined_string = ( joined_string == "" ? "" : joined_string field_separator ) prefix $0 postfix
    }
    END { print joined_string }
  '
}

#######################################
# Check that the value is part of a list
#
# Arguments:
#   $1: (optional) error message
#   $2: value that will be verified
#   $@: list of one or more values to check against
# Outputs:
#   STDOUT: none
#   STDERR: error message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_CHECK_FAILED
#######################################
function bl64_fmt_list_check_membership() {
  bl64_dbg_lib_show_function "$@"
  local error_message="${1:-$BL64_VAR_DEFAULT}"
  local target_value="${2:-}"
  local valid_value=''
  local -i is_valid=$BL64_LIB_ERROR_CHECK_FAILED

  shift
  shift
  bl64_check_parameter 'target_value' &&
    bl64_check_parameters_none $# 'please provide at least one value to check against' ||
    return $?
  bl64_lib_var_is_default "$error_message" && error_message='invalid value'

  for valid_value in "$@"; do
    [[ "$target_value" == "$valid_value" ]] &&
      is_valid=0 &&
      break
  done
  ((is_valid != 0)) &&
    bl64_msg_show_check "${error_message}. Value must be one of: [${*}]"

  return "$is_valid"
}

#######################################
# Determine if the version is in semver format
#
# Arguments:
#   $1: Version
# Outputs:
#   STDOUT: none
#   STDERR: error message
# Returns:
#   0: Yes
#   >0: No
#######################################
function bl64_fmt_version_is_semver() {
  bl64_dbg_lib_show_function "$@"
  local version="$1"
  local version_pattern_semver='^[0-9]+\.[0-9]+\.[0-9]+$'
  [[ "$version" =~ $version_pattern_semver ]]
}

#######################################
# Determine if the version is in major.minor format
#
# Arguments:
#   $1: Version
# Outputs:
#   STDOUT: none
#   STDERR: error message
# Returns:
#   0: Yes
#   >0: No
#######################################
function bl64_fmt_version_is_major_minor() {
  bl64_dbg_lib_show_function "$@"
  local version="$1"
  local version_pattern='^[0-9]+\.[0-9]+$'
  [[ "$version" =~ $version_pattern ]]
}

#######################################
# Determine if the version is in major format
#
# Arguments:
#   $1: Version
# Outputs:
#   STDOUT: none
#   STDERR: error message
# Returns:
#   0: Yes
#   >0: No
#######################################
function bl64_fmt_version_is_major() {
  bl64_dbg_lib_show_function "$@"
  local version="$1"
  local version_pattern='^[0-9]+$'
  [[ "$version" =~ $version_pattern ]]
}

#######################################
# Convert a version to major.minor
#
# Arguments:
#   $1: Version
# Outputs:
#   STDOUT: Major.Minor
#   STDERR: error message
# Returns:
#   0: Converted
#   >0: Failed
#######################################
function bl64_fmt_version_convert_to_major_minor() {
  bl64_dbg_lib_show_function "$@"
  local version="$1"
  local version_pattern_single='^[0-9]+$'
  local version_pattern_major_minor='^[0-9]+\.[0-9]+$'
  local version_pattern_semver='^[0-9]+\.[0-9]+\.[0-9]+$'
  local version_normalized=''

  bl64_check_parameter 'version' || return $?
  if [[ "$version" =~ $version_pattern_single ]]; then
    version_normalized="${version}.0"
  elif [[ "$version" =~ $version_pattern_major_minor ]]; then
    version_normalized="${version}"
  elif [[ "$version" =~ $version_pattern_semver ]]; then
    version_normalized="${version%.*}"
  else
    version_normalized="$version"
  fi
  bl64_dbg_lib_show_vars 'version' 'version_normalized'

  if [[ "$version_normalized" =~ $version_pattern_major_minor ]]; then
    echo "$version_normalized"
    return 0
  fi
  bl64_msg_show_lib_error "unable to convert version to major.minor (${version})"
  return "$BL64_LIB_ERROR_TASK_FAILED"
}

#######################################
# Check that the version is in semver format
#
# Arguments:
#   $1: version string
# Outputs:
#   STDOUT: none
#   STDERR: error message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_CHECK_FAILED
#######################################
function bl64_fmt_version_check_semver_format() {
  bl64_dbg_lib_show_function "$@"
  local version="${1:-}"

  bl64_check_parameter 'version' ||
    return $?

  if bl64_fmt_version_is_semver "$version"; then
    return 0
  else
    bl64_msg_show_check "the version must be in semver format (${version})"
    # shellcheck disable=SC2086
    return "$BL64_LIB_ERROR_CHECK_FAILED"
  fi
}

#######################################
# Compares two semantic versions (A and B) and returns true if A is less than B.
#
# Arguments:
#   $1: SemVer A
#   $2: SemVer B
# Outputs:
#   STDOUT: none
#   STDERR: error message
# Returns:
#   0: If version_a is less than version_b.
#   1: If version_a is greater than or equal to version_b.
#######################################
function bl64_fmt_version_is_less_than() {
  bl64_dbg_lib_show_function "$@"
  local version_a="$1"
  local version_b="$2"
  local -a a_parts
  local -a b_parts

  bl64_fmt_version_check_semver_format "$version_a" &&
    bl64_fmt_version_check_semver_format "$version_b" ||
    return $?

  if [[ "$version_a" == "$version_b" ]]; then
    bl64_dbg_lib_show_info 'versions are equal'
    return 1
  fi

  IFS='.'
  # shellcheck disable=SC2206
  a_parts=($version_a) &&
    b_parts=($version_b)
  unset IFS

  for i in {0..2}; do
    a_part=${a_parts[i]:-0}
    b_part=${b_parts[i]:-0}

    if ((a_part < b_part)); then
      bl64_dbg_lib_show_info "versions is less than (${a_part} < ${b_part})"
      return 0
    fi
    if ((a_part > b_part)); then
      bl64_dbg_lib_show_info "versions is greater than (${a_part} < ${b_part})"
      return 1
    fi
  done

  bl64_dbg_lib_show_info "versions is greater than (${a_part} < ${b_part})"
  return 1
}

function bl64_fmt_version_is_less_than_or_equal() {
  bl64_dbg_lib_show_function "$@"
  local version_a="$1"
  local version_b="$2"
  if [[ "$version_a" == "$version_b" ]]; then
    bl64_dbg_lib_show_info 'versions are equal'
    return 0
  fi
  bl64_fmt_version_is_less_than "$version_a" "$version_b"
}

#######################################
# BashLib64 / Module / Setup / Manage local filesystem
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_fs_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_fs_set_command &&
    _bl64_fs_set_alias &&
    _bl64_fs_set_options &&
    BL64_FS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'fs'
}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_fs_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      BL64_FS_CMD_CHMOD='/bin/chmod'
      BL64_FS_CMD_CHOWN='/bin/chown'
      BL64_FS_CMD_CP='/bin/cp'
      BL64_FS_CMD_FIND='/usr/bin/find'
      BL64_FS_CMD_LN='/bin/ln'
      BL64_FS_CMD_LS='/bin/ls'
      BL64_FS_CMD_MKDIR='/bin/mkdir'
      BL64_FS_CMD_MKTEMP='/bin/mktemp'
      BL64_FS_CMD_MV='/bin/mv'
      BL64_FS_CMD_RM='/bin/rm'
      BL64_FS_CMD_TOUCH='/usr/bin/touch'
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      BL64_FS_CMD_CHMOD='/usr/bin/chmod'
      BL64_FS_CMD_CHOWN='/usr/bin/chown'
      BL64_FS_CMD_CP='/usr/bin/cp'
      BL64_FS_CMD_FIND='/usr/bin/find'
      BL64_FS_CMD_LN='/bin/ln'
      BL64_FS_CMD_LS='/usr/bin/ls'
      BL64_FS_CMD_MKDIR='/usr/bin/mkdir'
      BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
      BL64_FS_CMD_MV='/usr/bin/mv'
      BL64_FS_CMD_RM='/usr/bin/rm'
      BL64_FS_CMD_TOUCH='/usr/bin/touch'
      ;;
    ${BL64_OS_SLES}-*)
      BL64_FS_CMD_CHMOD='/usr/bin/chmod'
      BL64_FS_CMD_CHOWN='/usr/bin/chown'
      BL64_FS_CMD_CP='/usr/bin/cp'
      BL64_FS_CMD_FIND='/usr/bin/find'
      BL64_FS_CMD_LN='/usr/bin/ln'
      BL64_FS_CMD_LS='/usr/bin/ls'
      BL64_FS_CMD_MKDIR='/usr/bin/mkdir'
      BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
      BL64_FS_CMD_MV='/usr/bin/mv'
      BL64_FS_CMD_RM='/usr/bin/rm'
      BL64_FS_CMD_TOUCH='/usr/bin/touch'
      ;;
    ${BL64_OS_ALP}-*)
      BL64_FS_CMD_CHMOD='/bin/chmod'
      BL64_FS_CMD_CHOWN='/bin/chown'
      BL64_FS_CMD_CP='/bin/cp'
      BL64_FS_CMD_FIND='/usr/bin/find'
      BL64_FS_CMD_LN='/bin/ln'
      BL64_FS_CMD_LS='/bin/ls'
      BL64_FS_CMD_MKDIR='/bin/mkdir'
      BL64_FS_CMD_MKTEMP='/bin/mktemp'
      BL64_FS_CMD_MV='/bin/mv'
      BL64_FS_CMD_RM='/bin/rm'
      BL64_FS_CMD_TOUCH='/bin/touch'
      ;;
    ${BL64_OS_ARC}-*)
      BL64_FS_CMD_CHMOD='/usr/bin/chmod'
      BL64_FS_CMD_CHOWN='/usr/bin/chown'
      BL64_FS_CMD_CP='/usr/bin/cp'
      BL64_FS_CMD_FIND='/usr/bin/find'
      BL64_FS_CMD_LN='/usr/bin/ln'
      BL64_FS_CMD_LS='/usr/bin/ls'
      BL64_FS_CMD_MKDIR='/usr/bin/mkdir'
      BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
      BL64_FS_CMD_MV='/usr/bin/mv'
      BL64_FS_CMD_RM='/usr/bin/rm'
      BL64_FS_CMD_TOUCH='/usr/bin/touch'
      ;;
    ${BL64_OS_MCOS}-*)
      BL64_FS_CMD_CHMOD='/bin/chmod'
      BL64_FS_CMD_CHOWN='/usr/sbin/chown'
      BL64_FS_CMD_CP='/bin/cp'
      BL64_FS_CMD_FIND='/usr/bin/find'
      BL64_FS_CMD_LN='/bin/ln'
      BL64_FS_CMD_LS='/bin/ls'
      BL64_FS_CMD_MKDIR='/bin/mkdir'
      BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
      BL64_FS_CMD_MV='/bin/mv'
      BL64_FS_CMD_RM='/bin/rm'
      BL64_FS_CMD_TOUCH='/usr/bin/touch'
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
# * BL64_FS_SET_MKTEMP_TMPDIR: not using long form (--) as it requires =
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_fs_set_options() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
      BL64_FS_SET_CHMOD_VERBOSE='--verbose'
      BL64_FS_SET_CHMOD_SYMLINK='-h'
      BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
      BL64_FS_SET_CHOWN_VERBOSE='--verbose'
      BL64_FS_SET_CP_DEREFERENCE='--dereference'
      BL64_FS_SET_CP_FORCE='--force'
      BL64_FS_SET_CP_RECURSIVE='--recursive'
      BL64_FS_SET_CP_VERBOSE='--verbose'
      BL64_FS_SET_FIND_NAME='-name'
      BL64_FS_SET_FIND_PRINT='-print'
      BL64_FS_SET_FIND_RUN='-exec'
      BL64_FS_SET_FIND_STAY='-xdev'
      BL64_FS_SET_FIND_TYPE_DIR='-type d'
      BL64_FS_SET_FIND_TYPE_FILE='-type f'
      BL64_FS_SET_LN_FORCE='--force'
      BL64_FS_SET_LN_SYMBOLIC='--symbolic'
      BL64_FS_SET_LN_VERBOSE='--verbose'
      BL64_FS_SET_LS_NOCOLOR='--color=never'
      BL64_FS_SET_MKDIR_PARENTS='--parents'
      BL64_FS_SET_MKDIR_VERBOSE='--verbose'
      BL64_FS_SET_MKTEMP_DIRECTORY='--directory'
      BL64_FS_SET_MKTEMP_QUIET='--quiet'
      BL64_FS_SET_MKTEMP_TMPDIR='-p'
      BL64_FS_SET_MV_FORCE='--force'
      BL64_FS_SET_MV_VERBOSE='--verbose'
      BL64_FS_SET_RM_FORCE='--force'
      BL64_FS_SET_RM_RECURSIVE='--recursive'
      BL64_FS_SET_RM_VERBOSE='--verbose'
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
      BL64_FS_SET_CHMOD_VERBOSE='--verbose'
      BL64_FS_SET_CHMOD_SYMLINK='-h'
      BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
      BL64_FS_SET_CHOWN_VERBOSE='--verbose'
      BL64_FS_SET_CP_DEREFERENCE='--dereference'
      BL64_FS_SET_CP_FORCE='--force'
      BL64_FS_SET_CP_RECURSIVE='--recursive'
      BL64_FS_SET_CP_VERBOSE='--verbose'
      BL64_FS_SET_FIND_NAME='-name'
      BL64_FS_SET_FIND_PRINT='-print'
      BL64_FS_SET_FIND_RUN='-exec'
      BL64_FS_SET_FIND_STAY='-xdev'
      BL64_FS_SET_FIND_TYPE_DIR='-type d'
      BL64_FS_SET_FIND_TYPE_FILE='-type f'
      BL64_FS_SET_LN_FORCE='--force'
      BL64_FS_SET_LN_SYMBOLIC='--symbolic'
      BL64_FS_SET_LN_VERBOSE='--verbose'
      BL64_FS_SET_LS_NOCOLOR='--color=never'
      BL64_FS_SET_MKDIR_PARENTS='--parents'
      BL64_FS_SET_MKDIR_VERBOSE='--verbose'
      BL64_FS_SET_MKTEMP_DIRECTORY='--directory'
      BL64_FS_SET_MKTEMP_QUIET='--quiet'
      BL64_FS_SET_MKTEMP_TMPDIR='-p'
      BL64_FS_SET_MV_FORCE='--force'
      BL64_FS_SET_MV_VERBOSE='--verbose'
      BL64_FS_SET_RM_FORCE='--force'
      BL64_FS_SET_RM_RECURSIVE='--recursive'
      BL64_FS_SET_RM_VERBOSE='--verbose'
      ;;
    ${BL64_OS_SLES}-*)
      BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
      BL64_FS_SET_CHMOD_VERBOSE='--verbose'
      BL64_FS_SET_CHMOD_SYMLINK='-h'
      BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
      BL64_FS_SET_CHOWN_VERBOSE='--verbose'
      BL64_FS_SET_CP_DEREFERENCE='--dereference'
      BL64_FS_SET_CP_FORCE='--force'
      BL64_FS_SET_CP_RECURSIVE='--recursive'
      BL64_FS_SET_CP_VERBOSE='--verbose'
      BL64_FS_SET_FIND_NAME='-name'
      BL64_FS_SET_FIND_PRINT='-print'
      BL64_FS_SET_FIND_RUN='-exec'
      BL64_FS_SET_FIND_STAY='-xdev'
      BL64_FS_SET_FIND_TYPE_DIR='-type d'
      BL64_FS_SET_FIND_TYPE_FILE='-type f'
      BL64_FS_SET_LN_FORCE='--force'
      BL64_FS_SET_LN_SYMBOLIC='--symbolic'
      BL64_FS_SET_LN_VERBOSE='--verbose'
      BL64_FS_SET_LS_NOCOLOR='--color=never'
      BL64_FS_SET_MKDIR_PARENTS='--parents'
      BL64_FS_SET_MKDIR_VERBOSE='--verbose'
      BL64_FS_SET_MKTEMP_DIRECTORY='--directory'
      BL64_FS_SET_MKTEMP_QUIET='--quiet'
      BL64_FS_SET_MKTEMP_TMPDIR='-p'
      BL64_FS_SET_MV_FORCE='--force'
      BL64_FS_SET_MV_VERBOSE='--verbose'
      BL64_FS_SET_RM_FORCE='--force'
      BL64_FS_SET_RM_RECURSIVE='--recursive'
      BL64_FS_SET_RM_VERBOSE='--verbose'
      ;;
    ${BL64_OS_ALP}-*)
      BL64_FS_SET_CHMOD_RECURSIVE='-R'
      BL64_FS_SET_CHMOD_VERBOSE='-v'
      BL64_FS_SET_CHMOD_SYMLINK='-h'
      BL64_FS_SET_CHOWN_RECURSIVE='-R'
      BL64_FS_SET_CHOWN_VERBOSE='-v'
      BL64_FS_SET_CP_DEREFERENCE='-L'
      BL64_FS_SET_CP_FORCE='-f'
      BL64_FS_SET_CP_RECURSIVE='-R'
      BL64_FS_SET_CP_VERBOSE='-v'
      BL64_FS_SET_FIND_NAME='-name'
      BL64_FS_SET_FIND_PRINT='-print'
      BL64_FS_SET_FIND_RUN='-exec'
      BL64_FS_SET_FIND_STAY='-xdev'
      BL64_FS_SET_FIND_TYPE_DIR='-type d'
      BL64_FS_SET_FIND_TYPE_FILE='-type f'
      BL64_FS_SET_LN_FORCE='-f'
      BL64_FS_SET_LN_SYMBOLIC='-s'
      BL64_FS_SET_LN_VERBOSE='-v'
      BL64_FS_SET_LS_NOCOLOR='--color=never'
      BL64_FS_SET_MKDIR_PARENTS='-p'
      BL64_FS_SET_MKDIR_VERBOSE=' '
      BL64_FS_SET_MKTEMP_DIRECTORY='-d'
      BL64_FS_SET_MKTEMP_QUIET='-q'
      BL64_FS_SET_MKTEMP_TMPDIR='-p'
      BL64_FS_SET_MV_FORCE='-f'
      BL64_FS_SET_MV_VERBOSE=' '
      BL64_FS_SET_RM_FORCE='-f'
      BL64_FS_SET_RM_RECURSIVE='-R'
      BL64_FS_SET_RM_VERBOSE=' '
      ;;
    ${BL64_OS_ARC}-*)
      BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
      BL64_FS_SET_CHMOD_VERBOSE='--verbose'
      BL64_FS_SET_CHMOD_SYMLINK='-h'
      BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
      BL64_FS_SET_CHOWN_VERBOSE='--verbose'
      BL64_FS_SET_CP_DEREFERENCE='--dereference'
      BL64_FS_SET_CP_FORCE='--force'
      BL64_FS_SET_CP_RECURSIVE='--recursive'
      BL64_FS_SET_CP_VERBOSE='--verbose'
      BL64_FS_SET_FIND_NAME='-name'
      BL64_FS_SET_FIND_PRINT='-print'
      BL64_FS_SET_FIND_RUN='-exec'
      BL64_FS_SET_FIND_STAY='-xdev'
      BL64_FS_SET_FIND_TYPE_DIR='-type d'
      BL64_FS_SET_FIND_TYPE_FILE='-type f'
      BL64_FS_SET_LN_FORCE='--force'
      BL64_FS_SET_LN_SYMBOLIC='--symbolic'
      BL64_FS_SET_LN_VERBOSE='--verbose'
      BL64_FS_SET_LS_NOCOLOR='--color=never'
      BL64_FS_SET_MKDIR_PARENTS='--parents'
      BL64_FS_SET_MKDIR_VERBOSE='--verbose'
      BL64_FS_SET_MKTEMP_DIRECTORY='--directory'
      BL64_FS_SET_MKTEMP_QUIET='--quiet'
      BL64_FS_SET_MKTEMP_TMPDIR='-p'
      BL64_FS_SET_MV_FORCE='--force'
      BL64_FS_SET_MV_VERBOSE='--verbose'
      BL64_FS_SET_RM_FORCE='--force'
      BL64_FS_SET_RM_RECURSIVE='--recursive'
      BL64_FS_SET_RM_VERBOSE='--verbose'
      ;;
    ${BL64_OS_MCOS}-*)
      BL64_FS_SET_CHMOD_RECURSIVE='-R'
      BL64_FS_SET_CHMOD_VERBOSE='-v'
      BL64_FS_SET_CHMOD_SYMLINK='-h'
      BL64_FS_SET_CHOWN_RECURSIVE='-R'
      BL64_FS_SET_CHOWN_VERBOSE='-v'
      BL64_FS_SET_CP_DEREFERENCE='-L'
      BL64_FS_SET_CP_FORCE='-f'
      BL64_FS_SET_CP_RECURSIVE='-R'
      BL64_FS_SET_CP_VERBOSE='-v'
      BL64_FS_SET_FIND_NAME='-name'
      BL64_FS_SET_FIND_PRINT='-print'
      BL64_FS_SET_FIND_RUN='-exec'
      BL64_FS_SET_FIND_STAY='-xdev'
      BL64_FS_SET_FIND_TYPE_DIR='-type d'
      BL64_FS_SET_FIND_TYPE_FILE='-type f'
      BL64_FS_SET_LN_FORCE='-f'
      BL64_FS_SET_LN_SYMBOLIC='-s'
      BL64_FS_SET_LN_VERBOSE='-v'
      BL64_FS_SET_LS_NOCOLOR='--color=never'
      BL64_FS_SET_MKDIR_PARENTS='-p'
      BL64_FS_SET_MKDIR_VERBOSE='-v'
      BL64_FS_SET_MKTEMP_DIRECTORY='-d'
      BL64_FS_SET_MKTEMP_QUIET='-q'
      BL64_FS_SET_MKTEMP_TMPDIR='-p'
      BL64_FS_SET_MV_FORCE='-f'
      BL64_FS_SET_MV_VERBOSE='-v'
      BL64_FS_SET_RM_FORCE='-f'
      BL64_FS_SET_RM_RECURSIVE='-R'
      BL64_FS_SET_RM_VERBOSE='-v'
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2034
function _bl64_fs_set_alias() {
  local cmd_mawk='/usr/bin/mawk'

  BL64_FS_ALIAS_CHOWN_DIR="${BL64_FS_CMD_CHOWN} ${BL64_FS_SET_CHOWN_VERBOSE} ${BL64_FS_SET_CHOWN_RECURSIVE}"
  BL64_FS_ALIAS_CP_DFIND="/usr/bin/find"
  BL64_FS_ALIAS_CP_DIR="${BL64_FS_CMD_CP} ${BL64_FS_SET_CP_VERBOSE} ${BL64_FS_SET_CP_FORCE} ${BL64_FS_SET_CP_RECURSIVE}"
  BL64_FS_ALIAS_CP_FIFIND="/usr/bin/find"
  BL64_FS_ALIAS_CP_FILE="${BL64_FS_CMD_CP} ${BL64_FS_SET_CP_VERBOSE} ${BL64_FS_SET_CP_FORCE}"
  BL64_FS_ALIAS_LN_FORCE="--force"
  BL64_FS_ALIAS_LN_SYMBOLIC="${BL64_FS_CMD_LN} ${BL64_FS_SET_LN_SYMBOLIC} ${BL64_FS_SET_LN_VERBOSE}"
  BL64_FS_ALIAS_LS_FILES="${BL64_FS_CMD_LS} ${BL64_FS_SET_LS_NOCOLOR}"
  BL64_FS_ALIAS_MKDIR_FULL="${BL64_FS_CMD_MKDIR} ${BL64_FS_SET_MKDIR_VERBOSE} ${BL64_FS_SET_MKDIR_PARENTS}"
  BL64_FS_ALIAS_MKTEMP_DIR="${BL64_FS_CMD_MKTEMP} -d"
  BL64_FS_ALIAS_MKTEMP_FILE="${BL64_FS_CMD_MKTEMP}"
  BL64_FS_ALIAS_MV="${BL64_FS_CMD_MV} ${BL64_FS_SET_MV_VERBOSE} ${BL64_FS_SET_MV_FORCE}"
  BL64_FS_ALIAS_MV="${BL64_FS_CMD_MV} ${BL64_FS_SET_MV_VERBOSE} ${BL64_FS_SET_MV_FORCE}"
  BL64_FS_ALIAS_RM_FILE="${BL64_FS_CMD_RM} ${BL64_FS_SET_RM_VERBOSE} ${BL64_FS_SET_RM_FORCE}"
  BL64_FS_ALIAS_RM_FULL="${BL64_FS_CMD_RM} ${BL64_FS_SET_RM_VERBOSE} ${BL64_FS_SET_RM_FORCE} ${BL64_FS_SET_RM_RECURSIVE}"
}

#######################################
# BashLib64 / Module / Functions / Manage local filesystem
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_fs_create_dir() {
  bl64_msg_show_deprecated 'bl64_fs_create_dir' 'bl64_fs_dir_create'
  bl64_fs_dir_create "$@"
}
function bl64_fs_cp_file() {
  bl64_msg_show_deprecated 'bl64_fs_cp_file' 'bl64_fs_file_copy'
  bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$@"
}
function bl64_fs_cp_dir() {
  bl64_msg_show_deprecated 'bl64_fs_cp_dir' 'bl64_fs_path_copy'
  bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_RECURSIVE" "$@"
}
function bl64_fs_ln_symbolic() {
  bl64_msg_show_deprecated 'bl64_fs_ln_symbolic' 'bl64_fs_symlink_create'
  bl64_fs_symlink_create "$@"
}
function bl64_fs_create_symlink() {
  bl64_msg_show_deprecated 'bl64_fs_create_symlink' 'bl64_fs_symlink_create'
  bl64_fs_symlink_create "$@"
}
function bl64_fs_rm_file() {
  bl64_msg_show_deprecated 'bl64_fs_rm_file' 'bl64_fs_file_remove'
  bl64_fs_file_remove "$@"
}
function bl64_fs_rm_full() {
  bl64_msg_show_deprecated 'bl64_fs_rm_full' 'bl64_fs_path_remove'
  bl64_fs_path_remove "$@"
}
function bl64_fs_create_file() {
  bl64_msg_show_deprecated 'bl64_fs_create_file' 'bl64_fs_file_create'
  bl64_fs_file_create "$@"
}
function bl64_fs_copy_files() {
  bl64_msg_show_deprecated 'bl64_fs_copy_files' 'bl64_fs_file_copy'
  bl64_fs_file_copy "$@"
}
function bl64_fs_safeguard() {
  bl64_msg_show_deprecated 'bl64_fs_safeguard' 'bl64_fs_path_archive'
  bl64_fs_path_archive "$@"
}
function bl64_fs_restore() {
  bl64_msg_show_deprecated 'bl64_fs_restore' 'bl64_fs_path_recover'
  bl64_fs_path_recover "$@"
}
function bl64_fs_find_files() {
  bl64_msg_show_deprecated 'bl64_fs_find_files' 'bl64_fs_file_search'
  bl64_fs_file_search "$@"
}
function bl64_fs_chown_dir() {
  bl64_msg_show_deprecated 'bl64_fs_chown_dir' 'bl64_fs_run_chown'
  bl64_fs_run_chown "$BL64_FS_SET_CHOWN_RECURSIVE" "$@"
}
function bl64_fs_chmod_dir() {
  bl64_msg_show_deprecated 'bl64_fs_chmod_dir' 'bl64_fs_run_chmod'
  bl64_fs_run_chmod "$BL64_FS_SET_CHMOD_RECURSIVE" "$@"
}
function bl64_fs_mkdir_full() {
  bl64_msg_show_deprecated 'bl64_fs_mkdir_full' 'bl64_fs_run_mkdir'
  bl64_fs_run_mkdir "$BL64_FS_SET_MKDIR_PARENTS" "$@"
}
function bl64_fs_merge_files() {
  bl64_msg_show_deprecated 'bl64_fs_merge_files' 'bl64_fs_file_merge'
  bl64_fs_file_merge "$@"
}
function bl64_fs_merge_dir() {
  bl64_msg_show_deprecated 'bl64_fs_merge_dir' 'bl64_fs_path_merge'
  bl64_fs_path_merge "$@"
}
function bl64_fs_set_permissions() {
  bl64_dbg_lib_show_function "$@"
  bl64_msg_show_deprecated 'bl64_fs_set_permissions' 'bl64_fs_path_permission_set'
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local path=''

  shift
  shift
  shift

  bl64_fs_path_permission_set \
    "$mode" \
    "$mode" \
    "$user" \
    "$group" \
    "$BL64_VAR_OFF" \
    "$@"
}

function bl64_fs_fix_permissions() {
  bl64_dbg_lib_show_function "$@"
  bl64_msg_show_deprecated 'bl64_fs_fix_permissions' 'bl64_fs_path_permission_set'
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local path=''

  shift
  shift

  bl64_fs_path_permission_set \
    "$file_mode" \
    "$dir_mode" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_ON" \
    "$@"
}

#
# Private functions
#

function _bl64_fs_path_permission_set_file() {
  bl64_dbg_lib_show_function "$@"
  local mode="$1"
  local recursive="$2"
  local path="$3"

  bl64_lib_var_is_default "$mode" && return 0
  bl64_msg_show_lib_subtask "set file permissions (${file_mode} ${BL64_MSG_COSMETIC_ARROW} ${path})"
  if bl64_lib_flag_is_enabled "$recursive"; then
    # shellcheck disable=SC2086
    bl64_fs_run_find \
      "$path" \
      ${BL64_FS_SET_FIND_STAY} \
      ${BL64_FS_SET_FIND_TYPE_FILE} \
      ${BL64_FS_SET_FIND_RUN} "$BL64_FS_CMD_CHMOD" "$file_mode" "{}" \;
  else
    [[ ! -f "$path" ]] && return 0
    bl64_fs_run_chmod "$mode" "$path"
  fi
}

function _bl64_fs_path_permission_set_dir() {
  bl64_dbg_lib_show_function "$@"
  local mode="$1"
  local recursive="$2"
  local path="$3"

  bl64_lib_var_is_default "$mode" && return 0
  bl64_msg_show_lib_subtask "set directory permissions (${dir_mode} ${BL64_MSG_COSMETIC_ARROW} ${path})"
  if bl64_lib_flag_is_enabled "$recursive"; then
    # shellcheck disable=SC2086
    bl64_fs_run_find \
      "$path" \
      ${BL64_FS_SET_FIND_STAY} \
      ${BL64_FS_SET_FIND_TYPE_DIR} \
      ${BL64_FS_SET_FIND_RUN} "$BL64_FS_CMD_CHMOD" "$dir_mode" "{}" \;
  else
    [[ ! -d "$path" ]] && return 0
    bl64_fs_run_chmod "$mode" "$path"
  fi
}

function _bl64_fs_path_permission_set_user() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local recursive="$2"
  local path="$3"
  local cli_options=' '

  bl64_lib_var_is_default "$user" && return 0
  bl64_lib_flag_is_enabled "$recursive" && cli_options="$BL64_FS_SET_CHOWN_RECURSIVE"
  bl64_msg_show_lib_subtask "set new file owner (${user} ${BL64_MSG_COSMETIC_ARROW2} ${path})"
  # shellcheck disable=SC2086
  bl64_fs_run_chown \
    $cli_options \
    "${user}" \
    "$path"
}

function _bl64_fs_path_permission_set_group() {
  bl64_dbg_lib_show_function "$@"
  local group="$1"
  local recursive="$2"
  local path="$3"
  local cli_options=' '

  bl64_lib_var_is_default "$group" && return 0
  bl64_lib_flag_is_enabled "$recursive" && cli_options="$BL64_FS_SET_CHOWN_RECURSIVE"
  bl64_msg_show_lib_subtask "set new file group (${group} ${BL64_MSG_COSMETIC_ARROW2} ${path})"
  # shellcheck disable=SC2086
  bl64_fs_run_chown \
    $cli_options \
    ":${group}" \
    "$path"
}

#
# Public functions
#

#######################################
# Create one ore more directories, then set owner and permissions
#
#  Features:
#   * If the new path is already present nothing is done. No error or warning is presented
# Limitations:
#   * No rollback in case of errors. The process will not remove already created paths
#   * Parents are created, but permissions and ownership is not changed
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $@: full directory paths
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_dir_create() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local path=''

  # Remove consumed parameters
  shift
  shift
  shift

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "path list:[${*}]"

  for path in "$@"; do
    bl64_check_path_absolute "$path" || return $?
    [[ -d "$path" ]] && continue
    bl64_msg_show_lib_subtask "create directory (${path})"
    bl64_fs_run_mkdir \
      "$BL64_FS_SET_MKDIR_PARENTS" \
      "$path" &&
      bl64_fs_path_permission_set \
        "$BL64_VAR_DEFAULT" \
        "$mode" \
        "$user" \
        "$group" \
        "$BL64_VAR_OFF" \
        "$path" ||
      return $?
  done
  return 0
}

#######################################
#  Remove paths (files, directories)
#
# * Recursive
# * No error if the path is not present
# * No backup previous to removal
#
# Arguments:
#   $@: list of full paths
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_path_remove() {
  bl64_dbg_lib_show_function "$@"
  local path_current=''

  bl64_check_parameters_none "$#" ||
    return $?

  for path_current in "$@"; do
    [[ ! -e "$path_current" ]] && continue
    bl64_msg_show_lib_subtask "remove path (${path_current})"
    bl64_fs_run_rm \
      "$BL64_FS_SET_RM_FORCE" \
      "$BL64_FS_SET_RM_RECURSIVE" \
      "$path_current" ||
      return $?
  done
}

#######################################
# Copy one ore more paths to a single destination. Optionally set owner and permissions
#
# * Root privilege (sudo) needed if paths are restricted or change owner is requested
# * No rollback in case of errors. The process will not remove already copied files
# * Recursive
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: use current umask
#   $2: directory permissions. Format: chown format. Default: use current umask
#   $3: user name. Default: current
#   $4: group name. Default: current
#   $5: destination path. Created if not present
#   $@: full source paths. Directory and/or files
# Outputs:
#   STDOUT: verbose operation
#   STDERR: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_path_copy() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local group="${4:-${BL64_VAR_DEFAULT}}"
  local destination="${5:-${BL64_VAR_DEFAULT}}"
  local path_current=''
  local path_base=

  shift
  shift
  shift
  shift
  shift

  bl64_check_parameter 'destination' || return $?

  [[ "$#" == 0 ]] &&
    bl64_msg_show_warning 'there are no files to copy. No further action taken' &&
    return 0

  bl64_fs_dir_create \
    "$dir_mode" \
    "$user" \
    "$group" \
    "$destination" ||
    return $?

  # shellcheck disable=SC2086
  bl64_msg_show_lib_subtask "copy paths (${*} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
  # shellcheck disable=SC2086
  bl64_fs_run_cp \
    $BL64_FS_SET_CP_FORCE \
    $BL64_FS_SET_CP_RECURSIVE \
    "$@" \
    "$destination" ||
    return $?

  for path_current in "$@"; do
    path_base="$(bl64_fmt_path_get_basename "$path_current")"
    bl64_fs_path_permission_set \
      "$file_mode" \
      "$dir_mode" \
      "$user" \
      "$group" \
      "$BL64_VAR_ON" \
      "${destination}/${path_base}" ||
      return $?
  done
}

#######################################
# Copy one ore more files to a single destination. Optionally set owner and permissions
#
# * Root privilege (sudo) needed if paths are restricted or change owner is requested
# * No rollback in case of errors. The process will not remove already copied files
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: destination path. Must exist
#   $@: full file paths. No wildcards allowed
# Outputs:
#   STDOUT: verbose operation
#   STDERR: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_file_copy() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local destination="${4:-${BL64_VAR_DEFAULT}}"
  local path_current=''
  local path_base=

  # Remove consumed parameters
  shift
  shift
  shift
  shift

  bl64_check_parameter 'destination' &&
    bl64_check_directory "$destination" || return $?

  [[ "$#" == 0 ]] &&
    bl64_msg_show_warning 'there are no files to copy. No further action taken' &&
    return 0

  # shellcheck disable=SC2086
  bl64_msg_show_lib_subtask "copy files (${*} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
  # shellcheck disable=SC2086
  bl64_fs_run_cp \
    $BL64_FS_SET_CP_FORCE \
    "$@" \
    "$destination" ||
    return $?

  for path_current in "$@"; do
    path_base="$(bl64_fmt_path_get_basename "$path_current")"
    bl64_fs_path_permission_set \
      "$file_mode" \
      "$BL64_VAR_DEFAULT" \
      "$user" \
      "$group" \
      "$BL64_VAR_OFF" \
      "${destination}/${path_base}" ||
      return $?
  done
}

#######################################
# Merge 2 or more files into a new one, then set owner and permissions
#
# * If the destination is already present no update is done unless requested
# * If asked to replace destination, no backup is done. Caller must take one if needed
# * If merge fails, the incomplete file will be removed
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: replace existing content. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $5: destination file. Full path
#   $@: source files. Full path
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   command dependant
#   $BL64_FS_ERROR_EXISTING_FILE
#   $BL64_LIB_ERROR_TASK_FAILED
#######################################
function bl64_fs_file_merge() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local replace="${4:-${BL64_VAR_DEFAULT}}"
  local destination="${5:-${BL64_VAR_DEFAULT}}"
  local path=''
  local -i status=0
  local -i first=1

  bl64_check_parameter 'destination' &&
    bl64_fs_check_new_file "$destination" &&
    bl64_check_overwrite "$destination" "$replace" ||
    return $?

  # Remove consumed parameters
  shift
  shift
  shift
  shift
  shift
  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "source files:[${*}]"

  for path in "$@"; do
    bl64_msg_show_lib_subtask "merge content from source (${path} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
    if ((first == 1)); then
      first=0
      bl64_check_path_absolute "$path" &&
        "$BL64_OS_CMD_CAT" "$path" >"$destination"
    else
      bl64_check_path_absolute "$path" &&
        "$BL64_OS_CMD_CAT" "$path" >>"$destination"
    fi
    status=$?
    ((status != 0)) && break
    :
  done

  if ((status == 0)); then
    bl64_dbg_lib_show_comments "merge commplete, update permissions if needed (${destination})"
    bl64_fs_path_permission_set "$mode" "$BL64_VAR_DEFAULT" "$user" "$group" "$BL64_VAR_OFF" "$destination"
    status=$?
  else
    bl64_dbg_lib_show_comments "merge failed, removing incomplete file (${destination})"
    bl64_fs_file_remove "$destination"
  fi

  return "$status"
}

#######################################
# Merge directory contents from source directory to target
#
# * Content includes files and directories
# * Recursive should not be disabled if the source contains directories, as it will fail
#
# Requirements:
#   * root privilege (sudo) if the files are restricted
# Arguments:
#   $1: source path
#   $2: target path
#   $3: recursive. Default: ON
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_path_merge() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_VAR_DEFAULT}}"
  local target="${2:-${BL64_VAR_DEFAULT}}"
  local recursive="${3:-${BL64_VAR_ON}}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' &&
    bl64_check_directory "$source" &&
    bl64_check_directory "$target" ||
    return $?

  bl64_msg_show_lib_subtask "merge directories content (${source} ${BL64_MSG_COSMETIC_ARROW2} ${target})"
  if bl64_lib_flag_is_enabled "$recursive"; then
    recursive="$BL64_FS_SET_CP_RECURSIVE"
  else
    recursive=''
  fi
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" --no-target-directory "$source" "$target"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" --no-target-directory "$source" "$target"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" --no-target-directory "$source" "$target"
      ;;
    ${BL64_OS_ALP}-*)
      # shellcheck disable=SC2086
      shopt -sq dotglob &&
        bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" ${source}/* -t "$target" &&
        shopt -uq dotglob
      ;;
    ${BL64_OS_ARC}-*)
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" --no-target-directory "$source" "$target"
      ;;
    ${BL64_OS_MCOS}-*)
      # shellcheck disable=SC2086
      bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_DEREFERENCE" "$recursive" ${source}/ "$target"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_chown() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_CHOWN_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CHOWN" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Warning: mktemp with no arguments creates a temp file by default
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
function bl64_fs_run_mktemp() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_FS_MODULE' ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MKTEMP" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_chmod() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_CHMOD_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CHMOD" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_mkdir() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_MKDIR_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MKDIR" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_mv() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_MV_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MV" $debug "$BL64_FS_SET_MV_FORCE" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove content from OS temporary repositories
#
# * Warning: intented for container build only, not to run on regular OS
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_tmps() {
  bl64_dbg_lib_show_function
  local target=''

  target='/tmp'
  bl64_msg_show_lib_subtask "clean up OS temporary files (${target})"
  bl64_fs_path_remove -- "${target}"/[[:alnum:]]*

  target='/var/tmp'
  bl64_msg_show_lib_subtask "clean up OS temporary files (${target})"
  bl64_fs_path_remove -- "${target}"/[[:alnum:]]*
  return 0
}

#######################################
# Remove or reset logs from standard locations
#
# * Warning: intented for container build only, not to run on regular OS
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_logs() {
  bl64_dbg_lib_show_function
  local target='/var/log'

  if [[ -d "$target" ]]; then
    bl64_msg_show_lib_subtask "clean up OS logs (${target})"
    bl64_fs_path_remove "${target}"/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Remove or reset OS caches from standard locations
#
# * Warning: intented for container build only, not to run on regular OS
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_caches() {
  bl64_dbg_lib_show_function
  local target='/var/cache/man'

  if [[ -d "$target" ]]; then
    bl64_msg_show_lib_subtask "clean up OS cache contents (${target})"
    bl64_fs_path_remove "${target}"/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Performs a complete cleanup of OS ephemeral content
#
# * Warning: intented for container build only, not to run on regular OS
# * Removes temporary files
# * Cleans caches
# * Removes logs
#
# Arguments:
#   None
# Outputs:
#   STDOUT: output from clean functions
#   STDERR: output from clean functions
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_full() {
  bl64_dbg_lib_show_function

  bl64_fs_cleanup_tmps
  bl64_fs_cleanup_logs
  bl64_fs_cleanup_caches

  return 0
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_find() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_check_command "$BL64_FS_CMD_FIND" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_FS_CMD_FIND" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Find files and report as list
#
# * Not using bl64_fs_run_find to avoid file expansion for -name
#
# Arguments:
#   $1: search path
#   $2: search pattern. Format: find -name options
#   $3: search content in text files
# Outputs:
#   STDOUT: file list. One path per line
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_file_search() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-.}"
  local pattern="${2:-${BL64_VAR_DEFAULT}}"
  local content="${3:-${BL64_VAR_DEFAULT}}"

  bl64_check_command "$BL64_FS_CMD_FIND" &&
    bl64_check_directory "$path" || return $?

  bl64_lib_var_is_default "$pattern" && pattern=''

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  if bl64_lib_var_is_default "$content"; then
    "$BL64_FS_CMD_FIND" \
      "$path" \
      -type 'f' \
      ${pattern:+-name "${pattern}"} \
      -print
  else
    "$BL64_FS_CMD_FIND" \
      "$path" \
      -type 'f' \
      ${pattern:+-name "${pattern}"} \
      -exec \
      "$BL64_TXT_CMD_GREP" \
      "$BL64_TXT_SET_GREP_SHOW_FILE_ONLY" \
      "$BL64_TXT_SET_GREP_ERE" "$content" \
      "{}" \;
  fi
  bl64_dbg_lib_trace_stop

}

#######################################
# Archive path to a temporary location
#
# * Use for file/dir operations that will alter or replace the content and requires a quick rollback mechanism
# * The original path is renamed until bl64_fs_path_recover is called to either remove or restore it
# * If the source is not present nothing is done. Return with no error. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_path_archive)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_path_archive() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local backup="${source}${BL64_FS_ARCHIVE_POSTFIX}"

  bl64_check_parameter 'source' ||
    return $?

  # Return if not present
  if [[ ! -e "$source" ]]; then
    bl64_dbg_lib_show_comments "path is not yet created, nothing to do (${source})"
    return 0
  fi

  bl64_msg_show_lib_subtask "backup source path ([${source}]->[${backup}])"
  if ! bl64_fs_run_mv "$source" "$backup"; then
    bl64_msg_show_lib_error "unable to archive source path ($source)"
    return "$BL64_LIB_ERROR_TASK_BACKUP"
  fi

  return 0
}

#######################################
# Recover path from safeguard if operation failed or remove if operation was ok
#
# * Use as a quick rollback for file/dir operations
# * Called after bl64_fs_path_archive creates the backup
# * If the backup is not there nothing is done, no error returned. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_path_archive)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_path_recover() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local -i result=$2
  local backup="${source}${BL64_FS_ARCHIVE_POSTFIX}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'result' ||
    return $?

  # Return if not present
  if [[ ! -e "$backup" ]]; then
    bl64_dbg_lib_show_comments "backup was not created, nothing to do (${backup})"
    return 0
  fi

  # Check if restore is needed based on the operation result
  if ((result == 0)); then
    bl64_msg_show_lib_subtask "remove obsolete backup (${backup})"
    bl64_fs_path_remove "$backup"
    return 0
  else
    bl64_msg_show_lib_subtask "restore original path from backup ([${backup}]->[${source}])"
    # shellcheck disable=SC2086
    bl64_fs_run_mv "$backup" "$source" ||
      return "$BL64_LIB_ERROR_TASK_RESTORE"
  fi
}

#######################################
# Set path permissions and ownership
#
# * Path: directory and/or file only
# * Allow different permissions for files and directories
# * Requires root privilege if current user is not the path owner
# * Path wildcards are not allowed
# * Recursive
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: no change
#   $2: directory permissions. Format: chown format. Default: no change
#   $3: user name. Default: no change
#   $4: group name. Default: no change
#   $5: Recursive. Format: ON|OFF. Default: OFF
#   $@: list of paths. Must use full path for each
# Outputs:
#   STDOUT: command stdin
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_path_permission_set() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local group="${4:-${BL64_VAR_DEFAULT}}"
  local recursive="${5:-${BL64_VAR_DEFAULT}}"
  local target_path=''

  bl64_lib_var_is_default "$recursive" && recursive="$BL64_VAR_OFF"
  # Remove consumed parameters
  shift
  shift
  shift
  shift
  shift

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "path list:[${*}]"
  for target_path in "$@"; do
    bl64_check_path "$target_path" || return $?
    _bl64_fs_path_permission_set_file "$file_mode" "$recursive" "$target_path" &&
      _bl64_fs_path_permission_set_dir "$dir_mode" "$recursive" "$target_path" &&
      _bl64_fs_path_permission_set_user "$user" "$recursive" "$target_path" &&
      _bl64_fs_path_permission_set_group "$group" "$recursive" "$target_path" ||
      return $?
  done
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_cp() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_CP_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CP" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_rm() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_CP_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_RM" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_ls() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_FS_CMD_LS" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_ln() {
  bl64_dbg_lib_show_function "$@"
  local debug=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug="$BL64_FS_SET_LN_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_LN" $debug "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Set default path creation permission with umask
#
# * Uses symbolic permission form
# * Supports predefined sets: BL64_FS_UMASK_*
#
# Arguments:
#   $1: permission. Format: BL64_FS_UMASK_RW_USER
# Outputs:
#   STDOUT: None
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
# shellcheck disable=SC2120
function bl64_fs_set_umask() {
  bl64_dbg_lib_show_function "$@"
  local permissions="${1:-${BL64_FS_UMASK_RW_USER}}"

  bl64_dbg_lib_show_comments "temporary change current script umask (${permissions})"
  umask -S "$permissions" >/dev/null
}

#######################################
# Set global ephemeral paths for bashlib64 functions
#
# * When set, bashlib64 can use these locations as alternative paths to standard ephemeral locations (tmp, cache, etc)
# * Path is created if not already present
#
# Arguments:
#   $1: Temporal files. Short lived, data should be removed after usage. Format: full path
#   $2: cache files. Lifecycle managed by the consumer. Data can persist between runs. If data is removed, consumer should be able to regenerate it. Format: full path
#   $3: permissions. Format: chown format. Default: use current umask
#   $4: user name. Default: current
#   $5: group name. Default: current
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_set_ephemeral() {
  bl64_dbg_lib_show_function "$@"
  local temporal="${1:-${BL64_VAR_DEFAULT}}"
  local cache="${2:-${BL64_VAR_DEFAULT}}"
  local mode="${3:-${BL64_VAR_DEFAULT}}"
  local user="${4:-${BL64_VAR_DEFAULT}}"
  local group="${5:-${BL64_VAR_DEFAULT}}"

  if [[ "$temporal" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_dir_create "$mode" "$user" "$group" "$temporal" &&
      BL64_FS_PATH_TEMPORAL="$temporal" ||
      return $?
  fi

  if [[ "$cache" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_dir_create "$mode" "$user" "$group" "$cache" &&
      BL64_FS_PATH_CACHE="$cache" ||
      return $?
  fi

  return 0
}

#######################################
# Create temporal directory
#
# * Wrapper for the mktemp tool
#
# Arguments:
#   None
# Outputs:
#   STDOUT: full path to temp dir
#   STDERR: error messages
# Returns:
#   0: temp created ok
#  >0: failed to create temp
#######################################
function bl64_fs_create_tmpdir() {
  bl64_dbg_lib_show_function
  local template="${BL64_FS_TMP_PREFIX}-${BL64_SCRIPT_NAME}.XXXXXXXXXX"

  bl64_fs_run_mktemp \
    "$BL64_FS_SET_MKTEMP_DIRECTORY" \
    "$BL64_FS_SET_MKTEMP_TMPDIR" "$BL64_FS_PATH_TMP" \
    "$template"
}

#######################################
# Create temporal file
#
# * Wrapper for the mktemp tool
#
# Arguments:
#   None
# Outputs:
#   STDOUT: full path to temp file
#   STDERR: error messages
# Returns:
#   0: temp created ok
#  >0: failed to create temp
#######################################
function bl64_fs_create_tmpfile() {
  bl64_dbg_lib_show_function
  local template="${BL64_FS_TMP_PREFIX}-${BL64_SCRIPT_NAME}.XXXXXXXXXX"

  bl64_fs_run_mktemp \
    "$BL64_FS_SET_MKTEMP_TMPDIR" "$BL64_FS_PATH_TMP" \
    "$template"
}

#######################################
# Remove temporal directory created by bl64_fs_create_tmpdir
#
# Arguments:
#   $1: full path to the tmpdir
# Outputs:
#   STDOUT: None
#   STDERR: error messages
# Returns:
#   0: temp removed ok
#  >0: failed to remove temp
#######################################
function bl64_fs_rm_tmpdir() {
  bl64_dbg_lib_show_function "$@"
  local tmpdir="$1"

  bl64_check_parameter 'tmpdir' &&
    bl64_check_directory "$tmpdir" ||
    return $?

  if [[ "$tmpdir" != ${BL64_FS_PATH_TMP}/${BL64_FS_TMP_PREFIX}-*.* ]]; then
    bl64_msg_show_lib_error "provided directory was not created by bl64_fs_create_tmpdir (${tmpdir})"
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi

  bl64_fs_path_remove "$tmpdir"
}

#######################################
# Remove temporal file create by bl64_fs_create_tmpfile
#
# Arguments:
#   $1: full path to the tmpfile
# Outputs:
#   STDOUT: None
#   STDERR: error messages
# Returns:
#   0: temp removed ok
#  >0: failed to remove temp
#######################################
function bl64_fs_rm_tmpfile() {
  bl64_dbg_lib_show_function "$@"
  local tmpfile="$1"

  bl64_check_parameter 'tmpfile' &&
    bl64_check_file "$tmpfile" ||
    return $?

  if [[ "$tmpfile" != ${BL64_FS_PATH_TMP}/${BL64_FS_TMP_PREFIX}-*.* ]]; then
    bl64_msg_show_lib_error "provided directory was not created by bl64_fs_create_tmpfile (${tmpfile})"
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi

  bl64_fs_file_remove "$tmpfile"
}

#######################################
# Check that the new file path is valid
#
# * If path exists, check that is not a directory
# * Check is ok when path does not exist or exists but it's a file
#
# Arguments:
#   $1: new file path
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_fs_check_new_file() {
  bl64_dbg_lib_show_function "$@"
  local file="${1:-}"

  bl64_check_parameter 'file' ||
    return $?

  if [[ -d "$file" ]]; then
    bl64_msg_show_check "invalid file destination. Provided path exists and is a directory (${file})"
    return "$BL64_LIB_ERROR_PARAMETER_INVALID"
  fi

  return 0
}

#######################################
# Check that the new directory path is valid
#
# * If path exists, check that is not a file
# * Check is ok when path does not exist or exists but it's a directory
#
# Arguments:
#   $1: new directory path
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: check ok
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_fs_check_new_dir() {
  bl64_dbg_lib_show_function "$@"
  local directory="${1:-}"

  bl64_check_parameter 'directory' ||
    return $?

  if [[ -f "$directory" ]]; then
    bl64_msg_show_check "invalid directory destination. Provided path exists and is a file (${directory})"
    return "$BL64_LIB_ERROR_PARAMETER_INVALID"
  fi

  return 0
}

#######################################
# Create symbolic link
#
# * Wrapper for the ln -s command
# * Provide extra checks and verbosity
#
# Arguments:
#   $1: source path
#   $2: destination path
#   $3: overwrite symlink if already present?
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_fs_symlink_create() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local destination="${2:-}"
  local overwrite="${3:-$BL64_VAR_OFF}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_path "$source" ||
    return $?

  bl64_msg_show_lib_subtask "create symbolic link (${source} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"

  if [[ -L "$destination" ]]; then
    if [[ "$overwrite" == "$BL64_VAR_ON" ]]; then
      bl64_fs_file_remove "$destination" ||
        return $?
    else
      bl64_msg_show_warning "target symbolic link is already present. No further action taken (${destination})"
      return 0
    fi
  elif [[ -f "$destination" ]]; then
    bl64_msg_show_lib_error 'invalid destination. It is already present and it is a regular file'
    return "$BL64_LIB_ERROR_TASK_REQUIREMENTS"
  elif [[ -d "$destination" ]]; then
    bl64_msg_show_lib_error 'invalid destination. It is already present and it is a directory'
    return "$BL64_LIB_ERROR_TASK_REQUIREMENTS"
  fi
  bl64_fs_run_ln "$BL64_FS_SET_LN_SYMBOLIC" "$source" "$destination" ||
    return $?
  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    bl64_dbg_lib_show_comments 'emulating Linux behaviour for symbolic link permissions'
    bl64_fs_run_chmod "$BL64_FS_SET_CHMOD_SYMLINK" '0777' "$destination"
  fi
}

#######################################
# Creates an empty regular file
#
# * Creates file if not existing only
#
# Arguments:
#   $1: full path to the file
#   $2: (optional) permissions. Format: chown format. Default: use current umask
#   $3: (optional) user name. Default: current
#   $4: (optional) group name. Default: current
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_file_create() {
  bl64_dbg_lib_show_function "$@"
  local file_path="$1"
  local mode="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local group="${4:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'file_path' ||
    return $?

  [[ -f "$file_path" ]] && return 0

  bl64_msg_show_lib_subtask "create empty regular file (${file_path})"
  bl64_fs_run_touch "$file_path" &&
    bl64_fs_path_permission_set \
      "$mode" \
      "$BL64_VAR_DEFAULT" \
      "$user" \
      "$group" \
      "$BL64_VAR_OFF" \
      "$file_path"
}

#######################################
#  Remove files
#
# * No error if the path is not present
# * No backup previous to removal
# * Will only remove files and links
#
# Arguments:
#   $@: list of full file paths
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_file_remove() {
  bl64_dbg_lib_show_function "$@"
  local path_current=''

  [[ "$#" == 0 ]] &&
    bl64_msg_show_warning 'there are no files to remove. No further action taken' &&
    return 0

  for path_current in "$@"; do
    [[ ! -e "$path_current" && ! -L "$path_current" ]] &&
      bl64_dbg_lib_show_info 'file already removed. No further action taken' &&
      continue
    bl64_msg_show_lib_subtask "remove file (${path_current})"

    [[ ! -f "$path_current" && ! -L "$path_current" ]] &&
      bl64_msg_show_lib_error 'invalid file type. It must be a regular file or a symlink. No further action taken.' &&
      return "$BL64_LIB_ERROR_TASK_FAILED"

    bl64_fs_run_rm \
      "$BL64_FS_SET_RM_FORCE" \
      "$path_current" ||
      return $?
  done
}

#######################################
#  Recreate ephemeral directory path
#
# * No error if the path is not present
# * No backup previous to removal
# * Recursive delete if path is present
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $@: full directory paths
# Outputs:
#   STDOUT: verbose operation
#   STDOUT: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_dir_reset() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"

  # Remove consumed parameters
  shift
  shift
  shift

  bl64_fs_path_remove "$@" &&
    bl64_fs_dir_create "$mode" "$user" "$group" "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_fs_run_touch() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_FS_MODULE' ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_TOUCH" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Backup path
#
# * Use for file  operations that will alter or replace the content and requires a quick rollback mechanism
# * The original file is copied until bl64_fs_file_restore is called to either remove or restore it
# * If the source is not present nothing is done. Return with no error. This is to cover for first time path creation
#
# Arguments:
#   $1: file path
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_file_backup() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local backup="${source}${BL64_FS_BACKUP_POSTFIX}"

  bl64_check_parameter 'source' || return $?
  [[ ! -f "$source" ]] && bl64_dbg_lib_show_comments "file is not yet created, nothing to do (${source})" && return 0

  bl64_msg_show_lib_subtask "backup original file ([${source}]->[${backup}])"
  if ! bl64_fs_run_cp "$source" "$backup"; then
    bl64_msg_show_lib_error 'failed to create file backup'
    return "$BL64_LIB_ERROR_TASK_BACKUP"
  fi

  return 0
}

#######################################
# Restore path from safeguard if operation failed or remove if operation was ok
#
# * Use as a quick rollback for file/dir operations
# * Called after bl64_fs_file_archive creates the backup
# * If the backup is not there nothing is done, no error returned. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_file_backup)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: Task progress
#   STDERR: Task errors
# Returns:
#   0: task executed ok
#   >0: task failed
#######################################
function bl64_fs_file_restore() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"
  local -i result=$2
  local backup="${source}${BL64_FS_BACKUP_POSTFIX}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'result' ||
    return $?

  bl64_dbg_lib_show_comments 'Return if not present'
  if [[ ! -f "$backup" ]]; then
    bl64_dbg_lib_show_info "backup was not created, nothing to do (${backup})"
    return 0
  fi

  bl64_dbg_lib_show_comments 'Check if restore is needed based on the operation result'
  if ((result == 0)); then
    bl64_msg_show_lib_subtask 'discard obsolete backup'
    bl64_fs_file_remove "$backup"
    return 0
  else
    bl64_msg_show_lib_subtask "restore original file from backup ([${backup}]->[${source}])"
    # shellcheck disable=SC2086
    bl64_os_run_cat "$backup" >"$source" &&
      bl64_fs_file_remove "$backup" ||
      return "$BL64_LIB_ERROR_TASK_RESTORE"
  fi
}

#######################################
# Move one ore more paths to a single destination. Optionally set owner and permissions
#
# * Wildcards are not allowed. Use run_mv instead if needed
# * Destination path should be present
# * Root privilege (sudo) needed if paths are restricted or change owner is requested
# * No rollback in case of errors. The process will not remove already copied files
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: use current umask
#   $2: directory permissions. Format: chown format. Default: use current umask
#   $3: user name. Default: current
#   $4: group name. Default: current
#   $5: destination path
#   $@: full source paths. No wildcards allowed
# Outputs:
#   STDOUT: verbose operation
#   STDERR: command errors
# Returns:
#   0: Operation completed ok
#   >0: Operation failed
#######################################
function bl64_fs_path_move() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local group="${4:-${BL64_VAR_DEFAULT}}"
  local destination="${5:-${BL64_VAR_DEFAULT}}"
  local path_current=''
  local path_base=

  bl64_check_directory "$destination" || return $?

  # Remove consumed parameters
  shift
  shift
  shift
  shift
  shift

  # shellcheck disable=SC2086
  bl64_check_parameters_none "$#" || return $?
  bl64_msg_show_lib_subtask "move paths (${*} ${BL64_MSG_COSMETIC_ARROW2} ${destination})"
  # shellcheck disable=SC2086
  bl64_fs_run_mv \
    $BL64_FS_SET_MV_FORCE \
    "$@" \
    "$destination" ||
    return $?

  for path_current in "$@"; do
    path_base="$(bl64_fmt_path_get_basename "$path_current")"
    bl64_fs_path_permission_set \
      "$file_mode" \
      "$dir_mode" \
      "$user" \
      "$group" \
      "$BL64_VAR_ON" \
      "${destination}/${path_base}" ||
      return $?
  done
}

#######################################
# BashLib64 / Module / Setup / Interact with GCP
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_gcp_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local gcloud_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_XSV_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_gcp_set_command "$gcloud_bin" &&
    _bl64_gcp_set_options &&
    BL64_GCP_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'gcp'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_gcp_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_GCP_CMD_GCLOUD="$(bl64_bsh_command_import 'gcloud' "$@")"
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
function _bl64_gcp_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  BL64_GCP_SET_FORMAT_YAML='--format yaml' &&
    BL64_GCP_SET_FORMAT_TEXT='--format text' &&
    BL64_GCP_SET_FORMAT_JSON='--format json'
}

#######################################
# Set target GCP Project
#
# * Available to all gcloud related commands
#
# Arguments:
#   $1: GCP project ID
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_gcp_set_project() {
  bl64_dbg_lib_show_function "$@"
  local project="${1:-}"

  bl64_check_parameter 'project' || return $?

  BL64_GCP_CLI_PROJECT="$project"

  bl64_dbg_lib_show_vars 'BL64_GCP_CLI_PROJECT'
  return 0
}

#######################################
# Enable service account impersonation
#
# * Available to all gcloud related commands
#
# Arguments:
#   $1: Service Account email
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_gcp_set_impersonate_sa() {
  bl64_dbg_lib_show_function "$@"
  local impersonate_sa="${1:-}"

  bl64_check_parameter 'impersonate_sa' || return $?

  BL64_GCP_CLI_IMPERSONATE_SA="$impersonate_sa"

  bl64_dbg_lib_show_vars 'BL64_GCP_CLI_IMPERSONATE_SA'
  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with GCP
#######################################

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_gcp_run_gcloud() {
  bl64_dbg_lib_show_function "$@"
  local debug=' '
  local config=' '
  local project=' '
  local impersonate_sa=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_GCP_MODULE' ||
    return $?

  if bl64_dbg_lib_command_is_enabled; then
    debug='--verbosity debug --log-http'
  else
    debug='--verbosity none --quiet'
  fi

  _bl64_gcp_harden_gcloud
  [[ -n "$BL64_GCP_CLI_PROJECT" ]] && project="--project=${BL64_GCP_CLI_PROJECT}"
  [[ -n "$BL64_GCP_CLI_IMPERSONATE_SA" ]] && impersonate_sa="--impersonate-service-account=${BL64_GCP_CLI_IMPERSONATE_SA}"
  [[ "$BL64_GCP_CONFIGURATION_CREATED" == "$BL64_VAR_TRUE" ]] && config="--configuration $BL64_GCP_CONFIGURATION_NAME"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_GCP_CMD_GCLOUD" \
    $debug \
    $config \
    $project \
    $impersonate_sa \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Login to GCP using a Service Account
#
# * key must be in json format
# * previous credentials are revoked
#
# Arguments:
#   $1: key file full path
#   $2: project id
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_gcp_login_sa() {
  bl64_dbg_lib_show_function "$@"
  local key_file="$1"
  local project="$2"

  bl64_check_parameter 'key_file' &&
    bl64_check_parameter 'project' &&
    bl64_check_file "$key_file" || return $?

  _bl64_gcp_configure

  bl64_msg_show_lib_subtask 'remove previous GCP credentials'
  bl64_gcp_run_gcloud \
    auth \
    revoke \
    --all

  bl64_msg_show_lib_subtask 'activate service account'
  bl64_gcp_run_gcloud \
    auth \
    activate-service-account \
    --key-file "$key_file" \
    --project "$project"
}

function _bl64_gcp_configure() {
  bl64_dbg_lib_show_function
  if [[ "$BL64_GCP_CONFIGURATION_CREATED" == "$BL64_VAR_FALSE" ]]; then
    bl64_msg_show_lib_subtask "create private GCP configuration (${BL64_GCP_CONFIGURATION_NAME})"
    bl64_gcp_run_gcloud \
      config \
      configurations \
      create "$BL64_GCP_CONFIGURATION_NAME" &&
      BL64_GCP_CONFIGURATION_CREATED="$BL64_VAR_TRUE"
  fi
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
function _bl64_gcp_harden_gcloud() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited _* shell variables'
  bl64_dbg_lib_trace_start
  unset CLOUDSDK_CONFIG
  unset CLOUDSDK_ACTIVE_CONFIG_NAME

  unset CLOUDSDK_AUTH_ACCESS_TOKEN_FILE
  unset CLOUDSDK_AUTH_DISABLE_CREDENTIALS
  unset CLOUDSDK_AUTH_IMPERSONATE_SERVICE_ACCOUNT
  unset CLOUDSDK_AUTH_TOKEN_HOST

  unset CLOUDSDK_CORE_ACCOUNT
  unset CLOUDSDK_CORE_CONSOLE_LOG_FORMAT
  unset CLOUDSDK_CORE_CUSTOM_CA_CERTS_FILE
  unset CLOUDSDK_CORE_DEFAULT_REGIONAL_BACKEND_SERVICE
  unset CLOUDSDK_CORE_DISABLE_COLOR
  unset CLOUDSDK_CORE_DISABLE_FILE_LOGGING
  unset CLOUDSDK_CORE_DISABLE_PROMPTS
  unset CLOUDSDK_CORE_DISABLE_USAGE_REPORTING
  unset CLOUDSDK_CORE_ENABLE_FEATURE_FLAGS
  unset CLOUDSDK_CORE_LOG_HTTP
  unset CLOUDSDK_CORE_MAX_LOG_DAYS
  unset CLOUDSDK_CORE_PASS_CREDENTIALS_TO_GSUTIL
  unset CLOUDSDK_CORE_PROJECT
  unset CLOUDSDK_CORE_SHOW_STRUCTURED_LOGS
  unset CLOUDSDK_CORE_TRACE_TOKEN
  unset CLOUDSDK_CORE_USER_OUTPUT_ENABLED
  unset CLOUDSDK_CORE_VERBOSITY
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# GCP Secrets / Get secret value
#
# * Warning: not intended for Binary payloads as gcloud will return UTF-8 by default
#
# Arguments:
#   $1: Secret Name
#   $2: Version Number
# Outputs:
#   STDOUT: secret value
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_gcp_secret_get() {
  bl64_dbg_lib_show_function "$@"
  local name="$1"
  local secret_version="$2"

  bl64_check_parameter 'name' &&
    bl64_check_parameter 'secret_version' &&
    bl64_check_file "$name" || return $?

  bl64_gcp_run_gcloud \
    'secrets' \
    'versions' \
    'access' \
    "$secret_version" \
    --secret="$name"

}

#######################################
# BashLib64 / Module / Setup / Interact with HLM
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_hlm_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local helm_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_hlm_set_command "$helm_bin" &&
    _bl64_hlm_set_options &&
    _bl64_hlm_set_runtime &&
    BL64_HLM_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'hlm'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_hlm_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_HLM_CMD_HELM="$(bl64_bsh_command_import 'helm' '/opt/helm/bin' "$@")"
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
function _bl64_hlm_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  BL64_HLM_SET_DEBUG='--debug' &&
    BL64_HLM_SET_OUTPUT_TABLE='--output table' &&
    BL64_HLM_SET_OUTPUT_JSON='--output json' &&
    BL64_HLM_SET_OUTPUT_YAML='--output yaml'
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_hlm_set_runtime() {
  bl64_dbg_lib_show_function

  bl64_hlm_set_timeout '5m0s'
}

#######################################
# Update runtime variables: timeout
#
# Arguments:
#   $1: timeout value. Format: same as helm --timeout parameter
# Outputs:
#   STDOUT: None
#   STDERR: Validation
# Returns:
#   0: set ok
#   >0: set error
#######################################
function bl64_hlm_set_timeout() {
  bl64_dbg_lib_show_function "$@"
  local timeout="$1"

  bl64_check_parameter 'timeout' || return $?

  BL64_HLM_RUN_TIMEOUT="$timeout"
}

#######################################
# BashLib64 / Module / Functions / Interact with HLM
#######################################

#######################################
# Add a helm repository to the local host
#
# Arguments:
#   $1: repository name
#   $2: repository source
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_hlm_repo_add() {
  bl64_dbg_lib_show_function "$@"
  local repository="${1:-}"
  local source="${2:-}"

  bl64_check_parameter 'repository' &&
    bl64_check_parameter 'source' ||
    return $?

  bl64_msg_show_lib_subtask "add Helm repository (${repository} ${BL64_MSG_COSMETIC_LEFT_ARROW2} ${source})"
  bl64_hlm_run_helm \
    repo add \
    "$repository" \
    "$source" ||
    return $?

  bl64_msg_show_lib_subtask "update Helm repository catalog (${repository})"
  bl64_hlm_run_helm repo update "$repository"

  return 0
}

#######################################
# Upgrade or install helm existing chart
#
# * Using atomic and cleanup to ensure deployment integrity
#
# Arguments:
#   $1: full path to the kube/config file with cluster credentials
#   $2: target namespace
#   $3: chart name
#   $4: chart source
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_hlm_chart_upgrade() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-}"
  local namespace="${2:-}"
  local chart="${3:-}"
  local source="${4:-}"

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'chart' &&
    bl64_check_parameter 'source' ||
    return $?

  if bl64_lib_var_is_default "$kubeconfig"; then
    kubeconfig=''
  else
    bl64_check_file "$kubeconfig" ||
      return $?
  fi
  shift
  shift
  shift
  shift

  bl64_msg_show_lib_subtask "deploy helm chart (${namespace}/${chart})"
  bl64_hlm_run_helm \
    upgrade \
    "$chart" \
    "$source" \
    ${kubeconfig:+--kubeconfig="$kubeconfig"} \
    --namespace "$namespace" \
    --timeout "$BL64_HLM_RUN_TIMEOUT" \
    --create-namespace \
    --atomic \
    --cleanup-on-fail \
    --install \
    --wait \
    "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_hlm_run_helm() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_HLM_MODULE' ||
    return $?

  bl64_dbg_lib_command_is_enabled && verbosity="$BL64_HLM_SET_DEBUG"
  _bl64_hlm_harden_helm

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_HLM_CMD_HELM" \
    $verbosity \
    "$@"
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
function _bl64_hlm_harden_helm() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited HELM_* shell variables'
  bl64_dbg_lib_trace_start
  unset HELM_CACHE_HOME
  unset HELM_CONFIG_HOME
  unset HELM_DATA_HOME
  unset HELM_DEBUG
  unset HELM_DRIVER
  unset HELM_DRIVER_SQL_CONNECTION_STRING
  unset HELM_MAX_HISTORY
  unset HELM_NAMESPACE
  unset HELM_NO_PLUGINS
  unset HELM_PLUGINS
  unset HELM_REGISTRY_CONFIG
  unset HELM_REPOSITORY_CACHE
  unset HELM_REPOSITORY_CONFIG
  unset HELM_KUBEAPISERVER
  unset HELM_KUBECAFILE
  unset HELM_KUBEASGROUPS
  unset HELM_KUBEASUSER
  unset HELM_KUBECONTEXT
  unset HELM_KUBETOKEN
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# BashLib64 / Module / Setup / Manage OS identity and access service
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_iam_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_RND_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_iam_set_command &&
    _bl64_iam_set_alias &&
    _bl64_iam_set_options &&
    BL64_IAM_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'iam'
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_iam_set_command() {
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_IAM_CMD_USERADD='/usr/sbin/useradd'
    BL64_IAM_CMD_USERMOD='/usr/sbin/usermod'
    BL64_IAM_CMD_GROUPADD='/usr/sbin/groupadd'
    BL64_IAM_CMD_GROUPMOD='/usr/sbin/groupmod'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_IAM_CMD_USERADD='/usr/sbin/useradd'
    BL64_IAM_CMD_USERMOD='/usr/sbin/usermod'
    BL64_IAM_CMD_GROUPADD='/usr/sbin/groupadd'
    BL64_IAM_CMD_GROUPMOD='/usr/sbin/groupmod'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_IAM_CMD_USERADD='/usr/sbin/useradd'
    BL64_IAM_CMD_USERMOD='/usr/sbin/usermod'
    BL64_IAM_CMD_GROUPADD='/usr/sbin/groupadd'
    BL64_IAM_CMD_GROUPMOD='/usr/sbin/groupmod'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_IAM_CMD_ADDUSER='/usr/sbin/adduser'
    BL64_IAM_CMD_ADDGROUP='/usr/sbin/addgroup'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  ${BL64_OS_ARC}-*)
    BL64_IAM_CMD_USERADD='/usr/bin/useradd'
    BL64_IAM_CMD_USERMOD='/usr/bin/usermod'
    BL64_IAM_CMD_GROUPADD='/usr/bin/groupadd'
    BL64_IAM_CMD_GROUPMOD='/usr/bin/groupmod'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_IAM_CMD_SYSADMINCTL='/usr/sbin/sysadminctl'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_iam_set_alias() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD"
    ;;
  ${BL64_OS_SLES}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_ADDUSER"
    ;;
  ${BL64_OS_ARC}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_SYSADMINCTL"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_iam_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_IAM_SET_USERADD_CREATE_HOME='--create-home'
    BL64_IAM_SET_USERADD_GECO='--comment'
    BL64_IAM_SET_USERADD_GROUP='--gid'
    BL64_IAM_SET_USERADD_HOME_PATH='--home-dir'
    BL64_IAM_SET_USERADD_SHELL='--shell'
    BL64_IAM_SET_USERADD_UID='--uid'

    BL64_IAM_SYSTEM_USER='root'
    BL64_IAM_SYSTEM_GROUP='root'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_IAM_SET_USERADD_CREATE_HOME='--create-home'
    BL64_IAM_SET_USERADD_GECO='--comment'
    BL64_IAM_SET_USERADD_GROUP='--gid'
    BL64_IAM_SET_USERADD_HOME_PATH='--home-dir'
    BL64_IAM_SET_USERADD_SHELL='--shell'
    BL64_IAM_SET_USERADD_UID='--uid'

    BL64_IAM_SYSTEM_USER='root'
    BL64_IAM_SYSTEM_GROUP='root'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_IAM_SET_USERADD_CREATE_HOME='--create-home'
    BL64_IAM_SET_USERADD_GECO='--comment'
    BL64_IAM_SET_USERADD_GROUP='--gid'
    BL64_IAM_SET_USERADD_HOME_PATH='--home-dir'
    BL64_IAM_SET_USERADD_SHELL='--shell'
    BL64_IAM_SET_USERADD_UID='--uid'

    BL64_IAM_SYSTEM_USER='root'
    BL64_IAM_SYSTEM_GROUP='root'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_IAM_SET_USERADD_CREATE_HOME=' '
    BL64_IAM_SET_USERADD_GECO='-g'
    BL64_IAM_SET_USERADD_GROUP='-G'
    BL64_IAM_SET_USERADD_HOME_PATH='-h'
    BL64_IAM_SET_USERADD_SHELL='-s'
    BL64_IAM_SET_USERADD_UID='-u'

    BL64_IAM_SYSTEM_USER='root'
    BL64_IAM_SYSTEM_GROUP='root'
    ;;
  ${BL64_OS_ARC}-*)
    BL64_IAM_SET_USERADD_CREATE_HOME='--create-home'
    BL64_IAM_SET_USERADD_GECO='--comment'
    BL64_IAM_SET_USERADD_GROUP='--gid'
    BL64_IAM_SET_USERADD_HOME_PATH='--home-dir'
    BL64_IAM_SET_USERADD_SHELL='--shell'
    BL64_IAM_SET_USERADD_UID='--uid'

    BL64_IAM_SYSTEM_USER='root'
    BL64_IAM_SYSTEM_GROUP='root'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_IAM_SET_USERADD_CREATE_HOME=' '
    BL64_IAM_SET_USERADD_GECO='-fullName'
    BL64_IAM_SET_USERADD_GROUP='-gid'
    BL64_IAM_SET_USERADD_HOME_PATH='-home'
    BL64_IAM_SET_USERADD_SHELL='-shell'
    BL64_IAM_SET_USERADD_UID='-UID'

    BL64_IAM_SYSTEM_USER='root'
    BL64_IAM_SYSTEM_GROUP='wheel'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Manage OS identity and access service
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_iam_xdg_create() {
  bl64_msg_show_deprecated 'bl64_iam_xdg_create' 'bl64_bsh_xdg_create'
  bl64_bsh_xdg_create "$@"
}

#
# Public functions
#

#######################################
# Create local OS user
#
# * Wrapper for native user creation command
# * If the user is already created nothing is done, no error
#
# Arguments:
#   $1: login name
#   $2: (optional) home path. Format: full path. Default: os native
#   $3: (optional) primary group. Format: group name. Default: os native
#   $4: (optional) shell. Format: full path. Default: os native
#   $5: (optional) description. Default: none
#   $6: (optional) user ID. Default: os native
# Outputs:
#   STDOUT: native user add command output
#   STDERR: native user add command error messages
# Returns:
#   native user add command error status
#######################################
function bl64_iam_user_add() {
  bl64_dbg_lib_show_function "$@"
  local login="${1:-}"
  local home="${2:-$BL64_VAR_DEFAULT}"
  local group="${3:-$BL64_VAR_DEFAULT}"
  local shell="${4:-$BL64_VAR_DEFAULT}"
  local gecos="${5:-$BL64_VAR_DEFAULT}"
  local uid="${6:-$BL64_VAR_DEFAULT}"
  local password=''
  local extra_params=''

  bl64_check_parameter 'login' ||
    return $?

  if bl64_iam_user_is_created "$login"; then
    bl64_msg_show_warning "user already created, re-using existing one ($login)"
    return 0
  fi

  bl64_msg_show_lib_subtask "create local user account ($login)"
  bl64_lib_var_is_default "$home" && home=''
  bl64_lib_var_is_default "$group" && group=''
  bl64_lib_var_is_default "$shell" && shell=''
  bl64_lib_var_is_default "$gecos" && gecos=''
  bl64_lib_var_is_default "$uid" && uid=''
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_iam_run_useradd \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        $BL64_IAM_SET_USERADD_CREATE_HOME \
        "$login"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      bl64_iam_run_useradd \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        $BL64_IAM_SET_USERADD_CREATE_HOME \
        "$login"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_dbg_lib_show_comments 'SLES: force primary group creation when group is not specified'
      [[ -z "$group" ]] && extra_params='--user-group'
      bl64_dbg_lib_show_comments 'SLES: --user-group and --gid can not be used together'
      bl64_iam_run_useradd \
        ${extra_params} \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        $BL64_IAM_SET_USERADD_CREATE_HOME \
        "$login"
      ;;
    ${BL64_OS_ALP}-*)
      bl64_dbg_lib_show_comments 'ALP: disable automatic password generation'
      bl64_iam_run_adduser \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        $BL64_IAM_SET_USERADD_CREATE_HOME \
        -D \
        "$login"
      ;;
    ${BL64_OS_ARC}-*)
      bl64_iam_run_useradd \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        $BL64_IAM_SET_USERADD_CREATE_HOME \
        "$login"
      ;;
    ${BL64_OS_MCOS}-*)
      password="$(bl64_rnd_get_numeric)" || return $?
      bl64_iam_run_sysadminctl \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        $BL64_IAM_SET_USERADD_CREATE_HOME \
        -addUser "$login" \
        -password "$password"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create local user group
#
# Arguments:
#   $1: group name
#   $2: (optional) group ID
# Outputs:
#   STDOUT: Progress info
#   STDERR: Command execution error
# Returns:
#   0: group created ok
#   >0: failed to create group
#######################################
function bl64_iam_group_add() {
  bl64_dbg_lib_show_function "$@"
  local group_name="$1"
  local group_id="${2:-$BL64_VAR_DEFAULT}"

  bl64_check_parameter 'group_name' ||
    return $?

  if bl64_iam_group_is_created "$group_name"; then
    bl64_msg_show_warning "group already created, re-using existing one ($group_name)"
    return 0
  fi

  bl64_msg_show_lib_subtask "create local user group ($group_name)"
  bl64_lib_var_is_default "$group_id" && group_id=''
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_iam_run_groupadd \
        ${group_id:+--gid ${group_id}} \
        "$group_name"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      bl64_iam_run_groupadd \
        ${group_id:+--gid ${group_id}} \
        "$group_name"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_iam_run_groupadd \
        ${group_id:+--gid ${group_id}} \
        "$group_name"
      ;;
    ${BL64_OS_ALP}-*)
      bl64_iam_run_addgroup \
        ${group_id:+--gid ${group_id}} \
        "$group_name"
      ;;
    ${BL64_OS_ARC}-*)
      bl64_iam_run_groupadd \
        ${group_id:+--gid ${group_id}} \
        "$group_name"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Determine if the user is created
#
# Arguments:
#   $1: login name
# Outputs:
#   STDOUT: None
#   STDERR: command error messages
# Returns:
#   0: it is
#   BL64_LIB_ERROR_IS_NOT
#   >0: command error status
#######################################
function bl64_iam_user_is_created() {
  bl64_dbg_lib_show_function "$@"
  local user_name="$1"

  bl64_check_parameter 'user_name' ||
    return $?

  bl64_iam_user_get_id "$user_name" >/dev/null 2>&1 ||
    return "$BL64_LIB_ERROR_IS_NOT"
}

#######################################
# Determine if the group is created
#
# Arguments:
#   $1: group name
# Outputs:
#   STDOUT: None
#   STDERR: command error messages
# Returns:
#   0: it is
#   BL64_LIB_ERROR_IS_NOT
#   >0: command error status
#######################################
function bl64_iam_group_is_created() {
  bl64_dbg_lib_show_function "$@"
  local group_name="$1"

  bl64_check_parameter 'group_name' ||
    return $?

  bl64_os_run_getent 'group' "$group_name" >/dev/null 2>&1 ||
    return "$BL64_LIB_ERROR_IS_NOT"
}

#######################################
# Get user's UID
#
# Arguments:
#   $1: user login name. Default: current user
# Outputs:
#   STDOUT: user ID
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_user_get_id() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  if [[ -z "$user" ]]; then
    bl64_iam_run_id -u
  else
    bl64_iam_run_id -u "$user"
  fi
}

#######################################
# Get current user name
#
# Arguments:
#   None
# Outputs:
#   STDOUT: user name
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_user_get_current() {
  bl64_dbg_lib_show_function
  bl64_iam_run_id -u -n
}

#######################################
# Check that the user is created
#
# Arguments:
#   $1: user name
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_USER_NOT_FOUND
#######################################
function bl64_iam_check_user() {
  bl64_dbg_lib_show_function "$@"
  local user="${1:-}"
  local message="${2:-required user is not present in the operating system}"

  bl64_check_parameter 'user' || return $?

  if ! bl64_iam_user_is_created "$user"; then
    bl64_msg_show_check "${message} (user: ${user})"
    return "$BL64_LIB_ERROR_USER_NOT_FOUND"
  else
    return 0
  fi
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_iam_run_useradd() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_USERADD" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_USERADD" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_iam_run_groupadd() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_GROUPADD" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_GROUPADD" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_iam_run_groupmod() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_GROUPMOD" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_GROUPMOD" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_iam_run_usermod() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_USERMOD" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_USERMOD" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_iam_run_adduser() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_ADDUSER" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_ADDUSER" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_iam_run_addgroup() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_ADDGROUP" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_ADDGROUP" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_iam_run_id() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_command "$BL64_IAM_CMD_ID" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_ID" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_iam_run_sysadminctl() {
  bl64_dbg_lib_show_function "$@"
  local verbosity=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_IAM_MODULE' &&
    bl64_check_privilege_root &&
    bl64_check_command "$BL64_IAM_CMD_SYSADMINCTL" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_IAM_CMD_SYSADMINCTL" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Modify local user
#
# * Wrapper for native user mod command
#
# Arguments:
#   $1: login name
#   $2: (optional) primary group. Format: group name. Default: os native
#   $3: (optional) shell. Format: full path. Default: os native
#   $4: (optional) description. Default: none
#   $5: (optional) user ID. Default: os native
# Outputs:
#   STDOUT: progress
#   STDERR: execution errors
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_iam_user_modify() {
  bl64_dbg_lib_show_function "$@"
  local login="${1:-}"
  local group="${2:-$BL64_VAR_DEFAULT}"
  local shell="${3:-$BL64_VAR_DEFAULT}"
  local gecos="${4:-$BL64_VAR_DEFAULT}"
  local uid="${5:-$BL64_VAR_DEFAULT}"

  bl64_check_parameter 'login' ||
    return $?

  bl64_msg_show_lib_subtask "modify local user account ($login)"
  bl64_lib_var_is_default "$group" && group=''
  bl64_lib_var_is_default "$shell" && shell=''
  bl64_lib_var_is_default "$gecos" && gecos=''
  bl64_lib_var_is_default "$uid" && uid=''
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_iam_run_usermod \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        "$login"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      bl64_iam_run_usermod \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        "$login"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_dbg_lib_show_comments 'force primary group creation'
      bl64_iam_run_usermod \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        "$login"
      ;;
    ${BL64_OS_ARC}-*)
      bl64_iam_run_usermod \
        ${uid:+${BL64_IAM_SET_USERADD_UID} "${uid}"} \
        ${shell:+${BL64_IAM_SET_USERADD_SHELL} "${shell}"} \
        ${group:+${BL64_IAM_SET_USERADD_GROUP} "${group}"} \
        ${geco:+${BL64_IAM_SET_USERADD_GECO} "${geco}"} \
        "$login"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Setup / Interact with Kubernetes
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_k8s_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local kubectl_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_XSV_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_k8s_set_command "$kubectl_bin" &&
    _bl64_k8s_set_version &&
    _bl64_k8s_set_options &&
    _bl64_k8s_set_runtime &&
    BL64_K8S_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'k8s'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_k8s_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_K8S_CMD_KUBECTL="$(bl64_bsh_command_import 'kubectl' "$@")"
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
function _bl64_k8s_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_K8S_VERSION_KUBECTL" in
    1.2? | 1.3?)
      BL64_K8S_SET_VERBOSE_NONE='--v=0'
      BL64_K8S_SET_VERBOSE_NORMAL='--v=2'
      BL64_K8S_SET_VERBOSE_DEBUG='--v=4'
      BL64_K8S_SET_VERBOSE_TRACE='--v=6'

      BL64_K8S_SET_OUTPUT_JSON='--output=json'
      BL64_K8S_SET_OUTPUT_YAML='--output=yaml'
      BL64_K8S_SET_OUTPUT_TXT='--output=wide'
      BL64_K8S_SET_OUTPUT_NAME='--output=name'

      BL64_K8S_SET_DRY_RUN_SERVER='--dry-run=server'
      BL64_K8S_SET_DRY_RUN_CLIENT='--dry-run=client'
      ;;
    *)
      bl64_check_compatibility_mode "k8s-api: ${BL64_K8S_VERSION_KUBECTL}" || return $?
      BL64_K8S_SET_VERBOSE_NONE='--v=0'
      BL64_K8S_SET_VERBOSE_NORMAL='--v=2'
      BL64_K8S_SET_VERBOSE_DEBUG='--v=4'
      BL64_K8S_SET_VERBOSE_TRACE='--v=6'

      BL64_K8S_SET_OUTPUT_JSON='--output=json'
      BL64_K8S_SET_OUTPUT_YAML='--output=yaml'
      BL64_K8S_SET_OUTPUT_TXT='--output=wide'
      BL64_K8S_SET_OUTPUT_NAME='--output=name'

      BL64_K8S_SET_DRY_RUN_SERVER='--dry-run=server'
      BL64_K8S_SET_DRY_RUN_CLIENT='--dry-run=client'
      ;;
  esac
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
function _bl64_k8s_set_version() {
  bl64_dbg_lib_show_function
  local cli_version=''

  bl64_dbg_lib_show_info "run kubectl to obtain client version"
  cli_version="$(_bl64_k8s_get_version_1_22)"
  bl64_dbg_lib_show_vars 'cli_version'

  if [[ -n "$cli_version" ]]; then
    BL64_K8S_VERSION_KUBECTL="$cli_version"
  else
    bl64_msg_show_lib_error 'unable to determine kubectl version'
    return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
  fi

  bl64_dbg_lib_show_vars 'BL64_K8S_VERSION_KUBECTL'
  return 0
}

function _bl64_k8s_get_version_1_22() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info "try with kubectl v1.22 options"
  # shellcheck disable=SC2086
  "$BL64_K8S_CMD_KUBECTL" version --client --output=json |
    bl64_txt_run_awk $BL64_TXT_SET_AWS_FS ':' '
    $1 ~ /^ +"major"$/ { gsub( /[" ,]/, "", $2 ); Major = $2 }
    $1 ~ /^ +"minor"$/ { gsub( /[" ,]/, "", $2 ); Minor = $2 }
    END { print Major "." Minor }
  '
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: setting errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function _bl64_k8s_set_runtime() {
  bl64_dbg_lib_show_function

  bl64_k8s_set_kubectl_output
}

#######################################
# Set default output type for kubectl
#
# * Not global, the function that needs to use the default must read the variable BL64_K8S_CFG_KUBECTL_OUTPUT
# * Not all types are supported. The calling function is reponsible for checking compatibility
#
# Arguments:
#   $1: output type. Default: json. One of BL64_K8S_CFG_KUBECTL_OUTPUT_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
# shellcheck disable=SC2120
function bl64_k8s_set_kubectl_output() {
  bl64_dbg_lib_show_function "$@"
  local output="${1:-${BL64_K8S_CFG_KUBECTL_OUTPUT_JSON}}"

  case "$output" in
    "$BL64_K8S_CFG_KUBECTL_OUTPUT_JSON") BL64_K8S_CFG_KUBECTL_OUTPUT="$BL64_K8S_SET_OUTPUT_JSON" ;;
    "$BL64_K8S_CFG_KUBECTL_OUTPUT_YAML") BL64_K8S_CFG_KUBECTL_OUTPUT="$BL64_K8S_SET_OUTPUT_YAML" ;;
    *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Interact with Kubernetes
#######################################

#######################################
# Set label on resource
#
# * Overwrite existing
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: resource type
#   $3: resource name
#   $4: label name
#   $5: label value
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_label_set() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local resource="${2:-${BL64_VAR_NULL}}"
  local name="${3:-${BL64_VAR_NULL}}"
  local key="${4:-${BL64_VAR_NULL}}"
  local value="${5:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'resource' &&
    bl64_check_parameter 'name' &&
    bl64_check_parameter 'key' &&
    bl64_check_parameter 'value' ||
    return $?

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  bl64_msg_show_lib_task "set or update label (${resource}/${name}/${key})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    'label' $verbosity \
    --overwrite \
    "$resource" \
    "$name" \
    "$key"="$value"
}

#######################################
# Set annotation on resource
#
# * Overwrite existing
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: namespace. If not required assign $BL64_VAR_NONE
#   $2: resource type
#   $3: resource name
#   $@: remaining args are passed as is. Use the syntax: key=value
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_annotation_set() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NONE}}"
  local resource="${3:-${BL64_VAR_NULL}}"
  local name="${4:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'resource' &&
    bl64_check_parameter 'name' ||
    return $?

  shift
  shift
  shift
  shift

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"
  [[ "$namespace" == "$BL64_VAR_NONE" ]] && namespace='' || namespace="--namespace ${namespace}"

  bl64_msg_show_lib_task "set or update annotation (${resource}/${name})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    'annotate' $verbosity $namespace \
    --overwrite \
    "$resource" \
    "$name" \
    "$@"
}

#######################################
# Create namespace
#
# * If already created do nothing
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: namespace name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_namespace_create() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'namespace' ||
    return $?

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  if bl64_k8s_resource_is_created "$kubeconfig" "$BL64_K8S_RESOURCE_NS" "$namespace"; then
    bl64_msg_show_lib_info "the resource is already created. No further actions are needed (namespace:${namespace})"
    return 0
  fi

  bl64_msg_show_lib_task "create namespace (${namespace})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl "$kubeconfig" \
    'create' $verbosity "$BL64_K8S_RESOURCE_NS" "$namespace"
}

#######################################
# Create service account
#
# * If already created do nothing
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: target namespace
#   $3: service account name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_sa_create() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NULL}}"
  local sa="${3:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'sa' ||
    return $?

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  if bl64_k8s_resource_is_created "$kubeconfig" "$BL64_K8S_RESOURCE_SA" "$sa" "$namespace"; then
    bl64_msg_show_lib_info "the resource is already created. No further actions are needed (service-account:${sa})"
    return 0
  fi

  bl64_msg_show_lib_task "create service account (${namespace}/${sa})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl "$kubeconfig" \
    'create' $verbosity --namespace="$namespace" "$BL64_K8S_RESOURCE_SA" "$sa"
}

#######################################
# Create generic secret from file
#
# * If already created do nothing
# * File must containe the secret value only
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: target namespace
#   $3: secret name
#   $4: secret key
#   $5: path to the file with the secret value
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_secret_create() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NULL}}"
  local secret="${3:-${BL64_VAR_NULL}}"
  local key="${4:-${BL64_VAR_NULL}}"
  local file="${5:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'secret' &&
    bl64_check_parameter 'file' &&
    bl64_check_file "$file" ||
    return $?

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  if bl64_k8s_resource_is_created "$kubeconfig" "$BL64_K8S_RESOURCE_SECRET" "$secret" "$namespace"; then
    bl64_msg_show_lib_info "the resource is already created. No further actions are needed (${BL64_K8S_RESOURCE_SECRET}:${secret})"
    return 0
  fi

  bl64_msg_show_lib_task "create generic secret (${namespace}/${secret}/${key})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl "$kubeconfig" \
    'create' $verbosity --namespace="$namespace" \
    "$BL64_K8S_RESOURCE_SECRET" 'generic' "$secret" \
    --type 'Opaque' \
    --from-file="${key}=${file}"
}

#######################################
# Copy secret between namespaces
#
# * If already created do nothing
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: source namespace
#   $3: target namespace
#   $4: secret name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_secret_copy() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace_src="${2:-${BL64_VAR_NULL}}"
  local namespace_dst="${3:-${BL64_VAR_NULL}}"
  local secret="${4:-${BL64_VAR_NULL}}"
  local resource=''
  local -i status=0

  bl64_check_parameter 'namespace_src' &&
    bl64_check_parameter 'namespace_dst' &&
    bl64_check_parameter 'secret' ||
    return $?

  if bl64_k8s_resource_is_created "$kubeconfig" "$BL64_K8S_RESOURCE_SECRET" "$secret" "$namespace_dst"; then
    bl64_msg_show_lib_info "the resource is already created. No further actions are needed (${BL64_K8S_RESOURCE_SECRET}:${secret})"
    return 0
  fi

  resource="$($BL64_FS_CMD_MKTEMP)" || return $?

  bl64_msg_show_lib_task "get secret definition from source (${namespace_src}/${secret})"
  # shellcheck disable=SC2086
  bl64_k8s_resource_get "$kubeconfig" "$BL64_K8S_RESOURCE_SECRET" "$secret" "$namespace_src" |
    bl64_txt_run_awk $BL64_TXT_SET_AWS_FS ':' '
      BEGIN { metadata = 0 }
      $1 ~ /"metadata"/ { metadata = 1 }
      metadata == 1 && $1 ~ /"namespace"/ { metadata = 0; next }
      { print $0 }
      ' >"$resource"
  status=$?

  if ((status == 0)); then
    bl64_msg_show_lib_task "copy secret to destination (${namespace_dst}/${secret})"
    bl64_k8s_resource_update "$kubeconfig" "$namespace_dst" "$resource"
    status=$?
  fi

  [[ -f "$resource" ]] && bl64_fs_file_remove "$resource"
  return "$status"
}

#######################################
# Apply updates to resources based on definition file
#
# * Overwrite
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: namespace where resources are
#   $3: full path to the resource definition file
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_resource_update() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local namespace="${2:-${BL64_VAR_NULL}}"
  local definition="${3:-${BL64_VAR_NULL}}"
  local verbosity=''

  bl64_check_parameter 'namespace' &&
    bl64_check_parameter 'definition' &&
    bl64_check_file "$definition" ||
    return $?

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_K8S_CFG_KUBECTL_OUTPUT"

  bl64_msg_show_lib_task "create or update resource definition (${definition} -> ${namespace})"
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    'apply' $verbosity \
    --namespace="$namespace" \
    --force='false' \
    --force-conflicts='false' \
    --grace-period='-1' \
    --overwrite='true' \
    --validate='strict' \
    --wait='true' \
    --filename="$definition"
}

#######################################
# Get resource definition
#
# * output type is json
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: resource type
#   $3: resource name
#   $4: namespace where resources are (optional)
# Outputs:
#   STDOUT: resource definition
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_resource_get() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local resource="${2:-${BL64_VAR_NULL}}"
  local name="${3:-${BL64_VAR_NULL}}"
  local namespace="${4:-}"

  bl64_check_parameter 'resource' &&
    bl64_check_parameter 'name' ||
    return $?

  [[ -n "$namespace" ]] && namespace="--namespace ${namespace}"

  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl \
    "$kubeconfig" \
    'get' $BL64_K8S_SET_OUTPUT_JSON \
    $namespace "$resource" "$name"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster. Use BL64_VAR_DEFAULT to leave default
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_run_kubectl() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-}"
  local verbosity="$BL64_K8S_SET_VERBOSE_NONE"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_K8S_MODULE' ||
    return $?
  shift
  bl64_check_parameters_none "$#" 'missing kubectl command' ||
    return $?

  if bl64_lib_var_is_default "$kubeconfig"; then
    kubeconfig=''
  else
    bl64_check_file "$kubeconfig" 'kubectl config file not found' ||
      return $?
    kubeconfig="--kubeconfig=${kubeconfig}"
  fi

  bl64_dbg_lib_command_is_enabled && verbosity="$BL64_K8S_SET_VERBOSE_TRACE"

  bl64_k8s_blank_kubectl
  bl64_dbg_lib_command_trace_start
  # shellcheck disable=SC2086
  "$BL64_K8S_CMD_KUBECTL" \
    $kubeconfig \
    $verbosity \
    "$@"
  bl64_dbg_lib_command_trace_stop
}

#######################################
# Command wrapper with trace option for calling kubectl plugins
#
# * Tracing is the only possible option to cover plugins as they have their own set of parameters
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster. Use BL64_VAR_DEFAULT to leave default
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_k8s_run_kubectl_plugin() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-}"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_K8S_MODULE' ||
    return $?
  shift
  bl64_check_parameters_none "$#" 'missing kubectl command' ||
    return $?

  bl64_k8s_blank_kubectl
  if [[ "$kubeconfig" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_check_file "$kubeconfig" 'kubectl config file not found' ||
      return $?
    export KUBECONFIG="$kubeconfig"
  fi

  bl64_dbg_lib_command_trace_start
  # shellcheck disable=SC2086
  "$BL64_K8S_CMD_KUBECTL" \
    "$@"
  bl64_dbg_lib_command_trace_stop
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
function bl64_k8s_blank_kubectl() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited HELM_* shell variables'
  bl64_dbg_lib_trace_start
  unset POD_NAMESPACE
  unset KUBECONFIG
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Verify that the resource is created
#
# Arguments:
#   $1: full path to the kube/config file for the target cluster
#   $2: resource type
#   $3: resource name
#   $4: namespace where resources are
# Outputs:
#   STDOUT: nothing
#   STDERR: nothing unless debug
# Returns:
#   0: resource exists
#   >0: BL64_LIB_ERROR_IS_NOT or execution error
#######################################
function bl64_k8s_resource_is_created() {
  bl64_dbg_lib_show_function "$@"
  local kubeconfig="${1:-${BL64_VAR_NULL}}"
  local type="${2:-${BL64_VAR_NULL}}"
  local name="${3:-${BL64_VAR_NULL}}"
  local namespace="${4:-}"

  bl64_check_parameter 'type' &&
    bl64_check_parameter 'name' ||
    return $?

  [[ -n "$namespace" ]] && namespace="--namespace ${namespace}"

  # shellcheck disable=SC2086
  if bl64_dbg_lib_task_is_enabled; then
    bl64_k8s_run_kubectl "$kubeconfig" \
      'get' "$type" "$name" \
      $BL64_K8S_SET_OUTPUT_NAME $namespace || return "$BL64_LIB_ERROR_IS_NOT"
  else
    bl64_k8s_run_kubectl "$kubeconfig" \
      'get' "$type" "$name" \
      $BL64_K8S_SET_OUTPUT_NAME $namespace >/dev/null 2>&1 || return "$BL64_LIB_ERROR_IS_NOT"
  fi
}

#######################################
# BashLib64 / Module / Setup / Interact with MongoDB
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_mdb_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local mdb_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FMT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_XSV_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_mdb_set_command "$mdb_bin" &&
    _bl64_mdb_set_options &&
    _bl64_mdb_set_runtime &&
    BL64_MDB_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'mdb'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_mdb_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_MDB_CMD_MONGOSH="$(bl64_bsh_command_import 'mongosh' '/opt/mongosh/bin' "$@")" &&
    BL64_MDB_CMD_MONGORESTORE="$(bl64_bsh_command_import 'mongorestore' '/opt/mongosh/bin' "$@")" &&
    BL64_MDB_CMD_MONGOEXPORT="$(bl64_bsh_command_import 'mongoexport' '/opt/mongosh/bin' "$@")"
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
function _bl64_mdb_set_options() {
  bl64_dbg_lib_show_function

  BL64_MDB_SET_VERBOSE='--verbose'
  BL64_MDB_SET_QUIET='--quiet'
  BL64_MDB_SET_NORC='--norc'
}

#######################################
# Set runtime variables
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_mdb_set_runtime() {
  bl64_dbg_lib_show_function

  # Write concern defaults
  BL64_MDB_REPLICA_WRITE='majority'
  BL64_MDB_REPLICA_TIMEOUT='1000'
}

#######################################
# BashLib64 / Module / Setup / Interact with MongoDB
#######################################

#######################################
# Restore mongodb dump
#
# * Restore user must exist on authdb and have restore permissions on the target DB
#
# Arguments:
#   $1: full path to the dump file
#   $2: target db name
#   $3: authdb name
#   $4: restore user name
#   $5: restore user password
#   $6: host where mongodb is
#   $7: mongodb tcp port
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_mdb_dump_restore() {
  bl64_dbg_lib_show_function "$@"
  local dump="${1:-${BL64_VAR_DEFAULT}}"
  local db="${2:-${BL64_VAR_DEFAULT}}"
  local authdb="${3:-${BL64_VAR_DEFAULT}}"
  local user="${4:-${BL64_VAR_DEFAULT}}"
  local password="${5:-${BL64_VAR_DEFAULT}}"
  local host="${6:-${BL64_VAR_DEFAULT}}"
  local port="${7:-${BL64_VAR_DEFAULT}}"
  local include=' '

  bl64_check_parameter 'dump' &&
    bl64_check_directory "$dump" ||
    return $?

  [[ "$db" != "$BL64_VAR_DEFAULT" ]] && include="--nsInclude=${db}.*" && db="--db=${db}" || db=' '
  [[ "$user" != "$BL64_VAR_DEFAULT" ]] && user="--username=${user}" || user=' '
  [[ "$password" != "$BL64_VAR_DEFAULT" ]] && password="--password=${password}" || password=' '
  [[ "$host" != "$BL64_VAR_DEFAULT" ]] && host="--host=${host}" || host=' '
  [[ "$port" != "$BL64_VAR_DEFAULT" ]] && port="--port=${port}" || port=' '
  [[ "$authdb" != "$BL64_VAR_DEFAULT" ]] && authdb="--authenticationDatabase=${authdb}" || authdb=' '

  # shellcheck disable=SC2086
  bl64_mdb_run_mongorestore \
    --writeConcern="{ w: '${BL64_MDB_REPLICA_WRITE}', j: true, wtimeout: ${BL64_MDB_REPLICA_TIMEOUT} }" \
    --stopOnError \
    $db \
    $include \
    $user \
    $password \
    $host \
    $port \
    $authdb \
    --dir="$dump"

}

#######################################
# Grants role to use in target DB
#
# * You must have the grantRole action on a database to grant a role on that database.
#
# Arguments:
#   $1: connection URI
#   $2: role name
#   $3: user name
#   $4: db where user and role are. Default: admin.
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_mdb_role_grant() {
  bl64_dbg_lib_show_function "$@"
  local uri="${1:-${BL64_VAR_DEFAULT}}"
  local role="${2:-${BL64_VAR_DEFAULT}}"
  local user="${3:-${BL64_VAR_DEFAULT}}"
  local db="${4:-admin}"

  bl64_check_parameter 'uri' &&
    bl64_check_parameter 'role' &&
    bl64_check_parameter 'user' ||
    return $?

  printf 'db.grantRolesToUser(
      "%s",
      [ { role: "%s", db: "%s" } ],
      { w: "%s", j: true, wtimeout: %s }
    );\n' "$user" "$role" "$db" "$BL64_MDB_REPLICA_WRITE" "$BL64_MDB_REPLICA_TIMEOUT" |
    bl64_mdb_run_mongosh "$uri"

}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $1: connection URI
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_mdb_run_mongosh_eval() {
  bl64_dbg_lib_show_function "$@"
  local uri="${1:-}"
  local verbosity="$BL64_MDB_SET_QUIET"

  shift
  bl64_check_parameters_none "$#" &&
    bl64_check_parameter 'uri' &&
    bl64_check_module 'BL64_MDB_MODULE' ||
    return $?

  bl64_dbg_lib_command_is_enabled && verbosity="$BL64_MDB_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_MDB_CMD_MONGOSH" \
    $verbosity \
    $BL64_MDB_SET_NORC \
    "$uri" \
    --eval="$*"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
# * Warning: if no command is providded the tool will stay waiting for input from STDIN
#
# Arguments:
#   $1: connection URI
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_mdb_run_mongosh() {
  bl64_dbg_lib_show_function "$@"
  local uri="${1:-${BL64_VAR_DEFAULT}}"
  local verbosity="$BL64_MDB_SET_QUIET"

  shift
  bl64_check_parameter 'uri' &&
    bl64_check_module 'BL64_MDB_MODULE' ||
    return $?

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_MDB_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_MDB_CMD_MONGOSH" \
    $verbosity \
    $BL64_MDB_SET_NORC \
    "$uri" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_mdb_run_mongorestore() {
  bl64_dbg_lib_show_function "$@"
  local verbosity="$BL64_MDB_SET_QUIET"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_MDB_MODULE' ||
    return $?

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_MDB_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_MDB_CMD_MONGORESTORE" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_mdb_run_mongoexport() {
  bl64_dbg_lib_show_function "$@"
  local verbosity="$BL64_MDB_SET_QUIET"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_MDB_MODULE' ||
    return $?

  bl64_msg_app_detail_is_enabled && verbosity="$BL64_MDB_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_MDB_CMD_MONGOEXPORT" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# BashLib64 / Module / Setup / Manage native OS packages
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_pkg_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2249
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_RXTX_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_CRYP_MODULE' &&
    _bl64_pkg_set_command &&
    _bl64_pkg_set_runtime &&
    _bl64_pkg_set_options &&
    _bl64_pkg_set_alias &&
    BL64_PKG_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'pkg'
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_pkg_set_command() {
  bl64_dbg_lib_show_function
  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    BL64_PKG_PATH_BREW_HOME='/opt/homebrew'
    BL64_PKG_CMD_BREW="${BL64_PKG_PATH_BREW_HOME}/bin/brew"
  elif [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
    BL64_PKG_PATH_BREW_HOME='/home/linuxbrew/.linuxbrew'
    BL64_PKG_CMD_BREW="${BL64_PKG_PATH_BREW_HOME}/bin/brew"
  fi
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      BL64_PKG_CMD_APT='/usr/bin/apt'
      BL64_PKG_CMD_DPKG='/usr/bin/dpkg'
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      BL64_PKG_CMD_DNF='/usr/bin/dnf'
      BL64_PKG_CMD_RPM='/usr/bin/rpm'
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      BL64_PKG_CMD_YUM='/usr/bin/yum'
      BL64_PKG_CMD_RPM='/usr/bin/rpm'
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      BL64_PKG_CMD_DNF='/usr/bin/dnf'
      BL64_PKG_CMD_RPM='/usr/bin/rpm'
      ;;
    ${BL64_OS_SLES}-*)
      BL64_PKG_CMD_ZYPPER='/usr/bin/zypper'
      BL64_PKG_CMD_RPM='/usr/bin/rpm'
      ;;
    ${BL64_OS_ALP}-*)
      BL64_PKG_CMD_APK='/sbin/apk'
      ;;
    ${BL64_OS_ARC}-*)
      BL64_PKG_CMD_PACMAN='/usr/bin/pacman'
      ;;
    ${BL64_OS_MCOS}-*)
      BL64_PKG_CMD_INSTALLER='/usr/sbin/installer'
      BL64_PKG_CMD_SOFTWAREUPDATE='/usr/sbin/softwareupdate'
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
# * BL64_PKG_SET_SLIM: used as meta flag to capture options for reducing install disk space
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_pkg_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      BL64_PKG_SET_ASSUME_YES='--assume-yes'
      BL64_PKG_SET_SLIM='--no-install-recommends'
      BL64_PKG_SET_QUIET='--quiet --quiet'
      BL64_PKG_SET_VERBOSE=' '
      ;;
    ${BL64_OS_FD}-41.* | ${BL64_OS_FD}-42.* | ${BL64_OS_FD}-43.*)
      BL64_PKG_SET_ASSUME_YES='--assumeyes'
      BL64_PKG_SET_SLIM='--no-docs'
      BL64_PKG_SET_QUIET='--quiet'
      BL64_PKG_SET_VERBOSE=' ' # Not implemented in DNF-5
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      BL64_PKG_SET_ASSUME_YES='--assumeyes'
      BL64_PKG_SET_SLIM='--nodocs'
      BL64_PKG_SET_QUIET='--quiet'
      BL64_PKG_SET_VERBOSE='--color=never --verbose'
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      BL64_PKG_SET_ASSUME_YES='--assumeyes'
      BL64_PKG_SET_SLIM=' '
      BL64_PKG_SET_QUIET='--quiet'
      BL64_PKG_SET_VERBOSE='--color=never --verbose'
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      BL64_PKG_SET_ASSUME_YES='--assumeyes'
      BL64_PKG_SET_SLIM='--nodocs'
      BL64_PKG_SET_QUIET='--quiet'
      BL64_PKG_SET_VERBOSE='--color=never --verbose'
      ;;
    ${BL64_OS_SLES}-*)
      BL64_PKG_SET_ASSUME_YES='--no-confirm'
      BL64_PKG_SET_SLIM=' '
      BL64_PKG_SET_QUIET='--quiet'
      BL64_PKG_SET_VERBOSE='--verbose'
      ;;
    ${BL64_OS_ALP}-*)
      BL64_PKG_SET_ASSUME_YES=' '
      BL64_PKG_SET_SLIM=' '
      BL64_PKG_SET_QUIET='--quiet'
      BL64_PKG_SET_VERBOSE='--verbose'
      ;;
    ${BL64_OS_ARC}-*)
      BL64_PKG_SET_ASSUME_YES='--noconfirm'
      BL64_PKG_SET_SLIM=' '
      BL64_PKG_SET_QUIET='--quiet'
      BL64_PKG_SET_VERBOSE='--verbose'
      ;;
    ${BL64_OS_MCOS}-*) : ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_pkg_set_alias() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      BL64_PKG_ALIAS_DNF_CACHE="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} makecache"
      BL64_PKG_ALIAS_DNF_INSTALL="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_SLIM} ${BL64_PKG_SET_ASSUME_YES} install"
      BL64_PKG_ALIAS_DNF_CLEAN="$BL64_PKG_CMD_DNF clean all"
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      BL64_PKG_ALIAS_YUM_CACHE="$BL64_PKG_CMD_YUM ${BL64_PKG_SET_VERBOSE} makecache"
      BL64_PKG_ALIAS_YUM_INSTALL="$BL64_PKG_CMD_YUM ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_ASSUME_YES} install"
      BL64_PKG_ALIAS_YUM_CLEAN="$BL64_PKG_CMD_YUM clean all"
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      BL64_PKG_ALIAS_DNF_CACHE="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} makecache"
      BL64_PKG_ALIAS_DNF_INSTALL="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_SLIM} ${BL64_PKG_SET_ASSUME_YES} install"
      BL64_PKG_ALIAS_DNF_CLEAN="$BL64_PKG_CMD_DNF clean all"
      ;;
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      BL64_PKG_ALIAS_APT_CACHE="$BL64_PKG_CMD_APT update"
      BL64_PKG_ALIAS_APT_INSTALL="$BL64_PKG_CMD_APT install ${BL64_PKG_SET_ASSUME_YES} ${BL64_PKG_SET_VERBOSE}"
      BL64_PKG_ALIAS_APT_CLEAN="$BL64_PKG_CMD_APT clean"
      ;;
    ${BL64_OS_SLES}-*) : ;;
    ${BL64_OS_ALP}-*)
      BL64_PKG_ALIAS_APK_CACHE="$BL64_PKG_CMD_APK update ${BL64_PKG_SET_VERBOSE}"
      BL64_PKG_ALIAS_APK_INSTALL="$BL64_PKG_CMD_APK add ${BL64_PKG_SET_VERBOSE}"
      BL64_PKG_ALIAS_APK_CLEAN="$BL64_PKG_CMD_APK cache clean ${BL64_PKG_SET_VERBOSE}"
      ;;
    ${BL64_OS_ARC}-*) : ;;
    ${BL64_OS_MCOS}-*)
      BL64_PKG_ALIAS_BRW_CACHE="$BL64_PKG_CMD_BREW update ${BL64_PKG_SET_VERBOSE}"
      BL64_PKG_ALIAS_BRW_INSTALL="$BL64_PKG_CMD_BREW install ${BL64_PKG_SET_VERBOSE}"
      BL64_PKG_ALIAS_BRW_CLEAN="$BL64_PKG_CMD_BREW cleanup ${BL64_PKG_SET_VERBOSE} --prune=all -s"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: setting errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function _bl64_pkg_set_runtime() {
  bl64_dbg_lib_show_function
  bl64_pkg_set_paths
}

#######################################
# Set and prepare module paths
#
# * Global paths only
# * If preparation fails the whole module fails
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
# shellcheck disable=SC2120
function bl64_pkg_set_paths() {
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      BL64_PKG_PATH_YUM_REPOS_D='/etc/yum.repos.d'
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      BL64_PKG_PATH_YUM_REPOS_D='/etc/yum.repos.d'
      ;;
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      BL64_PKG_PATH_APT_SOURCES_LIST_D='/etc/apt/sources.list.d'
      BL64_PKG_PATH_GPG_KEYRINGS='/usr/share/keyrings'
      ;;
    ${BL64_OS_SLES}-*) : ;;
    ${BL64_OS_ALP}-*) : ;;
    ${BL64_OS_ARC}-*) : ;;
    ${BL64_OS_MCOS}-*) : ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Manage native OS packages
#######################################

#######################################
# Add package repository
#
# * Covers simple uses cases that can be applied to most OS versions:
#   * YUM: repo package definition created
#   * APT: repo package definition created, GPGkey downloaded and installed
# * Package cache is not refreshed
# * No replacement done if already present
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   $1: repository name. Format: alphanumeric, _-
#   $2: repository source. Format: URL
#   $3: GPGKey source. Format: URL. Default: $BL64_VAR_NONE
#   $4: extra package specific parameter. For APT: suite. Default: empty
#   $5: extra package specific parameter. For APT: component. Default: empty
#
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   package manager exit status
#######################################
function bl64_pkg_repository_add() {
  bl64_dbg_lib_show_function "$@"
  local name="${1:-}"
  local source="${2:-}"
  local gpgkey="${3:-${BL64_VAR_NONE}}"
  local extra1="${4:-}"
  local extra2="${5:-}"

  bl64_check_privilege_root &&
    bl64_check_parameter 'name' &&
    bl64_check_parameter 'source' ||
    return $?

  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      _bl64_pkg_repository_add_apt "$name" "$source" "$gpgkey" "$extra1" "$extra2"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      _bl64_pkg_repository_add_yum "$name" "$source" "$gpgkey"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function _bl64_pkg_repository_add_yum() {
  bl64_dbg_lib_show_function "$@"
  local name="$1"
  local source="$2"
  local gpgkey="$3"
  local definition=''
  local file_mode='0644'

  bl64_check_directory "$BL64_PKG_PATH_YUM_REPOS_D" ||
    return $?

  definition="${BL64_PKG_PATH_YUM_REPOS_D}/${name}.${BL64_PKG_DEF_SUFIX_YUM_REPOSITORY}"
  [[ -f "$definition" ]] &&
    bl64_msg_show_warning "requested repository is already present. Continue using existing one. (${definition})" &&
    return 0

  bl64_msg_show_lib_subtask "create YUM repository definition (${definition})"
  if [[ "$gpgkey" != "$BL64_VAR_NONE" ]]; then
    printf '[%s]\n
name=%s
baseurl=%s
gpgcheck=1
enabled=1
gpgkey=%s\n' \
      "$name" \
      "$name" \
      "$source" \
      "$gpgkey" \
      >"$definition"
  else
    printf '[%s]\n
name=%s
baseurl=%s
gpgcheck=0
enabled=1\n' \
      "$name" \
      "$name" \
      "$source" \
      >"$definition"
  fi
  [[ -f "$definition" ]] && bl64_fs_run_chmod "$file_mode" "$definition"
}

function _bl64_pkg_repository_add_apt() {
  bl64_dbg_lib_show_function "$@"
  local name="$1"
  local source="$2"
  local gpgkey="$3"
  local suite="$4"
  local component="$5"
  local definition=''
  local gpgkey_file=''
  local file_mode='0644'

  bl64_check_parameter 'suite' &&
    bl64_check_directory "$BL64_PKG_PATH_APT_SOURCES_LIST_D" &&
    bl64_check_directory "$BL64_PKG_PATH_GPG_KEYRINGS" ||
    return $?

  definition="${BL64_PKG_PATH_APT_SOURCES_LIST_D}/${name}.${BL64_PKG_DEF_SUFIX_APT_REPOSITORY}"
  [[ -f "$definition" ]] &&
    bl64_msg_show_warning "requested repository is already present. Continue using existing one. (${definition})" &&
    return 0

  bl64_msg_show_lib_subtask "create APT repository definition (${definition})"
  if [[ "$gpgkey" != "$BL64_VAR_NONE" ]]; then
    gpgkey_file="${BL64_PKG_PATH_GPG_KEYRINGS}/${name}.${BL64_PKG_DEF_SUFIX_GPG_FILE}"
    printf 'deb [signed-by=%s] %s %s %s\n' \
      "$gpgkey_file" \
      "$source" \
      "$suite" \
      "$component" \
      >"$definition" &&
      bl64_cryp_key_download \
        "$gpgkey" "$gpgkey_file" "$BL64_VAR_DEFAULT" "$file_mode"
  else
    printf 'deb %s %s %s\n' \
      "$source" \
      "$suite" \
      "$component" \
      >"$definition"
  fi
  [[ -f "$definition" ]] && bl64_fs_run_chmod "$file_mode" "$definition"
}

#######################################
# Refresh package repository
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_repository_refresh() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_subtask 'refresh package repository content'
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apt 'update'
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf 'makecache'
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_check_privilege_root &&
        bl64_pkg_run_yum 'makecache'
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf 'makecache'
      ;;
    ${BL64_OS_SLES}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_zypper 'refresh'
      ;;
    ${BL64_OS_ALP}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apk 'update'
      ;;
    ${BL64_OS_ARC}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_pacman --sync --refresh
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_pkg_brew_repository_refresh
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function bl64_pkg_brew_repository_refresh() {
  bl64_dbg_lib_show_function
  bl64_msg_show_lib_subtask 'refresh package repository content'
  bl64_pkg_run_brew 'update'
}

#######################################
# Deploy packages
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
function bl64_pkg_deploy() {
  bl64_dbg_lib_show_function "$@"
  bl64_pkg_prepare &&
    bl64_pkg_install "$@" &&
    bl64_pkg_upgrade "$@" &&
    bl64_pkg_cleanup
}

function bl64_pkg_brew_deploy() {
  bl64_dbg_lib_show_function "$@"
  bl64_pkg_brew_prepare &&
    bl64_pkg_brew_install "$@" &&
    bl64_pkg_brew_upgrade "$@" &&
    bl64_pkg_brew_cleanup
}

#######################################
# Initialize the package manager for installations
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_prepare() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_subtask 'initialize package manager'
  bl64_pkg_repository_refresh
}

function bl64_pkg_brew_prepare() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_subtask 'initialize package manager'
  bl64_pkg_brew_repository_refresh
}

#######################################
# Install packages
#
# * Assume yes
# * Avoid installing docs (man) when possible
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_install() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none $# || return $?

  bl64_msg_show_lib_subtask "install packages (${*})"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apt 'install' $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES -- "$@"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' "$@"
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_check_privilege_root &&
        bl64_pkg_run_yum $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' "$@"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_zypper 'install' $BL64_PKG_SET_ASSUME_YES -- "$@"
      ;;
    ${BL64_OS_ALP}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apk 'add' -- "$@"
      ;;
    ${BL64_OS_ARC}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_pacman --sync $BL64_PKG_SET_ASSUME_YES "$@"
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_pkg_brew_install "$@"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function bl64_pkg_brew_install() {
  bl64_dbg_lib_show_function "$@"
  bl64_pkg_run_brew 'install' "$@"
}

#######################################
# Upgrade packages
#
# * Assume yes
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
# shellcheck disable=SC2120
function bl64_pkg_upgrade() {
  bl64_dbg_lib_show_function "$@"

  bl64_msg_show_lib_subtask "upgrade packages${*:+ (${*})}"

  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apt 'upgrade' $BL64_PKG_SET_ASSUME_YES "$@"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' "$@"
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_check_privilege_root &&
        bl64_pkg_run_yum $BL64_PKG_SET_ASSUME_YES 'upgrade' "$@"
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' "$@"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_zypper 'update' $BL64_PKG_SET_ASSUME_YES "$@"
      ;;
    ${BL64_OS_ALP}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apk 'upgrade' "$@"
      ;;
    ${BL64_OS_ARC}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_pacman --sync $BL64_PKG_SET_ASSUME_YES "$@"
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_pkg_brew_upgrade "$@"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function bl64_pkg_brew_upgrade() {
  bl64_dbg_lib_show_function "$@"
  bl64_pkg_run_brew 'upgrade' "$@"
}

#######################################
# Clean up the package manager run-time environment
#
# * Warning: removes cache contents
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_cleanup() {
  bl64_dbg_lib_show_function
  local target=''

  bl64_msg_show_lib_subtask 'clean up package manager run-time environment'
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apt 'clean'
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf 'clean' 'all'
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_check_privilege_root &&
        bl64_pkg_run_yum 'clean' 'all'
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf 'clean' 'all'
      ;;
    ${BL64_OS_SLES}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_zypper 'clean' '--all'
      ;;
    ${BL64_OS_ALP}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apk 'cache' 'clean'
      target='/var/cache/apk'
      if [[ -d "$target" ]]; then
        bl64_fs_path_remove ${target}/[[:alpha:]]*
      fi
      ;;
    ${BL64_OS_ARC}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_pacman --sync --clean --clean
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_pkg_brew_cleanup
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function bl64_pkg_brew_cleanup() {
  bl64_dbg_lib_show_function
  bl64_pkg_run_brew 'cleanup' \
    --prune=all \
    -s
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_dnf() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_PKG_SET_QUIET"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_DNF" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_yum() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_PKG_SET_QUIET"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_YUM" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_apt() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  _bl64_pkg_harden_apt

  # Verbose is only available for a subset of commands
  if bl64_msg_app_run_is_enabled && [[ "$*" =~ (install|upgrade|remove) ]]; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    export DEBCONF_NOWARNINGS='yes'
    export DEBCONF_TERSE='yes'
    verbose="$BL64_PKG_SET_QUIET"
  fi

  # Avoid interactive questions
  export DEBIAN_FRONTEND="noninteractive"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_APT" $verbose "$@"
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
function _bl64_pkg_harden_apt() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited DEB* shell variables'
  bl64_dbg_lib_trace_start
  unset DEBIAN_FRONTEND
  unset DEBCONF_TERSE
  unset DEBCONF_NOWARNINGS
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_apk() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_PKG_SET_QUIET"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_APK" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_brew() {
  bl64_dbg_lib_show_function "$@"
  local verbose='--quiet'

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_command "$BL64_PKG_CMD_BREW" &&
    bl64_check_parameters_none "$#" &&
    bl64_check_privilege_not_root ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose='--verbose'

  export HOMEBREW_PREFIX="$BL64_PKG_PATH_BREW_HOME"
  export HOMEBREW_CELLAR="${BL64_PKG_PATH_BREW_HOME}/Cellar"
  export HOMEBREW_REPOSITORY="${BL64_PKG_PATH_BREW_HOME}/Homebrew"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_BREW" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_zypper() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_PKG_SET_QUIET"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_ZYPPER" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_rpm() {
  bl64_dbg_lib_show_function "$@"
  local verbose='--quiet'

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose='--verbose'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_RPM" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_dpkg() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_PKG_CMD_DPKG" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_installer() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose='-verbose'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_INSTALLER" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_softwareupdate() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_PKG_CMD_SOFTWAREUPDATE" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_pkg_run_pacman() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_PACMAN" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

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

#######################################
# BashLib64 / Module / Setup / Manage role based access service
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_rbac_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_IAM_MODULE' &&
    _bl64_rbac_set_command &&
    _bl64_rbac_set_options &&
    _bl64_rbac_set_alias &&
    BL64_RBAC_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'rbac'
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_rbac_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
      BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
      BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
      BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
      BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
      ;;
    ${BL64_OS_SLES}-*)
      BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
      BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
      BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
      ;;
    ${BL64_OS_ALP}-*)
      BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
      BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
      BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
      ;;
    ${BL64_OS_ARC}-*)
      BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
      BL64_RBAC_CMD_VISUDO='/usr/bin/visudo'
      BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
      ;;
    ${BL64_OS_MCOS}-*)
      BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
      BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
      BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_rbac_set_alias() {
  bl64_dbg_lib_show_function
  BL64_RBAC_ALIAS_SUDO_ENV="$BL64_RBAC_CMD_SUDO --preserve-env --set-home"
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
function _bl64_rbac_set_options() {
  bl64_dbg_lib_show_function
  BL64_RBAC_SET_SUDO_CHECK='--check'
  BL64_RBAC_SET_SUDO_FILE='--file'
  BL64_RBAC_SET_SUDO_QUIET='--quiet'
}

#######################################
# BashLib64 / Module / Functions / Manage role based access service
#######################################

#
# Private functions
#

function _bl64_rbac_add_root() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local new_file="${BL64_RBAC_FILE_SUDOERS}-TMP"

  bl64_msg_show_lib_subtask "modify sudoers file (${BL64_RBAC_FILE_SUDOERS})"
  # shellcheck disable=SC2016
  bl64_txt_run_awk \
    -v ControlUsr="$user" \
    '
      BEGIN { Found = 0 }
      ControlUsr " ALL=(ALL) NOPASSWD: ALL" == $0 { Found = 1 }
      { print $0 }
      END {
        if( Found == 0) {
          print( ControlUsr " ALL=(ALL) NOPASSWD: ALL" )
        }
      }
    ' \
    "$BL64_RBAC_FILE_SUDOERS" >"$new_file" &&
    bl64_os_run_cat "$new_file" >"$BL64_RBAC_FILE_SUDOERS" &&
    bl64_fs_file_remove "$new_file"
}

#
# Public functions
#

#######################################
# Add password-less root privilege
#
# Arguments:
#   $1: user name. User must already be present.
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: rule added
#   >0: failed command exit status
#######################################
function bl64_rbac_add_root() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local -i status=0

  bl64_check_privilege_root &&
    bl64_check_parameter 'user' ||
    return $?

  bl64_msg_show_lib_task "add sudoers password-less root privilege for user (${user})"
  umask 0266

  if [[ -s "$BL64_RBAC_FILE_SUDOERS" ]]; then
      bl64_fs_file_backup "$BL64_RBAC_FILE_SUDOERS" &&
      _bl64_rbac_add_root "$user" &&
      bl64_fs_file_restore "$BL64_RBAC_FILE_SUDOERS" $?
  else
    printf '%s ALL=(ALL) NOPASSWD: ALL\n' "$user" >"$BL64_RBAC_FILE_SUDOERS"
  fi
  # shellcheck disable=SC2181
  (($? == 0)) && bl64_rbac_check_sudoers "$BL64_RBAC_FILE_SUDOERS"
}

#######################################
# Use visudo --check to validate sudoers file
#
# Arguments:
#   $1: full path to the sudoers file
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: sudoers sintax ok
#   visudo exit status
#######################################
function bl64_rbac_check_sudoers() {
  bl64_dbg_lib_show_function "$@"
  local sudoers="$1"
  local -i status=0
  local debug="$BL64_RBAC_SET_SUDO_QUIET"

  bl64_check_parameter 'sudoers' &&
    bl64_check_command "$BL64_RBAC_CMD_VISUDO" ||
    return $?
  bl64_dbg_lib_command_is_enabled && debug=' '

  bl64_msg_show_lib_subtask "check sudoers file integrity (${sudoers})"
  # shellcheck disable=SC2086
  "$BL64_RBAC_CMD_VISUDO" \
    $debug \
    $BL64_RBAC_SET_SUDO_CHECK \
    ${BL64_RBAC_SET_SUDO_FILE}="$sudoers"
  status=$?

  if ((status != 0)); then
    bl64_msg_show_check "the sudoers file is corrupt or invalid ($sudoers)"
  fi

  return "$status"
}

#######################################
# Run privileged OS command using Sudo if needed
#
# Arguments:
#   $1: user to run as. Default: root
#   $@: command and arguments to run
# Outputs:
#   STDOUT: command or sudo output
#   STDERR: command or sudo error
# Returns:
#   command or sudo exit status
#######################################
function bl64_rbac_run_command() {
  bl64_dbg_lib_show_function "$@"
  local user="${1:-${BL64_VAR_NULL}}"
  local target=''

  bl64_check_parameter 'user' &&
    bl64_check_command "$BL64_RBAC_CMD_SUDO" ||
    return $?

  shift
  bl64_check_parameters_none "$#" ||
    return $?
  target="$(bl64_iam_user_get_id "${user}")" || return $?

  if [[ "$UID" == "$target" ]]; then
    bl64_dbg_lib_show_info "run command directly (user: $user)"
    bl64_dbg_lib_trace_start
    "$@"
    bl64_dbg_lib_trace_stop
  else
    bl64_dbg_lib_show_info "run command with sudo (user: $user)"
    bl64_dbg_lib_trace_start
    $BL64_RBAC_ALIAS_SUDO_ENV -u "$user" "$@"
    bl64_dbg_lib_trace_stop
  fi
}

#######################################
# Run privileged Bash function using Sudo if needed
#
# Arguments:
#   $1: library that contains the target function.
#   $2: user to run as. Default: root
#   $@: command and arguments to run
# Outputs:
#   STDOUT: command or sudo output
#   STDERR: command or sudo error
# Returns:
#   command or sudo exit status
#######################################
function bl64_rbac_run_bash_function() {
  bl64_dbg_lib_show_function "$@"
  local library="${1:-${BL64_VAR_NULL}}"
  local user="${2:-${BL64_VAR_NULL}}"
  local target=''

  bl64_check_parameter 'library' &&
    bl64_check_parameter 'user' &&
    bl64_check_file "$library" &&
    bl64_check_command "$BL64_RBAC_CMD_SUDO" ||
    return $?

  shift
  shift
  bl64_check_parameters_none "$#" ||
    return $?

  target="$(bl64_iam_user_get_id "${user}")" || return $?

  if [[ "$UID" == "$target" ]]; then
    # shellcheck disable=SC1090
    . "$library" &&
      "$@"
  else
    bl64_dbg_lib_trace_start
    $BL64_RBAC_ALIAS_SUDO_ENV -u "$user" "$BL64_OS_CMD_BASH" -c ". ${library}; ${*}"
    bl64_dbg_lib_trace_stop
  fi
}

#######################################
# BashLib64 / Module / Setup / Generate random data
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_rnd_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    BL64_RND_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'rnd'
}

#######################################
# BashLib64 / Module / Functions / Generate random data
#######################################

#######################################
# Generate random integer number between min and max
#
# Arguments:
#   $1: Minimum. Default: BL64_RND_RANDOM_MIN
#   $2: Maximum. Default: BL64_RND_RANDOM_MAX
# Outputs:
#   STDOUT: random number
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_LIB_ERROR_PARAMETER_RANGE
#   BL64_LIB_ERROR_PARAMETER_RANGE
#######################################
function bl64_rnd_get_range() {
  bl64_dbg_lib_show_function "$@"
  local min="${1:-${BL64_RND_RANDOM_MIN}}"
  local max="${2:-${BL64_RND_RANDOM_MAX}}"
  local modulo=0

  # shellcheck disable=SC2086
  ((min < BL64_RND_RANDOM_MIN)) &&
    bl64_msg_show_lib_error "length can not be less than $BL64_RND_RANDOM_MIN" && return "$BL64_LIB_ERROR_PARAMETER_RANGE"
  # shellcheck disable=SC2086
  ((max > BL64_RND_RANDOM_MAX)) &&
    bl64_msg_show_lib_error "length can not be greater than $BL64_RND_RANDOM_MAX" && return "$BL64_LIB_ERROR_PARAMETER_RANGE"

  modulo=$((max - min + 1))

  printf '%s' "$((min + (RANDOM % modulo)))"
}

#######################################
# Generate numeric string
#
# Arguments:
#   $1: Length. Default: BL64_RND_LENGTH_1
# Outputs:
#   STDOUT: random string
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_LIB_ERROR_PARAMETER_RANGE
#   BL64_LIB_ERROR_PARAMETER_RANGE
#######################################
# shellcheck disable=SC2120
function bl64_rnd_get_numeric() {
  bl64_dbg_lib_show_function "$@"
  local -i length=${1:-${BL64_RND_LENGTH_1}}
  local seed=''

  # shellcheck disable=SC2086
  ((length < BL64_RND_LENGTH_1)) &&
    bl64_msg_show_lib_error "length can not be less than $BL64_RND_LENGTH_1" && return "$BL64_LIB_ERROR_PARAMETER_RANGE"
  # shellcheck disable=SC2086
  ((length > BL64_RND_LENGTH_20)) &&
    bl64_msg_show_lib_error "length can not be greater than $BL64_RND_LENGTH_20" && return "$BL64_LIB_ERROR_PARAMETER_RANGE"

  seed="${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
  printf '%s' "${seed:0:$length}"
}

#######################################
# Generate alphanumeric string
#
# Arguments:
#   $1: Minimum. Default: BL64_RND_RANDOM_MIN
#   $2: Maximum. Default: BL64_RND_RANDOM_MAX
# Outputs:
#   STDOUT: random string
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_LIB_ERROR_PARAMETER_RANGE
#   BL64_LIB_ERROR_PARAMETER_RANGE
#######################################
function bl64_rnd_get_alphanumeric() {
  bl64_dbg_lib_show_function "$@"
  local -i length=${1:-${BL64_RND_LENGTH_1}}
  local output=''
  local item=''
  local index=0
  local count=0

  ((length < BL64_RND_LENGTH_1)) &&
    bl64_msg_show_lib_error "length can not be less than $BL64_RND_LENGTH_1" && return "$BL64_LIB_ERROR_PARAMETER_RANGE"
  ((length > BL64_RND_LENGTH_100)) &&
    bl64_msg_show_lib_error "length can not be greater than $BL64_RND_LENGTH_100" && return "$BL64_LIB_ERROR_PARAMETER_RANGE"

  while ((count < length)); do
    index=$(bl64_rnd_get_range '0' "$BL64_RND_POOL_ALPHANUMERIC_MAX_IDX")
    item="$(printf '%s' "${BL64_RND_POOL_ALPHANUMERIC:$index:1}")"
    output="${output}${item}"
    ((count++))
  done

  printf '%s' "$output"
}

#######################################
# BashLib64 / Module / Setup / Transfer and Receive data over the network
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_rxtx_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_VCS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_rxtx_set_command &&
    _bl64_rxtx_set_options &&
    _bl64_rxtx_set_alias &&
    BL64_RXTX_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'rxtx'
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_rxtx_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_ARC}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET="$BL64_VAR_INCOMPATIBLE"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_rxtx_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-18.* | ${BL64_OS_DEB}-9.* | ${BL64_OS_DEB}-10.*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS='--no-progress-meter'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS='--no-progress-meter'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='-O'
    BL64_RXTX_SET_WGET_SECURE=' '
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_ARC}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS=' '
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_SET_CURL_FAIL='--fail'
    BL64_RXTX_SET_CURL_HEADER='-H'
    BL64_RXTX_SET_CURL_INCLUDE='--include'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_NO_PROGRESS='--no-progress-meter'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_CURL_REQUEST='-X'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT=' '
    BL64_RXTX_SET_WGET_SECURE=' '
    BL64_RXTX_SET_WGET_VERBOSE=' '
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_rxtx_set_alias() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_ARC}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET=''
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Transfer and Receive data over the network
#######################################

#######################################
# Pull data from web server
#
# * If the destination is already present no update is done unless $3=$BL64_VAR_ON
#
# Arguments:
#   $1: Source URL
#   $2: Full path to the destination file
#   $3: replace existing file. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $4: file permissions. Format: chown format. Default: use current umask
#   $5: file user name. Default: current
#   $6: file group name. Default: current
# Outputs:
#   STDOUT: None unless BL64_DBG_TARGET_LIB_CMD
#   STDERR: command error
# Returns:
#   BL64_LIB_ERROR_APP_MISSING
#   command error status
#######################################
function bl64_rxtx_web_get_file() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local replace="${3:-${BL64_VAR_DEFAULT}}"
  local file_mode="${4:-${BL64_VAR_DEFAULT}}"
  local file_user="${5:-${BL64_VAR_DEFAULT}}"
  local file_group="${6:-${BL64_VAR_DEFAULT}}"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_fs_check_new_file "$destination" ||
    return $?

  bl64_check_overwrite_skip "$destination" "$replace" && return

  bl64_fs_path_archive "$destination" >/dev/null || return $?

  bl64_msg_show_lib_subtask "download file (${source})"
  # shellcheck disable=SC2086
  if [[ -x "$BL64_RXTX_CMD_CURL" ]]; then
    bl64_rxtx_run_curl \
      $BL64_RXTX_SET_CURL_FAIL \
      $BL64_RXTX_SET_CURL_REDIRECT \
      $BL64_RXTX_SET_CURL_OUTPUT "$destination" \
      "$source"
    status=$?
  elif [[ -x "$BL64_RXTX_CMD_WGET" ]]; then
    bl64_rxtx_run_wget \
      $BL64_RXTX_SET_WGET_OUTPUT "$destination" \
      "$source"
    status=$?
  else
    bl64_msg_show_lib_error "no web transfer command was found on the system (wget or curl)" &&
      return "$BL64_LIB_ERROR_APP_MISSING"
  fi

  if ((status != 0)); then
    bl64_msg_show_lib_error 'file download failed'
  else
    bl64_fs_path_permission_set "$file_mode" "$BL64_VAR_DEFAULT" "$file_user" "$file_group" "$BL64_VAR_OFF" "$destination"
    status=$?
  fi

  bl64_fs_path_recover "$destination" "$status" || return $?
  return "$status"
}

#######################################
# Pull directory contents from git repo
#
# * Content of source path is downloaded into destination (source_path/* --> destionation/). Source path itself is not created
# * If the destination is already present no update is done unless $4=$BL64_VAR_ON
# * If asked to replace destination, temporary backup is done in case git fails by moving the destination to a temp name
# * Warning: git repo info is removed after pull (.git)
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: source path. Format: relative to the repo URL. Use '.' to download the full repo
#   $3: destination path. Format: full path
#   $4: replace existing content. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $5: branch name. Default: main
# Outputs:
#   STDOUT: command stdout
#   STDERR: command error
# Returns:
#   0: operation OK
#   BL64_LIB_ERROR_TASK_TEMP
#   command error status
#######################################
function bl64_rxtx_git_get_dir() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local replace="${4:-${BL64_VAR_DEFAULT}}"
  local branch="${5:-main}"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'source_url' &&
    bl64_check_parameter 'source_path' &&
    bl64_check_parameter 'destination' &&
    bl64_check_path_relative "$source_path" &&
    bl64_fs_check_new_dir "$destination" ||
    return $?

  # shellcheck disable=SC2086
  bl64_check_overwrite_skip "$destination" "$replace" && return $?
  bl64_fs_path_archive "$destination" || return $?

  bl64_msg_show_lib_subtask "clone source repository (${source_url})"
  if [[ "$source_path" == '.' || "$source_path" == './' ]]; then
    _bl64_rxtx_git_get_dir_root "$source_url" "$destination" "$branch"
  else
    _bl64_rxtx_git_get_dir_sub "$source_url" "$source_path" "$destination" "$branch"
  fi
  status=$?
  ((status != 0)) && bl64_msg_show_lib_error 'directory download failed'

  if [[ "$status" == '0' && -d "${destination}/.git" ]]; then
    bl64_msg_show_lib_subtask "remove git metadata (${destination}/.git)"
    bl64_bsh_run_pushd "$destination" &&
      bl64_fs_path_remove '.git' &&
      bl64_bsh_run_popd
    status=$?
  fi

  bl64_fs_path_recover "$destination" "$status" || return $?
  return "$status"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * verbose is not implemented to avoid unintentional alteration of output when using for APIs
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
function bl64_rxtx_run_curl() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_RXTX_SET_CURL_SILENT"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_command "$BL64_RXTX_CMD_CURL" || return $?

  bl64_msg_app_run_is_enabled && verbose=''
  bl64_dbg_lib_command_is_enabled && verbose="$BL64_RXTX_SET_CURL_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_RXTX_CMD_CURL" \
    $BL64_RXTX_SET_CURL_SECURE \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_rxtx_run_wget() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_command "$BL64_RXTX_CMD_WGET" || return $?

  bl64_dbg_lib_command_is_enabled &&
    verbose="$BL64_RXTX_SET_WGET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_RXTX_CMD_WGET" \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

function _bl64_rxtx_git_get_dir_root() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local destination="${2}"
  local branch="${3:-main}"
  local -i status=0
  local repo=''
  local git_name=''
  local transition=''

  bl64_check_module 'BL64_RXTX_MODULE' || return $?

  repo="$($BL64_FS_ALIAS_MKTEMP_DIR)"
  bl64_check_directory "$repo" 'unable to create temporary git repo' || return "$BL64_LIB_ERROR_TASK_TEMP"

  git_name="$(bl64_fmt_path_get_basename "$source_url")"
  git_name="${git_name/.git/}"
  transition="${repo}/${git_name}"
  bl64_dbg_lib_show_vars 'git_name' 'transition'

  bl64_dbg_lib_show_comments 'Clone the repo'
  bl64_vcs_git_clone "$source_url" "$repo" "$branch" &&
    bl64_dbg_lib_show_info 'promote to destination' &&
    bl64_fs_run_mv "$transition" "$destination"
  status=$?

  [[ -d "$repo" ]] && bl64_fs_path_remove "$repo" >/dev/null
  return "$status"
}

function _bl64_rxtx_git_get_dir_sub() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local branch="${4:-main}"
  local -i status=0
  local repo=''
  local target=''
  local source=''
  local transition=''

  bl64_check_module 'BL64_RXTX_MODULE' || return $?

  repo="$($BL64_FS_ALIAS_MKTEMP_DIR)"
  # shellcheck disable=SC2086
  bl64_check_directory "$repo" 'unable to create temporary git repo' || return "$BL64_LIB_ERROR_TASK_TEMP"

  bl64_dbg_lib_show_comments 'Use transition path to get to the final target path'
  source="${repo}/${source_path}"
  target="$(bl64_fmt_path_get_basename "$destination")"
  transition="${repo}/transition/${target}"
  bl64_dbg_lib_show_vars 'source' 'target' 'transition'

  bl64_vcs_git_sparse "$source_url" "$repo" "$branch" "$source_path" &&
    [[ -d "$source" ]] &&
    bl64_fs_mkdir_full "${repo}/transition" &&
    bl64_fs_run_mv "$source" "$transition" >/dev/null &&
    bl64_fs_run_mv "${transition}" "$destination" >/dev/null
  status=$?

  [[ -d "$repo" ]] && bl64_fs_path_remove "$repo" >/dev/null
  return "$status"
}

#######################################
# Download file asset from release in github repository
#
# Arguments:
#   $1: repo owner
#   $2: repo name
#   $3: release tag. Use $BL64_VCS_GITHUB_LATEST (latest) to obtain latest version
#   $4: asset name: file name available in the target release
#   $5: destination
#   $6: replace existing content Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $7: permissions. Regular chown format accepted. Default: umask defined
# Outputs:
#   STDOUT: none
#   STDERR: task error
# Returns:
#   0: success
#   >0: error
#######################################
function bl64_rxtx_github_get_asset() {
  bl64_dbg_lib_show_function "$@"
  local repo_owner="$1"
  local repo_name="$2"
  local release_tag="$3"
  local asset_name="$4"
  local destination="$5"
  local replace="${6:-${BL64_VAR_OFF}}"
  local mode="${7:-${BL64_VAR_DEFAULT}}"

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'repo_owner' &&
    bl64_check_parameter 'repo_name' &&
    bl64_check_parameter 'release_tag' &&
    bl64_check_parameter 'asset_name' &&
    bl64_check_parameter 'destination' ||
    return $?

  if [[ "$release_tag" == "$BL64_VCS_GITHUB_LATEST" ]]; then
    release_tag="$(bl64_vcs_github_release_get_latest "$repo_owner" "$repo_name")" ||
      return $?
  fi

  bl64_rxtx_web_get_file \
    "${BL64_RXTX_GITHUB_URL}/${repo_owner}/${repo_name}/releases/download/${release_tag}/${asset_name}" \
    "$destination" "$replace" "$mode"
}

#######################################
# BashLib64 / Module / Setup / Interact with Terraform
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_tf_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local terraform_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_tf_set_command "$terraform_bin" &&
    _bl64_tf_set_version &&
    _bl64_tf_set_options &&
    _bl64_tf_set_resources &&
    BL64_TF_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'tf'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: detection errors
# Returns:
#   0: command detected
#   >0: failed to detect command
#######################################
function _bl64_tf_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_TF_CMD_TERRAFORM="$(bl64_bsh_command_locate 'terraform' "$@")"
  BL64_TF_CMD_TOFU="$(bl64_bsh_command_locate 'tofu' "$@")"
  if [[ -z "$BL64_TF_CMD_TERRAFORM" && -z "$BL64_TF_CMD_TOFU" ]]; then
    bl64_msg_show_lib_error 'failed to detect terraform or tofu command. Please install it and try again.'
    return "$BL64_LIB_ERROR_FILE_NOT_FOUND"
  fi
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
function _bl64_tf_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  BL64_TF_SET_LOG_TRACE='TRACE' &&
    BL64_TF_SET_LOG_DEBUG='DEBUG' &&
    BL64_TF_SET_LOG_INFO='INFO' &&
    BL64_TF_SET_LOG_WARN='WARN' &&
    BL64_TF_SET_LOG_ERROR='ERROR' &&
    BL64_TF_SET_LOG_OFF='OFF'
}

#######################################
# Set logging configuration
#
# Arguments:
#   $1: full path to the log file. Default: STDERR
#   $2: log level. One of BL64_TF_SET_LOG_*. Default: INFO
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_tf_log_set() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-$BL64_VAR_DEFAULT}"
  local level="${2:-$BL64_TF_SET_LOG_INFO}"

  bl64_check_module 'BL64_TF_MODULE' ||
    return $?

  BL64_TF_LOG_PATH="$path"
  BL64_TF_LOG_LEVEL="$level"
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
function _bl64_tf_set_resources() {
  bl64_dbg_lib_show_function

  # Terraform configuration lock file name
  # shellcheck disable=SC2034
  BL64_TF_DEF_PATH_LOCK='.terraform.lock.hcl'

  # Runtime directory created by terraform init
  # shellcheck disable=SC2034
  BL64_TF_DEF_PATH_RUNTIME='.terraform'

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
function _bl64_tf_set_version() {
  bl64_dbg_lib_show_function
  local cli_version=''

  if [[ -n "$BL64_TF_CMD_TERRAFORM" ]]; then
    cli_version="$("$BL64_TF_CMD_TERRAFORM" --version | bl64_txt_run_awk '/^Terraform v[0-9.]+$/ { gsub( /v/, "" ); print $2 }')"
  else
    cli_version="$("$BL64_TF_CMD_TOFU" --version | bl64_txt_run_awk '/^OpenTofu v[0-9.]+$/ { gsub( /v/, "" ); print $2 }')"
  fi
  bl64_dbg_lib_show_vars 'cli_version'

  if [[ -n "$cli_version" ]]; then
    # shellcheck disable=SC2034
    BL64_TF_VERSION_CLI="$cli_version"
  else
    bl64_msg_show_lib_error 'failed to get CLI version'
    return "$BL64_LIB_ERROR_APP_INCOMPATIBLE"
  fi

  bl64_dbg_lib_show_vars 'BL64_TF_VERSION_CLI'
  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with Terraform
#######################################

#######################################
# Run terraform output
#
# Arguments:
#   $1: output format. One of BL64_TF_OUTPUT_*
#   $2: (optional) variable name
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_tf_output_export() {
  bl64_dbg_lib_show_function "$@"
  local format="${1:-}"
  local variable="${2:-}"

  case "$format" in
  "$BL64_TF_OUTPUT_RAW") format='-raw' ;;
  "$BL64_TF_OUTPUT_JSON") format='-json' ;;
  "$BL64_TF_OUTPUT_TEXT") format='' ;;
  *) bl64_check_alert_undefined ;;
  esac

  # shellcheck disable=SC2086
  bl64_tf_run_terraform \
    output \
    -no-color \
    $format \
    "$variable"
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_tf_run_terraform() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TF_MODULE' ||
    return $?

  _bl64_tf_harden_terraform

  if bl64_dbg_lib_command_is_enabled; then
    export TF_LOG="$BL64_TF_SET_LOG_TRACE"
  else
    export TF_LOG="$BL64_TF_LOG_LEVEL"
  fi
  [[ "$BL64_TF_LOG_PATH" != "$BL64_VAR_DEFAULT" ]] && export TF_LOG_PATH="$BL64_TF_LOG_PATH"
  bl64_dbg_lib_show_vars 'TF_LOG' 'TF_LOG_PATH'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_TF_CMD_TERRAFORM" \
    "$@"
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
function _bl64_tf_harden_terraform() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited TF_* shell variables'
  bl64_dbg_lib_trace_start
  unset TF_LOG
  unset TF_LOG_PATH
  unset TF_CLI_CONFIG_FILE
  unset TF_LOG
  unset TF_LOG_PATH
  unset TF_IN_AUTOMATION
  unset TF_INPUT
  unset TF_DATA_DIR
  unset TF_PLUGIN_CACHE_DIR
  unset TF_REGISTRY_DISCOVERY_RETRY
  unset TF_REGISTRY_CLIENT_TIMEOUT
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_tf_run_tofu() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TF_MODULE' ||
    return $?

  _bl64_tf_harden_tofu

  if bl64_dbg_lib_command_is_enabled; then
    export TF_LOG="$BL64_TF_SET_LOG_TRACE"
  else
    export TF_LOG="$BL64_TF_LOG_LEVEL"
  fi
  [[ "$BL64_TF_LOG_PATH" != "$BL64_VAR_DEFAULT" ]] && export TF_LOG_PATH="$BL64_TF_LOG_PATH"
  bl64_dbg_lib_show_vars 'TF_LOG' 'TF_LOG_PATH'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_TF_CMD_TOFU" \
    "$@"
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
function _bl64_tf_harden_tofu() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited TF_* shell variables'
  bl64_dbg_lib_trace_start
  unset TF_LOG
  unset TF_LOG_PATH
  unset TF_CLI_CONFIG_FILE
  unset TF_LOG
  unset TF_LOG_PATH
  unset TF_IN_AUTOMATION
  unset TF_INPUT
  unset TF_DATA_DIR
  unset TF_PLUGIN_CACHE_DIR
  unset TF_REGISTRY_DISCOVERY_RETRY
  unset TF_REGISTRY_CLIENT_TIMEOUT
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# BashLib64 / Module / Setup / Manage date-time data
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_tm_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    bl64_dbg_lib_show_function &&
    BL64_TM_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'tm'
}

#######################################
# BashLib64 / Module / Functions / Manage date-time data
#######################################

#######################################
# Get current date-time in timestamp format
#
# * Format: DDMMYYHHMMSS
#
# Arguments:
#   None
# Outputs:
#   STDOUT: formated string
#   STDERR: command Error message
# Returns:
#   date exit status
#######################################
function bl64_tm_create_timestamp() {
  bl64_os_run_date '+%d%m%Y%H%M%S'
}

#######################################
# Get current date-time in file timestamp format
#
# * Format: DD:MM:YYYY-HH:MM:SS-TZ
#
# Arguments:
#   None
# Outputs:
#   STDOUT: formated string
#   STDERR: command Error message
# Returns:
#   date exit status
#######################################
function bl64_tm_create_timestamp_file() {
  bl64_os_run_date '+%d:%m:%Y-%H:%M:%S-UTC%z'
}

#######################################
# BashLib64 / Module / Setup / Manipulate text files content
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_txt_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_txt_set_command &&
    _bl64_txt_set_options &&
    BL64_TXT_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'txt'
}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * For AWK the function will determine the best option to match posix awk
# * Warning: bootstrap function
# * AWS: provide legacy AWS, posix AWS and modern AWS when available
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_txt_set_command() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/bin/grep'
    BL64_TXT_CMD_FMT='/bin/fmt'
    BL64_TXT_CMD_SED='/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TAIL='/usr/bin/tail'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'

    if [[ -x '/usr/bin/gawk' ]]; then
      BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    elif [[ -x '/usr/bin/mawk' ]]; then
      BL64_TXT_CMD_AWK_POSIX='/usr/bin/mawk'
    fi
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_FMT='/usr/bin/fmt'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TAIL='/usr/bin/tail'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'

    BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_TXT_CMD_AWK='/usr/bin/gawk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_FMT='/usr/bin/fmt'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TAIL='/usr/bin/tail'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'

    BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_BASE64='/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/bin/grep'
    BL64_TXT_CMD_FMT='/bin/fmt'
    BL64_TXT_CMD_SED='/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TAIL='/usr/bin/tail'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'

    if [[ -x '/usr/bin/gawk' ]]; then
      BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    else
      bl64_dbg_lib_show_comments 'no GAWK present. AWK bundled with busybox is not posix compliant'
    fi
    ;;
  ${BL64_OS_ARC}-*)
    BL64_TXT_CMD_AWK='/usr/bin/gawk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_FMT='/usr/bin/fmt'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TAIL='/usr/bin/tail'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'

    BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/opt/homebrew/bin/envsubst'
    BL64_TXT_CMD_GAWK="$BL64_VAR_UNAVAILABLE"
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_FMT='/usr/bin/fmt'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TAIL='/usr/bin/tail'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'

    BL64_TXT_CMD_AWK_POSIX='/usr/bin/awk'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
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
function _bl64_txt_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='--quiet'
    BL64_TXT_SET_GREP_LINE='-x'
    BL64_TXT_SET_GREP_ONLY_MATCHING='-o'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    BL64_TXT_SET_GREP_STRING='-F'
    BL64_TXT_SET_GREP_STDIN='-'
    BL64_TXT_SET_SED_EXPRESSION='-e'
    BL64_TXT_SET_SED_INLINE='-i'
    BL64_TXT_SET_SORT_NATURAL='-V'
    BL64_TXT_SET_TAIL_LINES='-n'

    if [[ -x '/usr/bin/gawk' ]]; then
      BL64_TXT_SET_AWK_POSIX='--posix'
    fi
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_TXT_SET_AWK_POSIX='--posix'
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='--quiet'
    BL64_TXT_SET_GREP_LINE='-x'
    BL64_TXT_SET_GREP_ONLY_MATCHING='-o'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    BL64_TXT_SET_GREP_STRING='-F'
    BL64_TXT_SET_GREP_STDIN='-'
    BL64_TXT_SET_SED_EXPRESSION='-e'
    BL64_TXT_SET_SED_INLINE='-i'
    BL64_TXT_SET_SORT_NATURAL='-V'
    BL64_TXT_SET_TAIL_LINES='-n'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_TXT_SET_AWK_POSIX='--posix'
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='-q'
    BL64_TXT_SET_GREP_LINE='-x'
    BL64_TXT_SET_GREP_ONLY_MATCHING='-o'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    BL64_TXT_SET_GREP_STRING='-F'
    BL64_TXT_SET_GREP_STDIN='-'
    BL64_TXT_SET_SED_EXPRESSION='-e'
    BL64_TXT_SET_SED_INLINE='-i'
    BL64_TXT_SET_SORT_NATURAL='-V'
    BL64_TXT_SET_TAIL_LINES='-n'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_TXT_SET_AWK_POSIX=''
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='-q'
    BL64_TXT_SET_GREP_LINE='-x'
    BL64_TXT_SET_GREP_ONLY_MATCHING='-o'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    BL64_TXT_SET_GREP_STRING='-F'
    BL64_TXT_SET_GREP_STDIN='-'
    BL64_TXT_SET_SED_EXPRESSION='-e'
    BL64_TXT_SET_SED_INLINE='-i'
    BL64_TXT_SET_SORT_NATURAL='-V'
    BL64_TXT_SET_TAIL_LINES='-n'
    ;;
  ${BL64_OS_ARC}-*)
    BL64_TXT_SET_AWK_POSIX='--posix'
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='--quiet'
    BL64_TXT_SET_GREP_LINE='-x'
    BL64_TXT_SET_GREP_ONLY_MATCHING='-o'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    BL64_TXT_SET_GREP_STRING='-F'
    BL64_TXT_SET_GREP_STDIN='-'
    BL64_TXT_SET_SED_EXPRESSION='-e'
    BL64_TXT_SET_SED_INLINE='-i'
    BL64_TXT_SET_SORT_NATURAL='-V'
    BL64_TXT_SET_TAIL_LINES='-n'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_TXT_SET_AWK_POSIX=''
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='-q'
    BL64_TXT_SET_GREP_LINE='-x'
    BL64_TXT_SET_GREP_ONLY_MATCHING='-o'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    BL64_TXT_SET_GREP_STRING='-F'
    BL64_TXT_SET_GREP_STDIN='-'
    BL64_TXT_SET_SED_EXPRESSION='-e'
    BL64_TXT_SET_SED_INLINE='-i' # Warning: requires backup suffix
    BL64_TXT_SET_SORT_NATURAL='-V'
    BL64_TXT_SET_TAIL_LINES='-n'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac

}

#######################################
# BashLib64 / Module / Functions / Manipulate text files content
#######################################

#######################################
# Removes comments from text input using the external tool Grep
#
# * Comment delimiter: #
# * All text to the right of the delimiter is removed
#
# Arguments:
#   $1: Full path to the text file. Use $BL64_TXT_FLAG_STDIN for stdin. Default: STDIN
# Outputs:
#   STDOUT: Original text with comments removed
#   STDERR: grep Error message
# Returns:
#   0: successfull execution
#   >0: grep command exit status
#######################################
function bl64_txt_strip_comments() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_TXT_FLAG_STDIN}}"

  [[ "$source" == "$BL64_TXT_FLAG_STDIN" ]] && source="$BL64_TXT_SET_GREP_STDIN"

  bl64_txt_run_egrep "$BL64_TXT_SET_GREP_INVERT" '^#.*$|^ *#.*$' "$source"
}

#######################################
# Read a text file, replace shell variable names with its value and show the result on stdout
#
# * Uses envsubst
# * Variables in the source file must follow the syntax: $VARIABLE or ${VARIABLE}
#
# Arguments:
#   $1: source file path
# Outputs:
#   STDOUT: source modified with replaced variables
#   STDERR: command stderr
# Returns:
#   0: replacement ok
#   >0: status from last failed command
#######################################
function bl64_txt_replace_env() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"

  bl64_check_parameter 'source' &&
    bl64_check_file "$source" ||
    return $?

  bl64_txt_run_envsubst <"$source"
}

#######################################
# Search for a whole line in a given text file or stdin
#
# Arguments:
#   $1: source file path. Use $BL64_TXT_FLAG_STDIN for stdin. Default: STDIN
#   $2: text to look for. Default: empty line
# Outputs:
#   STDOUT: none
#   STDERR: Error messages
# Returns:
#   0: line was found
#   >0: grep command exit status
#######################################
function bl64_txt_search_line() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_TXT_FLAG_STDIN}}"
  local line="${2:-}"

  [[ "$source" == "$BL64_TXT_FLAG_STDIN" ]] && source="$BL64_TXT_SET_GREP_STDIN"
  bl64_txt_run_grep \
    "$BL64_TXT_SET_GREP_QUIET" \
    "$BL64_TXT_SET_GREP_STRING" \
    "$BL64_TXT_SET_GREP_LINE" \
    "$line" \
    "$source"
}

#######################################
# Replace text directly in file using sed
#
# * Uses sed -i inline editing command
# * Helper to avoid platform specific implementation details
# * Warning: sed regexp is not consistent across versions and vendors. Caller is responsible for testing to ensure compatibility
#
# Arguments:
#   $1: sed expression
# Outputs:
#   STDOUT: none
#   STDERR: Error messages
# Returns:
#   0: operation ok
#   >0: operation failed
#######################################
function bl64_txt_line_replace_sed() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_TXT_FLAG_STDIN}}"
  local sed_expression="${2:-}"
  local -i exit_status=0

  bl64_check_parameter 'sed_expression' || return $?

  [[ "$source" == "$BL64_TXT_FLAG_STDIN" ]] && source=''

  # shellcheck disable=SC2086
  bl64_txt_run_sed -i"$BL64_LIB_SUFFIX_BACKUP" "$sed_expression" $source
  exit_status=$?
  bl64_fs_path_remove "${source}${BL64_LIB_SUFFIX_BACKUP}"
  return "$exit_status"
}

#######################################
# OS command wrapper: awk
#
# * Run AWS with POSIX compatibility and traditional regexp
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
function bl64_txt_run_awk() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_AWK_POSIX" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_TXT_CMD_AWK_POSIX" $BL64_TXT_SET_AWK_POSIX "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
# shellcheck disable=SC2120
function bl64_txt_run_envsubst() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_ENVSUBST" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_ENVSUBST" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_txt_run_grep() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_GREP" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_GREP" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Run grep with regular expression matching
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
function bl64_txt_run_egrep() {
  bl64_dbg_lib_show_function "$@"

  bl64_txt_run_grep "$BL64_TXT_SET_GREP_ERE" "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
# * Warning: sed regexp is not consistent across versions and vendors. Caller is responsible for testing to ensure compatibility
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
function bl64_txt_run_sed() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_SED" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_SED" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_txt_run_base64() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_BASE64" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_BASE64" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_txt_run_tr() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_TR" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_TR" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_txt_run_cut() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_CUT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_CUT" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_txt_run_uniq() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_UNIQ" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_UNIQ" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_txt_run_sort() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_SORT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_SORT" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_txt_run_tail() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_TAIL" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_TAIL" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
function bl64_txt_run_fmt() {
  bl64_dbg_lib_show_function "$@"

    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_FMT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_FMT" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# BashLib64 / Module / Setup / User Interface
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_ui_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    BL64_UI_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'ui'
}

#######################################
# BashLib64 / Module / Functions / User Interface
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_ui_confirmation_ask() {
  bl64_msg_show_deprecated 'bl64_ui_confirmation_ask' 'bl64_ui_ask_confirmation'
  bl64_ui_ask_confirmation "$@"
}

#
# Private functions
#

function _bl64_ui_is_confirmation_disabled(){
  bl64_dbg_lib_show_function
  if bl64_lib_flag_is_enabled "$BL64_UI_CONFIRMATION_SKIP"; then
    bl64_msg_show_text '** warning - confirmation verification disabled. The operation will continue without interruption **'
    return 0
  fi
  if bl64_lib_mode_cicd_is_enabled; then
    bl64_msg_show_text '** warning - confirmation verification disabled because CICD mode is enabled. The operation will continue without interruption **'
    return 0
  fi
  return 1
}

#
# Public functions
#

#######################################
# Ask for confirmation
#
# Arguments:
#   $1: confirmation question
#   $2: confirmation value that needs to be match
# Outputs:
#   STDOUT: user interaction
#   STDERR: command stderr
# Returns:
#   0: confirmed
#   >0: not confirmed
#######################################
function bl64_ui_ask_confirmation() {
  bl64_dbg_lib_show_function "$@"
  local question="${1:-please type in the confirmation message to proceed}"
  local confirmation="${2:-confirm}"
  local input=''

  bl64_msg_show_input "${question} [${confirmation}]: "
  _bl64_ui_is_confirmation_disabled && return 0

  read -r -t "$BL64_UI_CONFIRMATION_TIMEOUT" input

  input="${input#"${input%%[![:space:]]*}"}"
  input="${input%"${input##*[![:space:]]}"}"
  [[ "$input" == "$confirmation" ]] && return 0

  bl64_msg_show_warning 'Confirmation verification failed. The operation will be cancelled.'
  return "$BL64_LIB_ERROR_PARAMETER_INVALID"
}

#######################################
# Ask configuration to proceed, in a yes/no format
#
# Arguments:
#   $1: question to ask
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: user answered yes
#   1: user answered no
#######################################
function bl64_ui_ask_proceed() {
  local question="${1:-Do you want to proceed?}"
  local input=''

  while true; do
    bl64_msg_show_input "${question} [y/n]: "
    _bl64_ui_is_confirmation_disabled && return 0
    read -r input
    case "$input" in
    [Yy]*) return 0 ;;
    [Nn]*) bl64_msg_show_warning 'User requested not to proceed. No further action will be taken.' && return 1 ;;
    *) bl64_msg_show_lib_error "Invalid input. Please answer y or n." ;;
    esac
  done
}

#######################################
# Build a separator line with optional payload
#
# * Separator format: payload + \n
#
# Arguments:
#   $1: Separator payload. Format: string
# Outputs:
#   STDOUT: separator line
#   STDERR: grep Error message
# Returns:
#   printf exit status
#######################################
function bl64_ui_separator_show() {
  bl64_dbg_lib_show_function "$@"
  local payload="${1:-}"

  printf '%s\n' "$payload"
}

#######################################
# Ask a yes/no question
#
# Arguments:
#   $1: question to ask
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: user answered yes
#   1: user answered no
#######################################
function bl64_ui_ask_yesno() {
  local question="${1:-are you sure?}"
  local input=''

  while true; do
    bl64_msg_show_input "${question} [y/n]: "
    _bl64_ui_is_confirmation_disabled && return 0
    read -r input
    case "$input" in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) bl64_msg_show_lib_error "Invalid input. Please answer y or n." ;;
    esac
  done
}

#######################################
# Ask for general input (any type)
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: success
#######################################
function bl64_ui_ask_input_free() {
  local prompt="${1:-enter input:}"
  local input=''

  bl64_msg_show_input "${prompt} "
  read -r input
  echo "$input"
}

#######################################
# Ask for integer input
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid integer
#   1: invalid input
#######################################
function bl64_ui_ask_input_integer() {
  local prompt="${1:-enter an integer:}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^-?[0-9]+$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid integer."
    fi
  done
}

#######################################
# Ask for float input
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid float
#   1: invalid input
#######################################
function bl64_ui_ask_input_decimal() {
  local prompt="${1:-enter a float (e.g., 9.9):}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid decimal."
    fi
  done
}

#######################################
# Ask for string input
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid string
#######################################
function bl64_ui_ask_input_string() {
  local prompt="${1:-enter a string:}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ -n "$input" ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a non-empty string."
    fi
  done
}

#######################################
# Ask for semantic version input
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid semantic version
#   1: invalid input
#######################################
function bl64_ui_ask_input_semver() {
  local prompt="${1:-enter a semantic version (e.g., 1.0.0):}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid semantic version (e.g., 1.0.0)."
    fi
  done
}

#######################################
# Ask for time input (HH:MM format)
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid time
#   1: invalid input
#######################################
function bl64_ui_ask_input_time() {
  local prompt="${1:-enter time (HH:MM):}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^([01]?[0-9]|2[0-3]):[0-5][0-9]$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid time (HH:MM)."
    fi
  done
}

#######################################
# Ask for date input (DD-MM-YYYY format)
#
# Arguments:
#   $1: prompt message
# Outputs:
#   STDOUT: user interaction
# Returns:
#   0: valid date
#   1: invalid input
#######################################
function bl64_ui_ask_input_date() {
  local prompt="${1:-enter date (DD-MM-YYYY):}"
  local input=''

  while true; do
    bl64_msg_show_input "${prompt} "
    read -r input
    if [[ "$input" =~ ^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[0-2])-[0-9]{4}$ ]]; then
      echo "$input"
      return 0
    else
      bl64_msg_show_lib_error "Invalid input. Please enter a valid date (DD-MM-YYYY)."
    fi
  done
}

#######################################
# BashLib64 / Module / Setup / Manage Version Control System
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_vcs_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_API_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_OS_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_vcs_set_command &&
    _bl64_vcs_set_options &&
    BL64_VCS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'vcs'
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_vcs_set_command() {
  bl64_dbg_lib_show_function
  BL64_VCS_CMD_GIT='/usr/bin/git'
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_vcs_set_options() {
  bl64_dbg_lib_show_function
  # Common sets - unversioned
  BL64_VCS_SET_GIT_NO_PAGER='--no-pager'
  BL64_VCS_SET_GIT_QUIET=' '
}

#######################################
# BashLib64 / Module / Functions / Manage Version Control System
#######################################

#######################################
# GIT CLI wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
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
function bl64_vcs_run_git() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_VCS_SET_GIT_QUIET"

  bl64_check_module 'BL64_VCS_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_VCS_CMD_GIT" || return $?

  _bl64_vcs_harden_git

  if bl64_dbg_lib_command_is_enabled; then
    verbose=''
    export GIT_TRACE='2'
  else
    bl64_msg_app_run_is_enabled &&
      export GIT_PROGRESS_DELAY='60'
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_VCS_CMD_GIT" \
    $verbose $BL64_VCS_SET_GIT_NO_PAGER \
    "$@"
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
function _bl64_vcs_harden_git() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'normalize GIT_* shell variables'
  bl64_dbg_lib_trace_start
  export GIT_TRACE='0'
  export GIT_TERMINAL_PROMPT='0'
  export GIT_CONFIG_NOSYSTEM='0'
  export GIT_AUTHOR_EMAIL='nouser@nodomain'
  export GIT_AUTHOR_NAME='bl64_vcs_run_git'
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Clone GIT branch
#
# * File ownership is set to the current user
# * Destination is created if not existing
# * Single branch
# * Depth = 1
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: destination path where the repository will be created
#   $3: (optional) branch name
#   $4: (optional) new repository name
# Outputs:
#   STDOUT: git output
#   STDERR: git stderr
# Returns:
#   n: git exit status
#######################################
function bl64_vcs_git_clone() {
  bl64_dbg_lib_show_function "$@"
  local source="${1}"
  local destination="${2}"
  local branch="${3:-$BL64_VAR_DEFAULT}"
  local name="${4:-$BL64_VAR_DEFAULT}"
  local verbose='--quiet --no-progress'

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_command "$BL64_VCS_CMD_GIT" ||
    return $?

  bl64_lib_var_is_default "$branch" && branch=''
  bl64_msg_app_run_is_enabled && verbose=' '

  bl64_msg_show_lib_subtask "clone single branch (${source}/${branch} -> ${destination})"
  bl64_fs_dir_create "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "$destination" &&
    bl64_bsh_run_pushd "$destination" ||
    return $?

  if bl64_lib_var_is_default "$name"; then
    # shellcheck disable=SC2086
    bl64_vcs_run_git \
      clone \
      $verbose \
      --depth 1 \
      --single-branch \
      ${branch:+--branch $branch} \
      "$source" ||
      return $?
  else
    # shellcheck disable=SC2086
    bl64_vcs_run_git \
      clone \
      $verbose \
      --depth 1 \
      --single-branch \
      ${branch:+--branch $branch} \
      "$source" "$name" ||
      return $?
  fi
  bl64_bsh_run_popd
}

#######################################
# Clone partial GIT repository (sparse checkout)
#
# * File ownership is set to the current user
# * Destination is created if not existing
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: destination path where the repository will be created
#   $3: branch name. Default: main
#   $4: include search_pattern list. Field separator: space
# Outputs:
#   STDOUT: git output
#   STDERR: git stderr
# Returns:
#   n: git exit status
#######################################
function bl64_vcs_git_sparse() {
  bl64_dbg_lib_show_function "$@"
  local source="${1}"
  local destination="${2}"
  local branch="${3:-main}"
  local search_pattern="${4}"
  local item=''
  local -i status=0

  bl64_check_command "$BL64_VCS_CMD_GIT" &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_parameter 'search_pattern' || return $?

  bl64_fs_dir_create "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "$destination" &&
    bl64_bsh_run_pushd "$destination" ||
    return $?

  bl64_dbg_lib_show_info 'detect if current git supports sparse-checkout option'
  if bl64_os_is_distro "${BL64_OS_DEB}-9" "${BL64_OS_DEB}-10" "${BL64_OS_UB}-18" "${BL64_OS_UB}-20" "${BL64_OS_OL}-7" "${BL64_OS_CNT}-7"; then
    bl64_dbg_lib_show_info 'git sparse-checkout not supported. Using alternative method'
    # shellcheck disable=SC2086
    bl64_vcs_run_git init &&
      bl64_vcs_run_git remote add origin "$source" &&
      bl64_vcs_run_git config core.sparseCheckout true &&
      {
        IFS=' '
        for item in $search_pattern; do echo "$item" >>'.git/info/sparse-checkout'; done
        unset IFS
      } &&
      bl64_vcs_run_git pull --depth 1 origin "$branch" ||
      return $?
  else
    bl64_dbg_lib_show_info 'git sparse-checkout is supported'
    # shellcheck disable=SC2086
    bl64_vcs_run_git init &&
      bl64_vcs_run_git sparse-checkout set &&
      {
        IFS=' '
        for item in $search_pattern; do echo "$item"; done | bl64_vcs_run_git sparse-checkout add --stdin
      } &&
      bl64_vcs_run_git remote add origin "$source" &&
      bl64_vcs_run_git pull --depth 1 origin "$branch" ||
      return $?
  fi
  bl64_bsh_run_popd
}

#######################################
# GitHub / Call API
#
# * Call GitHub APIs
# * API calls are executed using Curl wrapper
#
# Arguments:
#   $1: API path. Format: Full path (/X/Y/Z)
#   $2: RESTful method. Format: $BL64_API_METHOD_*. Default: $BL64_API_METHOD_GET
#   $3: API query to be appended to the API path. Format: url encoded string. Default: none
#   $4: API Token. Default: none
#   $5: API Version. Default: $BL64_VCS_GITHUB_API_VERSION
#   $@: additional arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: API call executed. Warning: curl exit status only, not the HTTP status code
#   >: unable to execute API call
#######################################
function bl64_vcs_github_run_api() {
  bl64_dbg_lib_show_function "$@"
  local api_path="$1"
  local api_method="${2:-${BL64_API_METHOD_GET}}"
  local api_query="${3:-${BL64_VAR_NULL}}"
  local api_token="${4:-${BL64_VAR_NULL}}"
  local api_version="${5:-${BL64_VCS_GITHUB_API_VERSION}}"

  bl64_check_parameter 'api_path' ||
    return $?

  if [[ "$api_token" == "$BL64_VAR_NULL" ]]; then
    if [[ -v 'GITHUB_TOKEN' ]]; then
      api_token="$GITHUB_TOKEN"
    else
      api_token=''
    fi
  fi
  shift
  shift
  shift
  shift
  shift

  # shellcheck disable=SC2086
  bl64_api_call \
    "$BL64_VCS_GITHUB_API_URL" \
    "$api_path" \
    "$api_method" \
    "$api_query" \
    $BL64_RXTX_SET_CURL_HEADER 'Accept: application/vnd.github+json' \
    $BL64_RXTX_SET_CURL_HEADER "X-GitHub-Api-Version: ${api_version}" \
    ${api_token:+${BL64_RXTX_SET_CURL_HEADER} "Authorization: Bearer ${api_token}"} \
    "$@"
}

#######################################
# GitHub / Get release number from latest release
#
# * Uses GitHub API
# * Assumes repo uses standard github release process which binds the latest release to a tag name representing the last version
# * Looks for search_pattern in json output: "tag_name": "xxxxx"
#
# Arguments:
#   $1: repo owner
#   $2: repo name
# Outputs:
#   STDOUT: release tag
#   STDERR: api error
# Returns:
#   0: api call success
#   >0: api call error
#######################################
function bl64_vcs_github_release_get_latest() {
  bl64_dbg_lib_show_function "$@"
  local repo_owner="$1"
  local repo_name="$2"
  local repo_tag=''

  bl64_check_module 'BL64_VCS_MODULE' &&
    bl64_check_parameter 'repo_owner' &&
    bl64_check_parameter 'repo_name' ||
    return $?

  repo_tag="$(_bl64_vcs_github_release_get_latest "$repo_owner" "$repo_name")"

  if [[ -n "$repo_tag" ]]; then
    echo "$repo_tag"
  else
    bl64_msg_show_lib_error "failed to determine latest release (${repo_owner}/${repo_name})"
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi
}

function _bl64_vcs_github_release_get_latest() {
  bl64_dbg_lib_show_function "$@"
  local repo_owner="$1"
  local repo_name="$2"
  local repo_api_query="/repos/${repo_owner}/${repo_name}/releases/latest"

  # shellcheck disable=SC2086
  bl64_vcs_github_run_api "$repo_api_query" |
    bl64_txt_run_awk \
      ${BL64_TXT_SET_AWS_FS} ':' \
      '/"tag_name": "/ {
        gsub(/[ ",]/,"", $2); print $2
      }'
}

#######################################
# Changelog / Get release description for a semver tag
#
# * Uses standard Changelog format
# * Uses standard semver tag
# * Replaces # markers with * to avoid post-processing formatting issues
#
# Arguments:
#   $1: changelog path
#   $2: semver release tag
# Outputs:
#   STDOUT: release description
#   STDERR: execution error
# Returns:
#   0: release description found
#   >0: unable to get release description
#######################################
function bl64_vcs_changelog_get_release() {
  bl64_dbg_lib_show_function "$@"
  local changelog_path="$1"
  local release_tag="$2"
  local description=''

  bl64_check_parameter 'changelog_path' &&
    bl64_check_parameter 'release_tag' &&
    bl64_check_file "$changelog_path" ||
    return $?

  description="$(
    _bl64_vcs_changelog_get_release \
      "$changelog_path" \
      "$release_tag"
  )" &&
    [[ -n "$description" ]] &&
    printf '%s\n' "$description"
}

function _bl64_vcs_changelog_get_release() {
  bl64_dbg_lib_show_function "$@"
  local changelog_path="$1"
  local release_tag="$2"

  bl64_txt_run_awk \
    -v tag="$release_tag" '
  BEGIN {
      found = 0
      search_pattern = "## ." tag "."
  }
  found == 0 && $0 ~ search_pattern {
    found = 1
    print "** Release: " tag
    next
  }
  found == 1 && $1 == "##" || $1 ~ /^.[0-9]+.[0-9].+[0-9]+.:/ {
    exit
  }
  found == 1 {
    gsub(/#/,"*")
    print $0
    next
  }
  ' "$changelog_path"
}

#######################################
# BashLib64 / Module / Setup / Manipulate CSV like text files
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $@: (optional) search full paths for tools
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_xsv_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21
  local search_paths=("${@:-}")

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_BSH_MODULE' &&
    _bl64_xsv_set_command "${search_paths[@]}" &&
    BL64_XSV_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'xsv'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
# * All commands are optional, no error if not found
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_xsv_set_command() {
  bl64_dbg_lib_show_function "$@"
  BL64_XSV_CMD_PKL="$(bl64_bsh_command_locate 'pkl' "$@")"
  BL64_XSV_CMD_JQ="$(bl64_bsh_command_locate 'jq' "$@")"
  BL64_XSV_CMD_YQ="$(bl64_bsh_command_locate 'yq' "$@")"
  return 0
}

#######################################
# BashLib64 / Module / Functions / Manipulate CSV like text files
#######################################

#######################################
# Dump file to STDOUT without comments and spaces
#
# Arguments:
#   $1: Full path to the file
# Outputs:
#   STDOUT: file content
#   STDERR: Error messages
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_FILE_*
#######################################
function bl64_xsv_dump() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_check_parameter 'source' &&
    bl64_check_file "$source" 'source file not found' || return $?

  bl64_txt_run_egrep "$BL64_TXT_SET_GREP_INVERT" '^#.*$|^$' "$source"

}

#######################################
# Search for records based on key filters and return matching rows
#
# * Column numbers are AWK fields. First column: 1
#
# Arguments:
#   $1: Single string with one ore more search values separated by $BL64_XSV_FS
#   $2: source file path. Default: STDIN
#   $3: one ore more column numbers (keys) where values will be searched. Format: single string using $BL64_XSV_COLON as field separator
#   $4: one or more fields to show on record match. Format: single string using $BL64_XSV_COLON as field separator
#   $5: field separator for the source file. Default: $BL64_XSV_COLON
#   $6: field separator for the output record. Default: $BL64_XSV_COLON
# Outputs:
#   STDOUT: matching records
#   STDERR: Error messages
# Returns:
#   0: successfull execution
#   >0: awk command exit status
#######################################
function bl64_xsv_search_records() {
  bl64_dbg_lib_show_function "$@"
  local values="$1"
  local source="${2:--}"
  local keys="${3:-1}"
  local fields="${4:-0}"
  local fs_src="${5:-$BL64_XSV_FS_COLON}"
  local fs_out="${6:-$BL64_XSV_FS_COLON}"

  # shellcheck disable=SC2086
  bl64_check_parameter 'values' 'search value' || return $?

  bl64_dbg_lib_show_comments 'run in a subshell to avoid leaving exported vars'
  {
    export BL64_XSV_FS_COLON
    export BL64_XSV_FS
    export BL64_LIB_ERROR_PARAMETER_INVALID
    # shellcheck disable=SC2016
    bl64_txt_run_awk \
      -F "$fs_src" \
      -v VALUES="${values}" \
      -v KEYS="$keys" \
      -v FIELDS="$fields" \
      -v FS_OUT="$fs_out" \
      '
      BEGIN {
        show_total = split( FIELDS, show_fields, ENVIRON["BL64_XSV_FS_COLON"] )
        keys_total = split( KEYS, keys_fields, ENVIRON["BL64_XSV_FS_COLON"] )
        values_total = split( VALUES, values_fields, ENVIRON["BL64_XSV_FS"] )
        if( keys_total != values_total ) {
          exit ENVIRON["BL64_LIB_ERROR_PARAMETER_INVALID"]
        }
        row_match = ""
        count = 0
        found = 0
      }
      /^#/ || /^$/ { next }
      {
        found = 0
        for( count = 1; count <= keys_total; count++ ) {
          if ( $keys_fields[count] == values_fields[count] ) {
            found = 1
          } else {
            found = 0
            break
          }
        }

        if( found == 1 ) {
          row_match = $show_fields[1]
          for( count = 2; count <= show_total; count++ ) {
            row_match = row_match FS_OUT $show_fields[count]
          }
          print row_match
        }
      }
      END {}
    ' \
      "$source"
  }
}

#######################################
# Command wrapper with verbose, debug and common options
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
# shellcheck disable=SC2120
function bl64_xsv_run_jq() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_XSV_MODULE' &&
    bl64_check_command "$BL64_XSV_CMD_JQ" "$BL64_VAR_DEFAULT" 'jq' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_XSV_CMD_JQ" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
# shellcheck disable=SC2120
function bl64_xsv_run_yq() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_XSV_MODULE' &&
    bl64_check_command "$BL64_XSV_CMD_YQ" "$BL64_VAR_DEFAULT" 'yq' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_XSV_CMD_YQ" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
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
# shellcheck disable=SC2120
function bl64_xsv_run_pkl() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_XSV_MODULE' &&
    bl64_check_command "$BL64_XSV_CMD_PKL" "$BL64_VAR_DEFAULT" 'pkl' ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_XSV_CMD_PKL" "$@"
  bl64_dbg_lib_trace_stop
}

#
# Library Main
#

# Normalize terminal settings
TERM="${TERM:-vt100}"

# Normalize paths
TMPDIR='/tmp'

# Normalize common shell variables
PS1="${PS1:-BL64 \u@\H:\w$ }"
PS2="${PS2:-BL64 > }"

# Normalize locales to C until a better locale is found in bl64_os_setup
if bl64_lib_lang_is_enabled; then
  LANG='C'
  LC_ALL='C'
  LANGUAGE='C'
fi

# Set strict mode for enhanced security
if bl64_lib_mode_strict_is_enabled; then
  set -o 'nounset'
  set -o 'privileged'
fi

# Initialize modules that do not require setup parameters. Not OS bound
[[ -n "${BL64_DBG_MODULE:-}" ]] && { bl64_dbg_setup || exit $?; }
[[ -n "${BL64_CHECK_MODULE:-}" ]] && { bl64_check_setup || exit $?; }
[[ -n "${BL64_MSG_MODULE:-}" ]] && { bl64_msg_setup || exit $?; }
[[ -n "${BL64_BSH_MODULE:-}" ]] && { bl64_bsh_setup || exit $?; }
[[ -n "${BL64_RND_MODULE:-}" ]] && { bl64_rnd_setup || exit $?; }
[[ -n "${BL64_UI_MODULE:-}" ]] && { bl64_ui_setup || exit $?; }
# Initialize modules that do not require setup parameters. OS bound
[[ -n "${BL64_OS_MODULE:-}" ]] && { bl64_os_setup || exit $?; }
[[ -n "${BL64_TXT_MODULE:-}" ]] && { bl64_txt_setup || exit $?; }
[[ -n "${BL64_FMT_MODULE:-}" ]] && { bl64_fmt_setup || exit $?; }
[[ -n "${BL64_FS_MODULE:-}" ]] && { bl64_fs_setup || exit $?; }
[[ -n "${BL64_IAM_MODULE:-}" ]] && { bl64_iam_setup || exit $?; }
[[ -n "${BL64_RBAC_MODULE:-}" ]] && { bl64_rbac_setup || exit $?; }
[[ -n "${BL64_RXTX_MODULE:-}" ]] && { bl64_rxtx_setup || exit $?; }
[[ -n "${BL64_API_MODULE:-}" ]] && { bl64_api_setup || exit $?; }
[[ -n "${BL64_VCS_MODULE:-}" ]] && { bl64_vcs_setup || exit $?; }
[[ -n "${BL64_ARC_MODULE:-}" ]] && { bl64_arc_setup || exit $?; }
[[ -n "${BL64_PKG_MODULE:-}" ]] && { bl64_pkg_setup || exit $?; }
[[ -n "${BL64_RND_MODULE:-}" ]] && { bl64_rnd_setup || exit $?; }
[[ -n "${BL64_TM_MODULE:-}" ]] && { bl64_tm_setup || exit $?; }

# Set signal handlers
# shellcheck disable=SC2064
if bl64_lib_trap_is_enabled; then
  trap "$BL64_LIB_SIGNAL_HUP" 'SIGHUP'
  trap "$BL64_LIB_SIGNAL_STOP" 'SIGINT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGTERM'
  trap "$BL64_LIB_SIGNAL_DEBUG" 'DEBUG'
  trap "$BL64_LIB_SIGNAL_EXIT" 'EXIT'
  trap "$BL64_LIB_SIGNAL_ERR" 'ERR'
fi

# Set default umask
umask -S 'u=rwx,g=,o=' >/dev/null

bl64_lib_script_set_identity

# Check OS compatibility
if [[ "${BL64_OS_MODULE:-$BL64_VAR_OFF}" == "$BL64_VAR_ON" ]]; then
  bl64_os_check_compatibility \
    "${BL64_OS_ALM}-8" "${BL64_OS_ALM}-9" "${BL64_OS_ALM}-10" \
    "${BL64_OS_ALP}-3.17" "${BL64_OS_ALP}-3.18" "${BL64_OS_ALP}-3.19" "${BL64_OS_ALP}-3.20" "${BL64_OS_ALP}-3.21" "${BL64_OS_ALP}-3.22"\
    "${BL64_OS_AMZ}-2023" \
    "${BL64_OS_ARC}-2025" \
    "${BL64_OS_CNT}-7" "${BL64_OS_CNT}-8" "${BL64_OS_CNT}-9" "${BL64_OS_CNT}-10" \
    "${BL64_OS_DEB}-9" "${BL64_OS_DEB}-10" "${BL64_OS_DEB}-11" "${BL64_OS_DEB}-12" "${BL64_OS_DEB}-13" \
    "${BL64_OS_FD}-33" "${BL64_OS_FD}-34" "${BL64_OS_FD}-35" "${BL64_OS_FD}-36" "${BL64_OS_FD}-37" "${BL64_OS_FD}-38" "${BL64_OS_FD}-39" \
    "${BL64_OS_FD}-40" "${BL64_OS_FD}-41" "${BL64_OS_FD}-42" "${BL64_OS_FD}-43" \
    "${BL64_OS_KL}-2024" "${BL64_OS_KL}-2025" \
    "${BL64_OS_MCOS}-12" "${BL64_OS_MCOS}-13" "${BL64_OS_MCOS}-14" "${BL64_OS_MCOS}-15" \
    "${BL64_OS_OL}-7" "${BL64_OS_OL}-8" "${BL64_OS_OL}-9" "${BL64_OS_OL}-10" \
    "${BL64_OS_RCK}-8" "${BL64_OS_RCK}-9" "${BL64_OS_RCK}-10" \
    "${BL64_OS_RHEL}-8" "${BL64_OS_RHEL}-9" "${BL64_OS_RHEL}-10" \
    "${BL64_OS_SLES}-15" "${BL64_OS_SLES}-16" \
    "${BL64_OS_UB}-18" "${BL64_OS_UB}-20" "${BL64_OS_UB}-21" "${BL64_OS_UB}-22" "${BL64_OS_UB}-23" "${BL64_OS_UB}-24" "${BL64_OS_UB}-25" ||
    exit $?
fi

# Run as script or sourced library?
if bl64_lib_mode_command_is_enabled; then
  "$@"
else
  :
fi

