#######################################
# BashLib64 / Module / Globals / Interact with container engines
#######################################

export BL64_CNT_VERSION='1.9.1'

# Optional module. Not enabled by default
export BL64_CNT_MODULE="$BL64_VAR_OFF"

export BL64_CNT_DRIVER_DOCKER='docker'
export BL64_CNT_DRIVER_PODMAN='podman'
export BL64_CNT_DRIVER=''

export BL64_CNT_FLAG_STDIN='-'

export BL64_CNT_CMD_PODMAN=''
export BL64_CNT_CMD_DOCKER=''

export BL64_CNT_SET_FILTER=''
export BL64_CNT_SET_QUIET=''
export BL64_CNT_SET_VERSION=''
export BL64_CNT_SET_STATUS_RUNNING=''
export BL64_CNT_SET_FILTER_ID=''
export BL64_CNT_SET_FILTER_NAME=''

export BL64_CNT_PATH_DOCKER_SOCKET=''

export _BL64_CNT_TXT_NO_CLI='unable to detect supported container engine'
export _BL64_CNT_TXT_EXISTING_NETWORK='container network already created. No further action needed'
export _BL64_CNT_TXT_CREATE_NETWORK='creating container network'
export _BL64_CNT_TXT_LOGIN_REGISTRY='loging to container registry'
export _BL64_CNT_TXT_BUILD='build container image'
export _BL64_CNT_TXT_PUSH='push container image to registry'
export _BL64_CNT_TXT_PULL='pull container image from registry'
export _BL64_CNT_TXT_TAG='add tag to container image'
export _BL64_CNT_TXT_MISSING_FILTER='no filter was selected. Task requires one of them'
