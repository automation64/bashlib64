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
