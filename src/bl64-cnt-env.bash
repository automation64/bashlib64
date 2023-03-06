#######################################
# BashLib64 / Module / Globals / Interact with container engines
#
# Version: 1.2.0
#######################################

# Optional module. Not enabled by default
export BL64_CNT_MODULE="$BL64_VAR_OFF"

export BL64_CNT_CMD_PODMAN=''
export BL64_CNT_CMD_DOCKER=''

export BL64_CNT_SET_DOCKER_VERSION=''
export BL64_CNT_SET_PODMAN_VERSION=''

export BL64_CNT_PATH_DOCKER_SOCKET=''

export _BL64_CNT_TXT_NO_CLI='unable to detect supported container engine'
