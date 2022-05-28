#######################################
# BashLib64 / Module / Setup / Interact with GCP CLI
#
# Version: 1.1.0
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_gcp_setup() {
  bl64_dbg_lib_show_function

  bl64_gcp_set_command &&
    bl64_gcp_set_options &&
    BL64_GCP_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_gcp_set_command() {
  bl64_dbg_lib_show_function

  # Detect gcloud location
  if [[ -z "$BL64_GCP_CMD_GCLOUD" ]]; then
    if [[ -x '/usr/bin/gcloud' ]]; then
      BL64_GCP_CMD_GCLOUD='/usr/bin/gcloud'
    elif [[ -x '/opt/homebrew/bin/gcloud' ]]; then
      BL64_GCP_CMD_GCLOUD='/opt/homebrew/bin/gcloud'
    elif [[ -x '/home/linuxbrew/.linuxbrew/bin/gcloud' ]]; then
      BL64_GCP_CMD_GCLOUD='/home/linuxbrew/.linuxbrew/bin/gcloud'
    else
      BL64_GCP_CMD_GCLOUD="$BL64_LIB_UNAVAILABLE"
    fi
  fi

  return 0
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_gcp_set_options() {
  BL64_GCP_SET_FORMAT_YAML='--format yaml'
  BL64_GCP_SET_FORMAT_TEXT='--format text'
  BL64_GCP_SET_FORMAT_JSON='--format json'
}
