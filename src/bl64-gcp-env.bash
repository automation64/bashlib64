#######################################
# BashLib64 / Module / Globals / Interact with GCP
#######################################

declare BL64_GCP_VERSION='1.6.1'

declare BL64_GCP_MODULE='0'

declare BL64_GCP_CMD_GCLOUD="$BL64_VAR_UNAVAILABLE"

declare BL64_GCP_CONFIGURATION_NAME='bl64_gcp_configuration_private'
declare BL64_GCP_CONFIGURATION_CREATED="$BL64_VAR_FALSE"

declare BL64_GCP_SET_FORMAT_YAML=''
declare BL64_GCP_SET_FORMAT_TEXT=''
declare BL64_GCP_SET_FORMAT_JSON=''

declare BL64_GCP_CLI_PROJECT=''
declare BL64_GCP_CLI_IMPERSONATE_SA=''

declare _BL64_TXT_REMOVE_CREDENTIALS='remove previous GCP credentials'
declare _BL64_TXT_LOGIN_SA='activate service account'
declare _BL64_TXT_CREATE_CFG='create private GCP configuration'
