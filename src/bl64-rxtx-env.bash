#######################################
# BashLib64 / Module / Globals / Transfer and Receive data over the network
#######################################

# shellcheck disable=SC2034
{
  declare BL64_RXTX_VERSION='2.6.3'

  declare BL64_RXTX_MODULE='0'

  declare BL64_RXTX_CMD_CURL=''
  declare BL64_RXTX_CMD_WGET=''

  declare BL64_RXTX_ALIAS_CURL=''
  declare BL64_RXTX_ALIAS_WGET=''

  declare BL64_RXTX_SET_CURL_FAIL=''
  declare BL64_RXTX_SET_CURL_HEADER=''
  declare BL64_RXTX_SET_CURL_INCLUDE=''
  declare BL64_RXTX_SET_CURL_OUTPUT=''
  declare BL64_RXTX_SET_CURL_REDIRECT=''
  declare BL64_RXTX_SET_CURL_REQUEST=''
  declare BL64_RXTX_SET_CURL_SECURE=''
  declare BL64_RXTX_SET_CURL_SILENT=''
  declare BL64_RXTX_SET_CURL_VERBOSE=''
  declare BL64_RXTX_SET_WGET_OUTPUT=''
  declare BL64_RXTX_SET_WGET_SECURE=''
  declare BL64_RXTX_SET_WGET_VERBOSE=''

  #
  # GitHub specific parameters
  #

  # Public server
  declare BL64_RXTX_GITHUB_URL='https://github.com'
}
