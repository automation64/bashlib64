#######################################
# BashLib64 / Module / Globals / Manage archive files
#######################################

# shellcheck disable=SC2034
{
  declare BL64_ARC_VERSION='4.4.0'

  declare BL64_ARC_MODULE='0'

  declare BL64_ARC_CMD_BUNZIP2="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_GUNZIP="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_TAR="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_UNXZ="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_UNZIP="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_ZIP="$BL64_VAR_UNAVAILABLE"
  declare BL64_ARC_CMD_7ZZ="$BL64_VAR_UNAVAILABLE"

  declare BL64_ARC_SET_TAR_VERBOSE=''

  declare BL64_ARC_SET_UNZIP_OVERWRITE=''
}
