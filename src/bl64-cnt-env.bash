#######################################
# BashLib64 / Module / Globals / Interact with container engines
#######################################

export BL64_CNT_VERSION='2.0.0'

# Optional module. Not enabled by default
export BL64_CNT_MODULE="$BL64_VAR_OFF"

export BL64_CNT_DRIVER_DOCKER='docker'
export BL64_CNT_DRIVER_PODMAN='podman'
export BL64_CNT_DRIVER=''

export BL64_CNT_FLAG_STDIN='-'

export BL64_CNT_CMD_PODMAN=''
export BL64_CNT_CMD_DOCKER=''

export BL64_CNT_SET_DEBUG=''
export BL64_CNT_SET_ENTRYPOINT=''
export BL64_CNT_SET_FILE=''
export BL64_CNT_SET_FILTER=''
export BL64_CNT_SET_INTERACTIVE=''
export BL64_CNT_SET_LOG_LEVEL=''
export BL64_CNT_SET_NO_CACHE=''
export BL64_CNT_SET_PASSWORD_STDIN=''
export BL64_CNT_SET_PASSWORD=''
export BL64_CNT_SET_QUIET=''
export BL64_CNT_SET_RM=''
export BL64_CNT_SET_TAG=''
export BL64_CNT_SET_TTY=''
export BL64_CNT_SET_USERNAME=''
export BL64_CNT_SET_VERSION=''

export BL64_CNT_SET_FILTER_ID=''
export BL64_CNT_SET_FILTER_NAME=''
export BL64_CNT_SET_LOG_LEVEL_DEBUG=''
export BL64_CNT_SET_LOG_LEVEL_ERROR=''
export BL64_CNT_SET_LOG_LEVEL_INFO=''
export BL64_CNT_SET_STATUS_RUNNING=''


export BL64_CNT_PATH_DOCKER_SOCKET=''

declare _BL64_CNT_TXT_NO_CLI='unable to detect supported container engine'
declare _BL64_CNT_TXT_EXISTING_NETWORK='container network already created. No further action needed'
declare _BL64_CNT_TXT_CREATE_NETWORK='creating container network'
declare _BL64_CNT_TXT_LOGIN_REGISTRY='loging to container registry'
declare _BL64_CNT_TXT_BUILD='build container image'
declare _BL64_CNT_TXT_PUSH='push container image to registry'
declare _BL64_CNT_TXT_PULL='pull container image from registry'
declare _BL64_CNT_TXT_TAG='add tag to container image'
declare _BL64_CNT_TXT_MISSING_FILTER='no filter was selected. Task requires one of them'
