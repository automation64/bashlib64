#######################################
# BashLib64 / Module / Functions / Transfer and Receive data over the network
#######################################

#######################################
# Pull data from web server
#
# * If the destination is already present no update is done unless $3=$BL64_VAR_ON
#
# Arguments:
#   $1: Source URL
#   $2: Full path to the destination file
#   $3: replace existing file. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $4: file permissions. Format: chown format. Default: use current umask
#   $5: file user name. Default: current
#   $6: file group name. Default: current
# Outputs:
#   STDOUT: None unless BL64_DBG_TARGET_LIB_CMD
#   STDERR: command error
# Returns:
#   BL64_LIB_ERROR_APP_MISSING
#   command error status
#######################################
function bl64_rxtx_web_get_file() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local replace="${3:-${BL64_VAR_DEFAULT}}"
  local file_mode="${4:-${BL64_VAR_DEFAULT}}"
  local file_user="${5:-${BL64_VAR_DEFAULT}}"
  local file_group="${6:-${BL64_VAR_DEFAULT}}"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_fs_check_new_file "$destination" ||
    return $?

  bl64_check_overwrite_skip "$destination" "$replace" && return

  bl64_fs_path_archive "$destination" >/dev/null || return $?

  bl64_msg_show_lib_subtask "download file (${source})"
  # shellcheck disable=SC2086
  if [[ -x "$BL64_RXTX_CMD_CURL" ]]; then
    bl64_rxtx_run_curl \
      $BL64_RXTX_SET_CURL_FAIL \
      $BL64_RXTX_SET_CURL_REDIRECT \
      $BL64_RXTX_SET_CURL_OUTPUT "$destination" \
      "$source"
    status=$?
  elif [[ -x "$BL64_RXTX_CMD_WGET" ]]; then
    bl64_rxtx_run_wget \
      $BL64_RXTX_SET_WGET_OUTPUT "$destination" \
      "$source"
    status=$?
  else
    bl64_msg_show_lib_error "no web transfer command was found on the system (wget or curl)" &&
      return "$BL64_LIB_ERROR_APP_MISSING"
  fi

  if ((status != 0)); then
    bl64_msg_show_lib_error 'file download failed'
  else
    bl64_fs_path_permission_set "$file_mode" "$BL64_VAR_DEFAULT" "$file_user" "$file_group" "$BL64_VAR_OFF" "$destination"
    status=$?
  fi

  bl64_fs_path_recover "$destination" "$status" || return $?
  return "$status"
}

#######################################
# Pull directory contents from git repo
#
# * Content of source path is downloaded into destination (source_path/* --> destionation/). Source path itself is not created
# * If the destination is already present no update is done unless $4=$BL64_VAR_ON
# * If asked to replace destination, temporary backup is done in case git fails by moving the destination to a temp name
# * Warning: git repo info is removed after pull (.git)
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: source path. Format: relative to the repo URL. Use '.' to download the full repo
#   $3: destination path. Format: full path
#   $4: replace existing content. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $5: branch name. Default: main
# Outputs:
#   STDOUT: command stdout
#   STDERR: command error
# Returns:
#   0: operation OK
#   BL64_LIB_ERROR_TASK_TEMP
#   command error status
#######################################
function bl64_rxtx_git_get_dir() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local replace="${4:-${BL64_VAR_DEFAULT}}"
  local branch="${5:-main}"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'source_url' &&
    bl64_check_parameter 'source_path' &&
    bl64_check_parameter 'destination' &&
    bl64_check_path_relative "$source_path" &&
    bl64_fs_check_new_dir "$destination" ||
    return $?

  # shellcheck disable=SC2086
  bl64_check_overwrite_skip "$destination" "$replace" && return $?
  bl64_fs_path_archive "$destination" || return $?

  bl64_msg_show_lib_subtask "clone source repository (${source_url})"
  if [[ "$source_path" == '.' || "$source_path" == './' ]]; then
    _bl64_rxtx_git_get_dir_root "$source_url" "$destination" "$branch"
  else
    _bl64_rxtx_git_get_dir_sub "$source_url" "$source_path" "$destination" "$branch"
  fi
  status=$?
  ((status != 0)) && bl64_msg_show_lib_error 'directory download failed'

  if [[ "$status" == '0' && -d "${destination}/.git" ]]; then
    bl64_msg_show_lib_subtask "remove git metadata (${destination}/.git)"
    bl64_bsh_run_pushd "$destination" &&
      bl64_fs_path_remove '.git' &&
      bl64_bsh_run_popd
    status=$?
  fi

  bl64_fs_path_recover "$destination" "$status" || return $?
  return "$status"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * verbose is not implemented to avoid unintentional alteration of output when using for APIs
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_rxtx_run_curl() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_RXTX_SET_CURL_SILENT"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_command "$BL64_RXTX_CMD_CURL" || return $?

  bl64_msg_app_run_is_enabled && verbose=''
  bl64_dbg_lib_command_is_enabled && verbose="$BL64_RXTX_SET_CURL_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_RXTX_CMD_CURL" \
    $BL64_RXTX_SET_CURL_SECURE \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_rxtx_run_wget() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_command "$BL64_RXTX_CMD_WGET" || return $?

  bl64_dbg_lib_command_is_enabled &&
    verbose="$BL64_RXTX_SET_WGET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_RXTX_CMD_WGET" \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

function _bl64_rxtx_git_get_dir_root() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local destination="${2}"
  local branch="${3:-main}"
  local -i status=0
  local repo=''
  local git_name=''
  local transition=''

  bl64_check_module 'BL64_RXTX_MODULE' || return $?

  repo="$($BL64_FS_ALIAS_MKTEMP_DIR)"
  bl64_check_directory "$repo" 'unable to create temporary git repo' || return "$BL64_LIB_ERROR_TASK_TEMP"

  git_name="$(bl64_fmt_path_get_basename "$source_url")"
  git_name="${git_name/.git/}"
  transition="${repo}/${git_name}"
  bl64_dbg_lib_show_vars 'git_name' 'transition'

  bl64_dbg_lib_show_comments 'Clone the repo'
  bl64_vcs_git_clone "$source_url" "$repo" "$branch" &&
    bl64_dbg_lib_show_info 'promote to destination' &&
    bl64_fs_run_mv "$transition" "$destination"
  status=$?

  [[ -d "$repo" ]] && bl64_fs_path_remove "$repo" >/dev/null
  return "$status"
}

function _bl64_rxtx_git_get_dir_sub() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local branch="${4:-main}"
  local -i status=0
  local repo=''
  local target=''
  local source=''
  local transition=''

  bl64_check_module 'BL64_RXTX_MODULE' || return $?

  repo="$($BL64_FS_ALIAS_MKTEMP_DIR)"
  # shellcheck disable=SC2086
  bl64_check_directory "$repo" 'unable to create temporary git repo' || return "$BL64_LIB_ERROR_TASK_TEMP"

  bl64_dbg_lib_show_comments 'Use transition path to get to the final target path'
  source="${repo}/${source_path}"
  target="$(bl64_fmt_path_get_basename "$destination")"
  transition="${repo}/transition/${target}"
  bl64_dbg_lib_show_vars 'source' 'target' 'transition'

  bl64_vcs_git_sparse "$source_url" "$repo" "$branch" "$source_path" &&
    [[ -d "$source" ]] &&
    bl64_fs_mkdir_full "${repo}/transition" &&
    bl64_fs_run_mv "$source" "$transition" >/dev/null &&
    bl64_fs_run_mv "${transition}" "$destination" >/dev/null
  status=$?

  [[ -d "$repo" ]] && bl64_fs_path_remove "$repo" >/dev/null
  return "$status"
}

#######################################
# Download file asset from release in github repository
#
# Arguments:
#   $1: repo owner
#   $2: repo name
#   $3: release tag. Use $BL64_VCS_GITHUB_LATEST (latest) to obtain latest version
#   $4: asset name: file name available in the target release
#   $5: destination
#   $6: replace existing content Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $7: permissions. Regular chown format accepted. Default: umask defined
# Outputs:
#   STDOUT: none
#   STDERR: task error
# Returns:
#   0: success
#   >0: error
#######################################
function bl64_rxtx_github_get_asset() {
  bl64_dbg_lib_show_function "$@"
  local repo_owner="$1"
  local repo_name="$2"
  local release_tag="$3"
  local asset_name="$4"
  local destination="$5"
  local replace="${6:-${BL64_VAR_OFF}}"
  local mode="${7:-${BL64_VAR_DEFAULT}}"

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'repo_owner' &&
    bl64_check_parameter 'repo_name' &&
    bl64_check_parameter 'release_tag' &&
    bl64_check_parameter 'asset_name' &&
    bl64_check_parameter 'destination' ||
    return $?

  if [[ "$release_tag" == "$BL64_VCS_GITHUB_LATEST" ]]; then
    release_tag="$(bl64_vcs_github_release_get_latest "$repo_owner" "$repo_name")" ||
      return $?
  fi

  bl64_rxtx_web_get_file \
    "${BL64_RXTX_GITHUB_URL}/${repo_owner}/${repo_name}/releases/download/${release_tag}/${asset_name}" \
    "$destination" "$replace" "$mode"
}
