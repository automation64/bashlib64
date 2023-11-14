#######################################
# BashLib64 / Module / Globals / Interact with Ansible CLI
#######################################

export BL64_ANS_VERSION='1.6.0'

# Optional module. Not enabled by default
export BL64_ANS_MODULE="$BL64_VAR_OFF"

export BL64_ANS_ENV_IGNORE=''

export BL64_ANS_VERSION_CORE=''

export BL64_ANS_CMD_ANSIBLE="$BL64_VAR_UNAVAILABLE"
export BL64_ANS_CMD_ANSIBLE_PLAYBOOK="$BL64_VAR_UNAVAILABLE"
export BL64_ANS_CMD_ANSIBLE_GALAXY="$BL64_VAR_UNAVAILABLE"

export BL64_ANS_PATH_USR_ANSIBLE=''
export BL64_ANS_PATH_USR_COLLECTIONS=''
export BL64_ANS_PATH_USR_CONFIG=''

export BL64_ANS_SET_VERBOSE=''
export BL64_ANS_SET_DIFF=''
export BL64_ANS_SET_DEBUG=''

declare _BL64_ANS_TXT_ERROR_GET_VERSION='failed to get CLI version'
