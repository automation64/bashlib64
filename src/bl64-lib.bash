#######################################
# BashLib64 / Module / Functions / Setup script run-time environment
#######################################

function bl64_lib_mode_command_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_CMD"; }
function bl64_lib_mode_compability_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_COMPATIBILITY"; }
function bl64_lib_mode_strict_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_STRICT"; }

function bl64_lib_lang_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_LANG"; }
function bl64_lib_trap_is_enabled { bl64_lib_flag_is_enabled "$BL64_LIB_TRAPS"; }

function bl64_lib_var_is_default { local value="${1:-}"; [[ "$value" == "$BL64_VAR_DEFAULT" ]]; }

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

  # shellcheck disable=SC2086
  [[ -z "$flag" ]] && return $BL64_LIB_ERROR_PARAMETER_MISSING

  # shellcheck disable=SC2086
  [[ "$flag" == "$BL64_VAR_ON" ||
    "$flag" == 'ON' ||
    "$flag" == 'YES' ]] ||
    return $BL64_LIB_ERROR_IS_NOT
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
  [[ -z "$script_id" ]] && return $BL64_LIB_ERROR_PARAMETER_MISSING
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

function _bl64_lib_script_get_path() {
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

function _bl64_lib_script_get_name() {
  local -i main=0
  local path=''
  local base=''

  main=${#BASH_SOURCE[*]}
  ((main > 0)) && main=$((main - 1))
  path="${BASH_SOURCE[${main}]}"

  if [[ -n "$path" && "$path" != '/' ]]; then
    base="${path##*/}"
  fi
  if [[ -z "$base" || "$base" == */* ]]; then
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  else
    printf '%s' "$base"
  fi
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
function bl64_lib_module_imported() {
  local module="${1:-}"
  [[ -z "$module" ]] && return $BL64_LIB_ERROR_PARAMETER_MISSING

  if [[ ! -v "$module" ]]; then
    module="${module##BL64_}"
    module="${module%%_MODULE}"
    printf 'Error: required BashLib64 module not found. Please source the module before using it. (module: %s | caller: %s)\n' \
      "${module%%BL64_}" \
      "${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE}.${FUNCNAME[2]:-NONE}@${BASH_LINENO[2]:-NONE}" \
      >&2
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_MODULE_NOT_IMPORTED
  fi
  return 0
}
