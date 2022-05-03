#######################################
# BashLib64 / Interact with container engines
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.1.0
#######################################

#######################################
# Logins the container engine to a container registry
#
# Arguments:
#   $1: user
#   $2: password
#   $3: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_login() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local password="$2"
  local registry="$3"

  bl64_check_parameter 'user' &&
    bl64_check_parameter 'password' &&
    bl64_check_parameter 'registry' ||
    return $?

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_login "$user" "$password" "$registry"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_login "$user" "$password" "$registry"
  else
    bl64_msg_show_error "$_BL64_CNT_TXT_NO_CLI ($BL64_CNT_CMD_DOCKER. $BL64_CNT_CMD_PODMAN)"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  fi
}

#######################################
# Command wrapper: docker login
#
# Arguments:
#   $1: user
#   $2: password
#   $3: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_login() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local password="$2"
  local registry="$3"

  printf '%s\n' "$password" |
    bl64_cnt_run_docker \
      login \
      --username "$user" \
      --password-stdin \
      "$registry"
}

#######################################
# Command wrapper: podman login
#
# Arguments:
#   $1: user
#   $2: password
#   $3: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_login() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local password="$2"
  local registry="$3"

  printf '%s\n' "$password" |
    bl64_cnt_run_podman \
      login \
      --username "$user" \
      --password-stdin \
      "$registry"
}

#######################################

# Runs a container source using interactive settings
#
# * Allows signals
# * Attaches tty
#
# Arguments:
#   $@: arguments are passes as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_run_interactive "$@"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_run_interactive "$@"
  else
    bl64_msg_show_error "$_BL64_CNT_TXT_NO_CLI ($BL64_CNT_CMD_DOCKER. $BL64_CNT_CMD_PODMAN)"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  fi
}

#######################################
# Command wrapper: podman run
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_podman \
    run \
    --rm \
    --interactive \
    --tty \
    "$@"
}

#######################################
# Command wrapper: docker run
#
# * Provides verbose and debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_docker \
    run \
    --rm \
    --interactive \
    --tty \
    "$@"

}

#######################################
# Command wrapper: podman
#
# * Provides debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_run_podman() {
  bl64_dbg_lib_show_function "$@"
  local verbose='error'

  bl64_check_command "$BL64_CNT_CMD_PODMAN" || return $?
  bl64_dbg_lib_command_enabled && verbose="debug"
  bl64_dbg_runtime_show_paths

  "$BL64_CNT_CMD_PODMAN" \
    --log-level "$verbose" \
    "$@"
}

#######################################
# Command wrapper: docker
#
# * Provides debug support
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_run_docker() {
  bl64_dbg_lib_show_function "$@"
  local verbose='error'

  bl64_check_command "$BL64_CNT_CMD_DOCKER" || return $?
  bl64_dbg_lib_command_enabled && verbose="debug"
  bl64_dbg_runtime_show_paths

  "$BL64_CNT_CMD_DOCKER" \
    --log-level "$verbose" \
    "$@"
}

#######################################
# Builds a container source
#
# Arguments:
#   $1: build context. Format: full path
#   $2: dockerfile path. Format: relative to the build context
#   $3: tag to be applied to the resulting source. Format: docker tag
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_build() {
  bl64_dbg_lib_show_function "$@"
  local context="$1"
  local file="${2:-Dockerfile}"
  local tag="${3:-latest}"

  bl64_check_parameter 'context' &&
    bl64_check_directory "$context" &&
    bl64_check_file "${context}/${file}" ||
    return $?

  cd "${context}"

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_build "$file" "$tag"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_build "$file" "$tag"
  else
    bl64_msg_show_error "$_BL64_CNT_TXT_NO_CLI ($BL64_CNT_CMD_DOCKER. $BL64_CNT_CMD_PODMAN)"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  fi
}

#######################################
# Command wrapper: docker build
#
# Arguments:
#   $1: context
#   $2: file
#   $3: tag
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_build() {
  bl64_dbg_lib_show_function "$@"
  local file="$1"
  local tag="$2"

  bl64_cnt_run_docker \
    build \
    --no-cache \
    --rm \
    --tag "$tag" \
    --file "$file" \
    .
}

#######################################
# Command wrapper: podman build
#
# Arguments:
#   $1: context
#   $2: file
#   $3: tag
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_build() {
  bl64_dbg_lib_show_function "$@"
  local file="$1"
  local tag="$2"

  bl64_cnt_run_podman \
    build \
    --no-cache \
    --rm \
    --tag "$tag" \
    --file "$file" \
    .
}

#######################################
# Push a local source to the target container registry
#
# * Image is already present in the local destination
#
# Arguments:
#   $1: source. Format: IMAGE:TAG
#   $2: destination. Format: REPOSITORY/IMAGE:TAG
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' ||
    return $?

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_push "$source" "$destination"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_push "$source" "$destination"
  else
    bl64_msg_show_error "$_BL64_CNT_TXT_NO_CLI ($BL64_CNT_CMD_DOCKER. $BL64_CNT_CMD_PODMAN)"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  fi
}

#######################################
# Command wrapper: docker push
#
# Arguments:
#   $1: source
#   $2: destination
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_cnt_run_docker \
    push \
    "${destination}"
}

#######################################
# Command wrapper: podman push
#
# Arguments:
#   $1: source
#   $2: destination
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_push() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_cnt_run_podman \
    push \
    "localhost/${source}" \
    "${destination}"
}

#######################################
# Pull a remote container image to the local registry
#
# Arguments:
#   $1: source. Format: [REPOSITORY/]IMAGE:TAG
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_check_parameter 'source' ||
    return $?

  if [[ -x "$BL64_CNT_CMD_DOCKER" ]]; then
    bl64_cnt_docker_pull "$source"
  elif [[ -x "$BL64_CNT_CMD_PODMAN" ]]; then
    bl64_cnt_podman_pull "$source"
  else
    bl64_msg_show_error "$_BL64_CNT_TXT_NO_CLI ($BL64_CNT_CMD_DOCKER. $BL64_CNT_CMD_PODMAN)"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  fi
}

#######################################
# Command wrapper: docker pull
#
# Arguments:
#   $1: source
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_cnt_run_docker \
    pull \
    "${source}"
}

#######################################
# Command wrapper: podman pull
#
# Arguments:
#   $1: source
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_pull() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_cnt_run_podman \
    pull \
    "${source}"
}
