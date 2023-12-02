#######################################
# BashLib64 / Module / Setup / Manipulate CSV like text files
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $@: (optional) search full paths for tools
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_xsv_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
  local search_paths=("${@:-}")

  bl64_lib_module_imported 'BL64_DBG_MODULE' &&
    bl64_lib_module_imported 'BL64_CHECK_MODULE' &&
    bl64_lib_module_imported 'BL64_TXT_MODULE' &&
    _bl64_xsv_set_command "${search_paths[@]}" &&
    BL64_XSV_MODULE="$BL64_VAR_ON"

  bl64_dbg_lib_show_function
  bl64_check_alert_module_setup ' xsv'
}

#######################################
# Identify and normalize commands
#
# * If no values are provided, try to detect commands looking for common paths
# * Commands are exported as variables with full path
# * All commands are optional, no error if not found
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_xsv_set_command() {
  bl64_dbg_lib_show_function "$@"
  local search_paths=("${@:-${_BL64_XSV_SEARCH_PATHS[@]}}")

  for path in "${search_paths[@]}"; do
    bl64_dbg_lib_show_info "search for commands in the path (${path})"
    [[ ! -d "$path" ]] && continue
    [[ -x "${path}/jq" ]] && BL64_XSV_CMD_JQ="${path}/jq"
    [[ -x "${path}/yq" ]] && BL64_XSV_CMD_YQ="${path}/yq"
  done

  bl64_dbg_lib_show_vars 'BL64_XSV_CMD_YQ' 'BL64_XSV_CMD_JQ'
  return 0
}
