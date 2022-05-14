#######################################
# BashLib64 / Module / Globals / Interact with container engines
#
# Version: 1.1.0
#######################################

# Optional module. Not enabled by default
export BL64_CNT_MODULE="$BL64_LIB_VAR_OFF"

export BL64_CNT_CMD_PODMAN=''
export BL64_CNT_CMD_DOCKER=''

readonly _BL64_CNT_TXT_NO_CLI='unable to detect supported container engine'
