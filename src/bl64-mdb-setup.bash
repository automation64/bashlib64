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
