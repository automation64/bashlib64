#######################################
# BashLib64 / Module / Functions / Interact with GCP CLI
#
# Version: 1.0.0
#######################################

#######################################
# GCloud wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_gcp_run_gcloud() {
  bl64_dbg_lib_show_function "$@"
  local debug=' '
  local config=' '

  bl64_check_command "$BL64_GCP_CMD_GCLOUD" || return $?

  if bl64_dbg_lib_command_enabled; then
    debug='--verbosity debug --log-http'
  else
    debug='--verbosity none --quiet'
  fi

  [[ "$BL64_GCP_CONFIGURATION_CREATED" == "$BL64_LIB_VAR_TRUE" ]] && config="--configuration $BL64_GCP_CONFIGURATION_NAME"

  "$BL64_GCP_CMD_GCLOUD" \
    $debug \
    $config \
    "$@"
}

#######################################
# Login to GCP using a Service Account
#
# * key must be in json format
# * previous credentials are revoked
#
# Arguments:
#   $1: key file full path
#   $2: project id
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_gcp_login_sa() {
  bl64_dbg_lib_show_function "$@"
  local key_file="$1"
  local project="$2"

  bl64_check_parameter 'key_file' &&
    bl64_check_parameter 'project' &&
    bl64_check_file "$key_file" || return $?

  _bl64_gcp_configure

  bl64_dbg_lib_show_info 'remove previous credentials'
  bl64_gcp_run_gcloud \
    auth \
    revoke \
    --all

  bl64_dbg_lib_show_info 'login to gcp'
  bl64_gcp_run_gcloud \
    auth \
    activate-service-account \
    --key-file "$key_file" \
    --project "$project"
}

function _bl64_gcp_configure() {
  bl64_dbg_lib_show_function

  if [[ "$BL64_GCP_CONFIGURATION_CREATED" == "$BL64_LIB_VAR_FALSE" ]]; then

    bl64_dbg_lib_show_info 'create BL64_GCP_CONFIGURATION'
    bl64_gcp_run_gcloud \
      config \
      configurations \
      create "$BL64_GCP_CONFIGURATION_NAME" &&
      BL64_GCP_CONFIGURATION_CREATED="$BL64_LIB_VAR_TRUE"

  else
    :
  fi
}
