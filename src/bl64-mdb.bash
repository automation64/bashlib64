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
