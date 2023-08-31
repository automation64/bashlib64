#######################################
# BashLib64 / Module / Functions / Setup script run-time environment
#######################################

function bl64_lib_mode_command_is_enabled { [[ "$BL64_LIB_CMD" == "$BL64_VAR_ON" ]]; }
function bl64_lib_mode_compability_is_enabled { [[ "$BL64_LIB_COMPATIBILITY" == "$BL64_VAR_ON" ]]; }
function bl64_lib_mode_strict_is_enabled { [[ "$BL64_LIB_STRICT" == "$BL64_VAR_ON" ]]; }

function bl64_lib_lang_is_enabled { [[ "$BL64_LIB_LANG" == "$BL64_VAR_ON" ]]; }
function bl64_lib_trap_is_enabled { [[ "$BL64_LIB_TRAPS" == "$BL64_VAR_ON" ]]; }
