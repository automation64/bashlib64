#######################################
# BashLib64 / Module / Globals / Manipulate CSV like text files
#######################################

# shellcheck disable=SC2034
{
  declare BL64_XSV_VERSION='2.0.0'

  declare BL64_XSV_MODULE='0'

  declare BL64_XSV_CMD_YQ="$BL64_VAR_UNAVAILABLE"
  declare BL64_XSV_CMD_JQ="$BL64_VAR_UNAVAILABLE"

  #
  # Field separators
  #
  # shellcheck disable=SC2034
  declare BL64_XSV_FS='_@64@_'
  declare BL64_XSV_FS_SPACE=' '
  declare BL64_XSV_FS_NEWLINE=$'\n'
  declare BL64_XSV_FS_TAB=$'\t'
  declare BL64_XSV_FS_COLON=':'
  declare BL64_XSV_FS_SEMICOLON=';'
  declare BL64_XSV_FS_COMMA=','
  declare BL64_XSV_FS_PIPE='|'
  declare BL64_XSV_FS_AT='@'
  declare BL64_XSV_FS_DOLLAR='$'
  declare BL64_XSV_FS_SLASH='/'

  # Common search paths for commands
  declare -a _BL64_XSV_SEARCH_PATHS=('/home/linuxbrew/.linuxbrew/bin' '/opt/homebrew/bin' '/usr/local/bin' '/usr/bin')

  declare _BL64_XSV_TXT_SOURCE_NOT_FOUND='source file not found'
}
