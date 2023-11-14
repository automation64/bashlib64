#######################################
# BashLib64 / Module / Globals / Interact with GCP
#######################################

export BL64_GCP_VERSION='1.6.0'

# Optional module. Not enabled by default
export BL64_GCP_MODULE="$BL64_VAR_OFF"

export BL64_GCP_CMD_GCLOUD="$BL64_VAR_UNAVAILABLE"

export BL64_GCP_CONFIGURATION_NAME='bl64_gcp_configuration_private'
export BL64_GCP_CONFIGURATION_CREATED="$BL64_VAR_FALSE"

export BL64_GCP_SET_FORMAT_YAML=''
export BL64_GCP_SET_FORMAT_TEXT=''
export BL64_GCP_SET_FORMAT_JSON=''

export BL64_GCP_CLI_PROJECT=''
export BL64_GCP_CLI_IMPERSONATE_SA=''

declare _BL64_TXT_REMOVE_CREDENTIALS='remove previous GCP credentials'
declare _BL64_TXT_LOGIN_SA='activate service account'
declare _BL64_TXT_CREATE_CFG='create private GCP configuration'
