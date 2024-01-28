#######################################
# BashLib64 / Module / Globals / Interact with Ansible CLI
#######################################

declare BL64_ANS_VERSION='2.0.0'

declare BL64_ANS_MODULE='0'

declare BL64_ANS_ENV_IGNORE=''

declare BL64_ANS_VERSION_CORE=''

declare BL64_ANS_CMD_ANSIBLE="$BL64_VAR_UNAVAILABLE"
declare BL64_ANS_CMD_ANSIBLE_PLAYBOOK="$BL64_VAR_UNAVAILABLE"
declare BL64_ANS_CMD_ANSIBLE_GALAXY="$BL64_VAR_UNAVAILABLE"

declare BL64_ANS_PATH_USR_ANSIBLE=''
declare BL64_ANS_PATH_USR_COLLECTIONS=''
declare BL64_ANS_PATH_USR_CONFIG=''

declare BL64_ANS_SET_VERBOSE=''
declare BL64_ANS_SET_DIFF=''
declare BL64_ANS_SET_DEBUG=''

declare _BL64_ANS_TXT_ERROR_GET_VERSION='failed to get CLI version'
