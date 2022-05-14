#######################################
# BashLib64 / Module / Globals / Interact with Ansible CLI
#
# Version: 1.0.0
#######################################

# Optional module. Not enabled by default
export BL64_ANS_MODULE="$BL64_LIB_VAR_OFF"

export BL64_ANS_CMD_ANSIBLE="${BL64_ANS_CMD_ANSIBLE:-}"
export BL64_ANS_CMD_ANSIBLE_PLAYBOOK="${BL64_ANS_CMD_ANSIBLE_PLAYBOOK:-}"
export BL64_ANS_CMD_ANSIBLE_GALAXY="${BL64_ANS_CMD_ANSIBLE_GALAXY:-}"

export BL64_ANS_SET_VERBOSE=''
export BL64_ANS_SET_DIFF=''
export BL64_ANS_SET_DEBUG=''
