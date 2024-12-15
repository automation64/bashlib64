#######################################
# BashLib64 / Module / Setup / Write messages to logs
#######################################

function _bl64_log_set_target_single() {
  bl64_dbg_lib_log_enabled && bl64_dbg_lib_show_function "$@"
  local target="$1"
  local destination="${BL64_LOG_REPOSITORY}/${target}.log"

  [[ "$BL64_LOG_DESTINATION" == "$destination" ]] && return 0
  bl64_fs_file_create "$destination" "$BL64_LOG_TARGET_MODE" &&
    BL64_LOG_DESTINATION="$destination"
}

function _bl64_log_set_target_multiple() {
  bl64_dbg_lib_log_enabled && bl64_dbg_lib_show_function "$@"
  local target="$1"
  local destination="${BL64_LOG_REPOSITORY}/${target}_"

  destination+="$(printf '%(%FT%TZ%z)T' '-1').log" || return $?
  [[ "$BL64_LOG_DESTINATION" == "$destination" ]] && return 0

  bl64_fs_file_create "$destination" "$BL64_LOG_TARGET_MODE" &&
    BL64_LOG_DESTINATION="$destination"
}

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: log repository. Full path
#   $2: log target. Default: BL64_SCRIPT_ID
#   $3: target type. One of BL64_LOG_TYPE_*
#   $4: level. One of BL64_LOG_CATEGORY_*
#   $5: format. One of BL64_LOG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function bl64_log_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last sourced module' &&
    return 21
  bl64_dbg_lib_log_enabled && bl64_dbg_lib_show_function "$@"
  local log_repository="${1:-}"
  local log_target="${2:-${BL64_VAR_DEFAULT}}"
  local log_type="${3:-${BL64_VAR_DEFAULT}}"
  local log_level="${4:-${BL64_VAR_DEFAULT}}"
  local log_format="${5:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'log_repository' ||
    return $?

  [[ "$log_target" == "$BL64_VAR_DEFAULT" ]] && log_target="$BL64_SCRIPT_ID"
  [[ "$log_type" == "$BL64_VAR_DEFAULT" ]] && log_type="$BL64_LOG_TYPE_SINGLE"
  [[ "$log_level" == "$BL64_VAR_DEFAULT" ]] && log_level="$BL64_LOG_CATEGORY_NONE"
  [[ "$log_format" == "$BL64_VAR_DEFAULT" ]] && log_format="$BL64_LOG_FORMAT_CSV"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_FS_MODULE' &&
    bl64_log_set_repository "$log_repository" &&
    bl64_log_set_target "$log_target" "$log_type" &&
    bl64_log_set_level "$log_level" &&
    bl64_log_set_format "$log_format" &&
    BL64_LOG_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'log'
}

#######################################
# Set log repository
#
# * Create the repository directory
#
# Arguments:
#   $1: repository path
# Outputs:
#   STDOUT: None
#   STDERR: command stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_repository() {
  bl64_dbg_lib_log_enabled && bl64_dbg_lib_show_function "$@"
  local log_repository="$1"

  bl64_check_parameter 'log_repository' || return $?
  [[ "$BL64_LOG_REPOSITORY" == "$log_repository" ]] && return 0

  bl64_fs_dir_create \
    "$BL64_LOG_REPOSITORY_MODE" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$log_repository" ||
    return $?

  BL64_LOG_REPOSITORY="$log_repository"
}

#######################################
# Set logging level
#
# Arguments:
#   $1: target level. One of BL64_LOG_CATEGORY_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_level() {
  bl64_dbg_lib_log_enabled && bl64_dbg_lib_show_function "$@"
  local log_level="$1"

  case "$log_level" in
  "$BL64_LOG_CATEGORY_NONE") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_NONE" ;;
  "$BL64_LOG_CATEGORY_INFO") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_INFO" ;;
  "$BL64_LOG_CATEGORY_DEBUG") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_DEBUG" ;;
  "$BL64_LOG_CATEGORY_WARNING") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_WARNING" ;;
  "$BL64_LOG_CATEGORY_ERROR") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_ERROR" ;;
  *) bl64_check_alert_parameter_invalid 'log_level' ;;
  esac
}

#######################################
# Set log format
#
# Arguments:
#   $1: log format. One of BL64_LOG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_format() {
  bl64_dbg_lib_log_enabled && bl64_dbg_lib_show_function "$@"
  local log_format="$1"

  case "$log_format" in
  "$BL64_LOG_FORMAT_CSV")
    BL64_LOG_FORMAT="$BL64_LOG_FORMAT_CSV"
    BL64_LOG_FS=':'
    ;;
  *) bl64_check_alert_parameter_invalid 'log_format' ;;
  esac
}

#######################################
# Set log target
#
# * Target is created or appended on the log repository
#
# Arguments:
#   $1: log target. Format: file name
#   $2: target type
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_target() {
  bl64_dbg_lib_log_enabled && bl64_dbg_lib_show_function "$@"
  local log_target="$1"
  local log_type="$2"

  bl64_check_parameter 'log_target' &&
    bl64_check_parameter 'log_type' ||
    return $?

  case "$log_type" in
  "$BL64_LOG_TYPE_SINGLE")
    _bl64_log_set_target_single "$log_target"
    ;;
  "$BL64_LOG_TYPE_MULTIPLE")
    _bl64_log_set_target_multiple "$log_target"
    ;;
  *)
    bl64_check_alert_parameter_invalid 'log_type'
    return $?
    ;;
  esac
}
