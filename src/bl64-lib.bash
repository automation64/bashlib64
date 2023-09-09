#######################################
# BashLib64 / Module / Functions / Setup script run-time environment
#######################################

function bl64_lib_mode_command_is_enabled { [[ "$BL64_LIB_CMD" == "$BL64_VAR_ON" ]]; }
function bl64_lib_mode_compability_is_enabled { [[ "$BL64_LIB_COMPATIBILITY" == "$BL64_VAR_ON" ]]; }
function bl64_lib_mode_strict_is_enabled { [[ "$BL64_LIB_STRICT" == "$BL64_VAR_ON" ]]; }

function bl64_lib_lang_is_enabled { [[ "$BL64_LIB_LANG" == "$BL64_VAR_ON" ]]; }
function bl64_lib_trap_is_enabled { [[ "$BL64_LIB_TRAPS" == "$BL64_VAR_ON" ]]; }

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
#   1: flag disabled
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#######################################
function bl64_lib_flag_is_enabled {
  local -u flag="${1:-}"

  [[ -z "$flag" ]] && return $BL64_LIB_ERROR_PARAMETER_MISSING

  [[ "$flag" == "$BL64_VAR_ON" ||
    "$flag" == 'ON' ||
    "$flag" == 'YES' ]]
}
