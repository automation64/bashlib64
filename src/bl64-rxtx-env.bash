#######################################
# BashLib64 / Module / Globals / Transfer and Receive data over the network
#######################################

# shellcheck disable=SC2034
{
  declare BL64_RXTX_VERSION='2.3.0'

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

  declare _BL64_RXTX_TXT_MISSING_COMMAND='no web transfer command was found on the system'
  declare _BL64_RXTX_TXT_EXISTING_DESTINATION='destination path is not empty. No action taken.'
  declare _BL64_RXTX_TXT_CREATION_PROBLEM='unable to create temporary git repo'
  declare _BL64_RXTX_TXT_DOWNLOAD_FILE='download file'
  declare _BL64_RXTX_TXT_ERROR_DOWNLOAD_FILE='file download failed'
  declare _BL64_RXTX_TXT_ERROR_DOWNLOAD_DIR='directory download failed'
}
