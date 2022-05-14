#######################################
# BashLib64 / Module / Globals / Interact with GCP CLI
#
# Version: 1.1.0
#######################################

# Optional module. Not enabled by default
export BL64_GCP_MODULE="$BL64_LIB_VAR_OFF"

export BL64_GCP_CMD_GCLOUD="${BL64_GCP_CMD_GCLOUD:-}"

export BL64_GCP_CONFIGURATION_NAME='bl64_gcp_configuration_private'
export BL64_GCP_CONFIGURATION_CREATED="$BL64_LIB_VAR_FALSE"

export BL64_GCP_SET_FORMAT_YAML=''
export BL64_GCP_SET_FORMAT_TEXT=''
export BL64_GCP_SET_FORMAT_JSON=''
