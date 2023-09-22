#######################################
# BashLib64 / Module / Setup / Write messages to logs
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: log repository. Full path
#   $2: log target. Default: BL64_SCRIPT_ID
#   $2: level. One of BL64_LOG_CATEGORY_*
#   $3: format. One of BL64_LOG_FORMAT_*
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
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21
  bl64_dbg_lib_show_function "$@"
  local repository="${1:-}"
  local target="${2:-${BL64_SCRIPT_ID}}"
  local level="${3:-${BL64_LOG_CATEGORY_NONE}}"
  local format="${4:-${BL64_LOG_FORMAT_CSV}}"

  [[ -z "$repository" ]] && return $BL64_LIB_ERROR_PARAMETER_MISSING

  bl64_log_set_repository "$repository" &&
    bl64_log_set_target "$target" &&
    bl64_log_set_level "$level" &&
    bl64_log_set_format "$format" &&
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
  bl64_dbg_lib_show_function "$@"
  local repository="$1"

  if [[ ! -d "$repository" ]]; then
    "$BL64_FS_CMD_MKDIR" "$repository" &&
      "$BL64_FS_CMD_CHMOD" "$BL64_LOG_REPOSITORY_MODE" "$repository" ||
      return $BL64_LIB_ERROR_TASK_FAILED
  else
    [[ -w "$repository" ]] || return $BL64_LIB_ERROR_TASK_FAILED
  fi

  BL64_LOG_REPOSITORY="$repository"
  return 0
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
  bl64_dbg_lib_show_function "$@"
  local level="$1"

  case "$level" in
  "$BL64_LOG_CATEGORY_NONE") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_NONE" ;;
  "$BL64_LOG_CATEGORY_INFO") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_INFO" ;;
  "$BL64_LOG_CATEGORY_DEBUG") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_DEBUG" ;;
  "$BL64_LOG_CATEGORY_WARNING") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_WARNING" ;;
  "$BL64_LOG_CATEGORY_ERROR") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_ERROR" ;;
  *) return $BL64_LIB_ERROR_PARAMETER_INVALID ;;
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
  bl64_dbg_lib_show_function "$@"
  local format="$1"

  case "$format" in
  "$BL64_LOG_FORMAT_CSV")
    BL64_LOG_FORMAT="$BL64_LOG_FORMAT_CSV"
    BL64_LOG_FS=':'
    ;;
  *) return $BL64_LIB_ERROR_PARAMETER_INVALID ;;
  esac
}

#######################################
# Set log target
#
# * Log target is the file where logs will be written to
# * File is created or appended in the log repository
#
# Arguments:
#   $1: log target. Format: file name
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_target() {
  bl64_dbg_lib_show_function "$@"
  local target="$1"
  local destination="${BL64_LOG_REPOSITORY}/${target}"

  # Check if there is a new target to set
  [[ "$BL64_LOG_DESTINATION" == "$destination" ]] && return 0

  if [[ ! -w "$destination" ]]; then
    "$BL64_FS_CMD_TOUCH" "$destination" &&
      "$BL64_FS_CMD_CHMOD" "$BL64_LOG_TARGET_MODE" "$destination" ||
      return $BL64_LIB_ERROR_TASK_FAILED
  fi

  BL64_LOG_DESTINATION="$destination"
  return 0
}

#######################################
# Set runtime log target
#
# * Use to save output from commands using one file per execution
# * The target name is used as the directory for each execution
# * The target directory is created in the log repository
# * The calling script is responsible for redirecting the command's output to the target path BL64_LOG_RUNTIME
#
# Arguments:
#   $1: runtime log target. Format: directory name
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_runtime() {
  bl64_dbg_lib_show_function "$@"
  local target="$1"
  local destination="${BL64_LOG_REPOSITORY}/${target}"
  local log=''

  # Check if there is a new target to set
  [[ "$BL64_LOG_RUNTIME" == "$destination" ]] && return 0

  if [[ ! -d "$destination" ]]; then
    "$BL64_FS_CMD_MKDIR" "$destination" &&
      "$BL64_FS_CMD_CHMOD" "$BL64_LOG_REPOSITORY_MODE" "$destination" ||
      return $BL64_LIB_ERROR_TASK_FAILED
  fi

  [[ ! -w "$destination" ]] && return $BL64_LIB_ERROR_TASK_FAILED

  log="$(printf '%(%FT%TZ%z)T' '-1')" &&
    BL64_LOG_RUNTIME="${destination}/${log}.log" ||
    return 0

  return 0
}
