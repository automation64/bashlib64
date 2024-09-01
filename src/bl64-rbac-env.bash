#######################################
# BashLib64 / Module / Globals / Manage role based access service
#######################################

# shellcheck disable=SC2034
{
  declare BL64_RBAC_VERSION='2.2.0'

  declare BL64_RBAC_MODULE='0'

  declare BL64_RBAC_CMD_SUDO=''
  declare BL64_RBAC_CMD_VISUDO=''
  declare BL64_RBAC_FILE_SUDOERS=''

  declare BL64_RBAC_ALIAS_SUDO_ENV=''

  declare BL64_RBAC_SET_SUDO_CHECK=''
  declare BL64_RBAC_SET_SUDO_FILE=''
  declare BL64_RBAC_SET_SUDO_QUIET=''

  declare _BL64_RBAC_TXT_INVALID_SUDOERS='the sudoers file is corrupt or invalid'
  declare _BL64_RBAC_TXT_ADD_ROOT='add password-less root privilege to user'
}
