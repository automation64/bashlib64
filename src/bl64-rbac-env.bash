#######################################
# BashLib64 / Module / Globals / Manage role based access service
#
# Version: 1.5.0
#######################################

export BL64_RBAC_MODULE="$BL64_LIB_VAR_OFF"

export BL64_RBAC_CMD_SUDO=''
export BL64_RBAC_CMD_VISUDO=''
export BL64_RBAC_FILE_SUDOERS=''

export BL64_RBAC_ALIAS_SUDO_ENV=''

declare _BL64_RBAC_TXT_INVALID_SUDOERS='the sudoers file is corrupt or invalid'
declare _BL64_RBAC_TXT_ADD_ROOT='add password-less root privilege to user'
