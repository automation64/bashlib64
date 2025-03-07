#######################################
# BashLib64 / Module / Setup / Interact with GCP
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: (optional) Full path where commands are
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_gcp_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be sourced at the end' && return 21
  local gcloud_bin="${1:-${BL64_VAR_DEFAULT}}"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function "$@" &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_gcp_set_command "$gcloud_bin" &&
    _bl64_gcp_set_options &&
    bl64_check_command "$BL64_GCP_CMD_GCLOUD" &&
    BL64_GCP_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'gcp'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_gcp_set_command() {
  bl64_dbg_lib_show_function "$@"
  local gcloud_bin="${1:-${BL64_VAR_DEFAULT}}"

  if [[ "$gcloud_bin" == "$BL64_VAR_DEFAULT" ]]; then
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/gcloud' ]]; then
      gcloud_bin='/home/linuxbrew/.linuxbrew/bin'
    elif [[ -x '/opt/homebrew/bin/gcloud' ]]; then
      gcloud_bin='/opt/homebrew/bin'
    elif [[ -x '/usr/local/bin/gcloud' ]]; then
      gcloud_bin='/usr/local/bin'
    elif [[ -x '/usr/bin/gcloud' ]]; then
      gcloud_bin='/usr/bin'
    else
      bl64_check_alert_resource_not_found 'gcloud'
      return $?
    fi
  fi

  bl64_check_directory "$gcloud_bin" || return $?
  [[ -x "${gcloud_bin}/gcloud" ]] && BL64_GCP_CMD_GCLOUD="${gcloud_bin}/gcloud"

  bl64_dbg_lib_show_vars 'BL64_GCP_CMD_GCLOUD'
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
function _bl64_gcp_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  BL64_GCP_SET_FORMAT_YAML='--format yaml' &&
    BL64_GCP_SET_FORMAT_TEXT='--format text' &&
    BL64_GCP_SET_FORMAT_JSON='--format json'
}

#######################################
# Set target GCP Project
#
# * Available to all gcloud related commands
#
# Arguments:
#   $1: GCP project ID
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_gcp_set_project() {
  bl64_dbg_lib_show_function "$@"
  local project="${1:-}"

  bl64_check_parameter 'project' || return $?

  BL64_GCP_CLI_PROJECT="$project"

  bl64_dbg_lib_show_vars 'BL64_GCP_CLI_PROJECT'
  return 0
}

#######################################
# Enable service account impersonation
#
# * Available to all gcloud related commands
#
# Arguments:
#   $1: Service Account email
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: set ok
#   >0: failed to set
#######################################
function bl64_gcp_set_impersonate_sa() {
  bl64_dbg_lib_show_function "$@"
  local impersonate_sa="${1:-}"

  bl64_check_parameter 'impersonate_sa' || return $?

  BL64_GCP_CLI_IMPERSONATE_SA="$impersonate_sa"

  bl64_dbg_lib_show_vars 'BL64_GCP_CLI_IMPERSONATE_SA'
  return 0
}
