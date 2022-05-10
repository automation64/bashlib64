#######################################
# BashLib64 / Module / Globals / Transfer and Receive data over the network
#
# Version: 1.5.0
#######################################

export BL64_RXTX_CMD_CURL=''
export BL64_RXTX_CMD_WGET=''

export BL64_RXTX_ALIAS_CURL=''
export BL64_RXTX_ALIAS_WGET=''

export BL64_RXTX_SET_CURL_VERBOSE=''
export BL64_RXTX_SET_CURL_OUTPUT=''
export BL64_RXTX_SET_CURL_SILENT=''
export BL64_RXTX_SET_CURL_REDIRECT=''
export BL64_RXTX_SET_CURL_SECURE=''
export BL64_RXTX_SET_WGET_VERBOSE=''
export BL64_RXTX_SET_WGET_OUTPUT=''
export BL64_RXTX_SET_WGET_SECURE=''

readonly _BL64_RXTX_TXT_MISSING_COMMAND='no web transfer command was found on the system'
readonly _BL64_RXTX_TXT_EXISTING_DESTINATION='destination path is not empty. No action taken.'
readonly _BL64_RXTX_TXT_CREATION_PROBLEM='unable to create temporary git repo'
readonly _BL64_RXTX_TXT_DOWNLOAD_FILE='download file'

readonly _BL64_RXTX_BACKUP_POSTFIX='._bl64_rxtx_backup'
