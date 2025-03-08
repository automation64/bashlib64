#######################################
# BashLib64 / Module / Globals / Interact with container engines
#######################################

# shellcheck disable=SC2034
{
  declare BL64_CNT_VERSION='3.5.1'

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
}
