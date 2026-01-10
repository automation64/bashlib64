#######################################
# BashLib64 / Module / Globals / Interact with AWS
#######################################

# shellcheck disable=SC2034
{
  declare BL64_AWS_VERSION='4.0.4'

  declare BL64_AWS_MODULE='0'

  declare BL64_AWS_CMD_AWS="$BL64_VAR_UNAVAILABLE"

  declare BL64_AWS_DEF_SUFFIX_TOKEN=''
  declare BL64_AWS_DEF_SUFFIX_HOME=''
  declare BL64_AWS_DEF_SUFFIX_CACHE=''
  declare BL64_AWS_DEF_SUFFIX_CONFIG=''
  declare BL64_AWS_DEF_SUFFIX_CREDENTIALS=''

  declare BL64_AWS_CLI_MODE='0700'
  declare BL64_AWS_CLI_HOME=''
  declare BL64_AWS_CLI_CONFIG=''
  declare BL64_AWS_CLI_CREDENTIALS=''
  declare BL64_AWS_CLI_REGION=''

  declare BL64_AWS_SET_FORMAT_JSON=''
  declare BL64_AWS_SET_FORMAT_TEXT=''
  declare BL64_AWS_SET_FORMAT_TABLE=''
  declare BL64_AWS_SET_FORMAT_YAML=''
  declare BL64_AWS_SET_FORMAT_STREAM=''
  declare BL64_AWS_SET_DEBUG=''
  declare BL64_AWS_SET_OUPUT_NO_PAGER=''

  declare BL64_AWS_ACCESS_PROFILE=''
  declare BL64_AWS_ACCESS_KEY_ID=''
  declare BL64_AWS_ACCESS_KEY_SECRET=''
  declare BL64_AWS_ACCESS_TOKEN=''
  declare BL64_AWS_ACCESS_ROLE=''
  declare BL64_AWS_ACCESS_MODE=''
  declare BL64_AWS_ACCESS_MODE_PROFILE='P'
  declare BL64_AWS_ACCESS_MODE_SSO='S'
  declare BL64_AWS_ACCESS_MODE_KEY='K'
  declare BL64_AWS_ACCESS_MODE_TOKEN='T'
}
