#######################################
# BashLib64 / Module / Setup / Interact with MongoDB
#
# Version: 1.0.0
#######################################

# Optional module. Not enabled by default
export BL64_MDB_MODULE="$BL64_LIB_VAR_OFF"

export BL64_MDB_CMD_MONGOSH="$BL64_LIB_UNAVAILABLE"
export BL64_MDB_CMD_MONGORESTORE="$BL64_LIB_UNAVAILABLE"
export BL64_MDB_CMD_MONGOEXPORT="$BL64_LIB_UNAVAILABLE"

export BL64_MDB_SET_VERBOSE=''
export BL64_MDB_SET_QUIET=''
export BL64_MDB_SET_NORC=''

# Write concern defaults
export BL64_MDB_REPLICA_WRITE='majority'
export BL64_MDB_REPLICA_TIMEOUT='1000'
