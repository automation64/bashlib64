#######################################
# BashLib64 / Module / Globals / Cryptography tools
#######################################

# shellcheck disable=SC2034
{
  declare BL64_CRYP_VERSION='2.1.0'

  declare BL64_CRYP_MODULE='0'

  declare BL64_CRYP_CMD_GPG=''
  declare BL64_CRYP_CMD_OPENSSL=''

  declare _BL64_CRYP_TXT_KEY_ARMOR='export GPG key file and prepare for distribution'
  declare _BL64_CRYP_TXT_KEY_DEARMOR='dearmor exported GPG key file'
}
