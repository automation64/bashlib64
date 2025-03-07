#######################################
# BashLib64 / Module / Globals / Manipulate text files content
#######################################

# shellcheck disable=SC2034
{
  declare BL64_TXT_VERSION='2.4.0'

  declare BL64_TXT_MODULE='0'

  declare BL64_TXT_CMD_AWK_POSIX="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_AWK="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_BASE64="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_CUT="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_ENVSUBST="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_GAWK="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_GREP="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_SED="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_SORT="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_TR="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_CMD_UNIQ="$BL64_VAR_UNAVAILABLE"

  declare BL64_TXT_SET_AWK_POSIX=''
  declare BL64_TXT_SET_AWS_FS="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_ERE="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_INVERT="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_LINE="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_NO_CASE="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_QUIET="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_SHOW_FILE_ONLY="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_STDIN="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_GREP_STRING="$BL64_VAR_UNAVAILABLE"
  declare BL64_TXT_SET_SED_EXPRESSION="$BL64_VAR_UNAVAILABLE"

  declare BL64_TXT_FLAG_STDIN='STDIN'
}
