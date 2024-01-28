#######################################
# BashLib64 / Module / Globals / Interact with container engines
#######################################

declare BL64_CNT_VERSION='3.0.0'

declare BL64_CNT_MODULE='0'

declare BL64_CNT_DRIVER_DOCKER='docker'
declare BL64_CNT_DRIVER_PODMAN='podman'
declare BL64_CNT_DRIVER=''

declare BL64_CNT_FLAG_STDIN='-'

declare BL64_CNT_CMD_PODMAN=''
declare BL64_CNT_CMD_DOCKER=''

declare BL64_CNT_SET_DEBUG=''
declare BL64_CNT_SET_ENTRYPOINT=''
declare BL64_CNT_SET_FILE=''
declare BL64_CNT_SET_FILTER=''
declare BL64_CNT_SET_INTERACTIVE=''
declare BL64_CNT_SET_LOG_LEVEL=''
declare BL64_CNT_SET_NO_CACHE=''
declare BL64_CNT_SET_PASSWORD_STDIN=''
declare BL64_CNT_SET_PASSWORD=''
declare BL64_CNT_SET_QUIET=''
declare BL64_CNT_SET_RM=''
declare BL64_CNT_SET_TAG=''
declare BL64_CNT_SET_TTY=''
declare BL64_CNT_SET_USERNAME=''
declare BL64_CNT_SET_VERSION=''

declare BL64_CNT_SET_FILTER_ID=''
declare BL64_CNT_SET_FILTER_NAME=''
declare BL64_CNT_SET_LOG_LEVEL_DEBUG=''
declare BL64_CNT_SET_LOG_LEVEL_ERROR=''
declare BL64_CNT_SET_LOG_LEVEL_INFO=''
declare BL64_CNT_SET_STATUS_RUNNING=''


declare BL64_CNT_PATH_DOCKER_SOCKET=''

declare _BL64_CNT_TXT_NO_CLI='unable to detect supported container engine'
declare _BL64_CNT_TXT_EXISTING_NETWORK='container network already created. No further action needed'
declare _BL64_CNT_TXT_CREATE_NETWORK='creating container network'
declare _BL64_CNT_TXT_LOGIN_REGISTRY='loging to container registry'
declare _BL64_CNT_TXT_BUILD='build container image'
declare _BL64_CNT_TXT_PUSH='push container image to registry'
declare _BL64_CNT_TXT_PULL='pull container image from registry'
declare _BL64_CNT_TXT_TAG='add tag to container image'
declare _BL64_CNT_TXT_MISSING_FILTER='no filter was selected. Task requires one of them'
