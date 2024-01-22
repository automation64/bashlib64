#######################################
# BashLib64 / Module / Globals / Manipulate CSV like text files
#######################################

export BL64_XSV_VERSION='1.7.1'

declare BL64_XSV_MODULE='0'

export BL64_XSV_CMD_YQ="$BL64_VAR_UNAVAILABLE"
export BL64_XSV_CMD_JQ="$BL64_VAR_UNAVAILABLE"

# Field separators
export BL64_XSV_FS='_@64@_' # Custom
export BL64_XSV_FS_SPACE=' '
export BL64_XSV_FS_NEWLINE=$'\n'
export BL64_XSV_FS_TAB=$'\t'
export BL64_XSV_FS_COLON=':'
export BL64_XSV_FS_SEMICOLON=';'
export BL64_XSV_FS_COMMA=','
export BL64_XSV_FS_PIPE='|'
export BL64_XSV_FS_AT='@'
export BL64_XSV_FS_DOLLAR='$'
export BL64_XSV_FS_SLASH='/'

# Common search paths for commands
declare -a _BL64_XSV_SEARCH_PATHS=('/home/linuxbrew/.linuxbrew/bin' '/opt/homebrew/bin' '/usr/local/bin' '/usr/bin')

export _BL64_XSV_TXT_SOURCE_NOT_FOUND='source file not found'
