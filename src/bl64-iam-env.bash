#######################################
# BashLib64 / Module / Globals / Manage OS identity and access service
#######################################

# shellcheck disable=SC2034
declare BL64_IAM_VERSION='4.0.0'

declare BL64_IAM_MODULE='0'

declare BL64_IAM_CMD_USERADD=''
declare BL64_IAM_CMD_ID=''

declare BL64_IAM_SET_USERADD_CREATE_HOME=''
declare BL64_IAM_SET_USERADD_GROUP=''
declare BL64_IAM_SET_USERADD_HOME_PATH=''
declare BL64_IAM_SET_USERADD_SHELL=''

declare BL64_IAM_ALIAS_USERADD=''

declare _BL64_IAM_TXT_ADD_USER='create user account'
declare _BL64_IAM_TXT_EXISTING_USER='user already created, re-using existing one'
declare _BL64_IAM_TXT_USER_NOT_FOUND='required user is not present in the operating system'
