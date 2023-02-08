#######################################
# BashLib64 / Module / Functions / Manage Version Control System
#
# Version: 1.10.0
#######################################

#######################################
# GIT CLI wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_vcs_run_git() {
  bl64_dbg_lib_show_function "$@"
  local debug="$BL64_VCS_SET_GIT_QUIET"

  bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_VCS_CMD_GIT" || return $?

  bl64_vcs_blank_git

  bl64_dbg_lib_show_info "current path: $(pwd)"
  if bl64_dbg_lib_command_enabled; then
    debug=''
    export GIT_TRACE='2'
  else
    export GIT_TRACE='0'
  fi

  export GIT_CONFIG_NOSYSTEM='0'
  export GIT_AUTHOR_EMAIL='nouser@nodomain'
  export GIT_AUTHOR_NAME='bl64_vcs_run_git'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_VCS_CMD_GIT" \
    $debug \
    $BL64_VCS_SET_GIT_NO_PAGER \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_vcs_blank_git() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited GIT_* shell variables'
  bl64_dbg_lib_trace_start
  unset GIT_TRACE
  unset GIT_CONFIG_NOSYSTEM
  unset GIT_AUTHOR_EMAIL
  unset GIT_AUTHOR_NAME
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Clone GIT branch
#
# * File ownership is set to the current user
# * Destination is created if not existing
# * Single branch
# * Depth = 1
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: destination path where the repository will be created
#   $3: branch name. Default: main
# Outputs:
#   STDOUT: git output
#   STDERR: git stderr
# Returns:
#   n: git exit status
#######################################
function bl64_vcs_git_clone() {
  bl64_dbg_lib_show_function "$@"
  local source="${1}"
  local destination="${2}"
  local branch="${3:-main}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_command "$BL64_VCS_CMD_GIT" ||
    return $?

  bl64_fs_create_dir "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "$destination" || return $?

  bl64_msg_show_lib_task "$_BL64_VCS_TXT_CLONE_REPO ($source)"

  # shellcheck disable=SC2164
  cd "$destination"

  # shellcheck disable=SC2086
  bl64_vcs_run_git \
    clone \
    --depth 1 \
    --single-branch \
    --branch "$branch" \
    "$source"
}

#######################################
# Clone partial GIT repository (sparse checkout)
#
# * File ownership is set to the current user
# * Destination is created if not existing
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: destination path where the repository will be created
#   $3: branch name. Default: main
#   $4: include pattern list. Field separator: space
# Outputs:
#   STDOUT: git output
#   STDERR: git stderr
# Returns:
#   n: git exit status
#######################################
function bl64_vcs_git_sparse() {
  bl64_dbg_lib_show_function "$@"
  local source="${1}"
  local destination="${2}"
  local branch="${3:-main}"
  local pattern="${4}"
  local item=''
  local -i status=0

  bl64_check_command "$BL64_VCS_CMD_GIT" &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_parameter 'pattern' || return $?

  bl64_fs_create_dir "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "$destination" || returnn $?

  # shellcheck disable=SC2164
  cd "$destination"

  if bl64_os_match 'DEB-9' 'DEB-10' 'UB-20' 'OL-7' 'CNT-7'; then
    # shellcheck disable=SC2086
    bl64_vcs_run_git init &&
      bl64_vcs_run_git remote add origin "$source" &&
      bl64_vcs_run_git config core.sparseCheckout true &&
      {
        IFS=' '
        for item in $pattern; do echo "$item" >>'.git/info/sparse-checkout'; done
        unset IFS
      } &&
      bl64_vcs_run_git pull --depth 1 origin "$branch"
  else
    # shellcheck disable=SC2086
    bl64_vcs_run_git init &&
      bl64_vcs_run_git sparse-checkout set &&
      {
        IFS=' '
        for item in $pattern; do echo "$item"; done | bl64_vcs_run_git sparse-checkout add --stdin
      } &&
      bl64_vcs_run_git remote add origin "$source" &&
      bl64_vcs_run_git pull --depth 1 origin "$branch"
  fi
  status=$?

  return $status
}
