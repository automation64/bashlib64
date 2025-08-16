#######################################
# BashLib64 / Module / Globals / Manage OS identity and access service
#######################################

# shellcheck disable=SC2034
{
  declare BL64_IAM_VERSION='6.0.1'

  declare BL64_IAM_MODULE='0'

  declare BL64_IAM_CMD_USERADD="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_USERMOD="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_GROUPADD="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_GROUPMOD="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_ADDUSER="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_ADDGROUP="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_SYSADMINCTL="$BL64_VAR_INCOMPATIBLE"
  declare BL64_IAM_CMD_ID=''

  declare BL64_IAM_SET_USERADD_CREATE_HOME=''
  declare BL64_IAM_SET_USERADD_GROUP=''
  declare BL64_IAM_SET_USERADD_HOME_PATH=''
  declare BL64_IAM_SET_USERADD_SHELL=''
  declare BL64_IAM_SET_USERADD_UID=''

  declare BL64_IAM_ALIAS_USERADD=''

  declare BL64_IAM_SYSTEM_USER=''
  declare BL64_IAM_SYSTEM_GROUP=''
}
