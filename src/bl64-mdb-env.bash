#######################################
# BashLib64 / Module / Setup / Interact with MongoDB
#######################################

# shellcheck disable=SC2034
{
  declare BL64_MDB_VERSION='2.0.3'

  declare BL64_MDB_MODULE='0'

  declare BL64_MDB_CMD_MONGOSH="$BL64_VAR_UNAVAILABLE"
  declare BL64_MDB_CMD_MONGORESTORE="$BL64_VAR_UNAVAILABLE"
  declare BL64_MDB_CMD_MONGOEXPORT="$BL64_VAR_UNAVAILABLE"

  declare BL64_MDB_SET_VERBOSE=''
  declare BL64_MDB_SET_QUIET=''
  declare BL64_MDB_SET_NORC=''

  declare BL64_MDB_CFG_REPLICA_WRITE='majority'
  declare BL64_MDB_CFG_REPLICA_TIMEOUT='1000'
}
