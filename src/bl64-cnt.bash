#######################################
# BashLib64 / Module / Functions / Interact with container engines
#
# Version: 1.8.2
#######################################

#######################################
# Check if the current process is running inside a container
#
# * detection is best effort and not guaranteed to cover all possible implementations
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   check status
#######################################
function bl64_cnt_is_inside_container() {
  bl64_dbg_lib_show_function

  _bl64_cnt_find_file_marker '/run/.containerenv' && return 0
  _bl64_cnt_find_file_marker '/run/container_id' && return 0
  _bl64_cnt_find_variable_marker 'container' && return 0
  _bl64_cnt_find_variable_marker 'DOCKER_CONTAINER' && return 0
  _bl64_cnt_find_variable_marker 'KUBERNETES_SERVICE_HOST' && return 0

  return 1
}

function _bl64_cnt_find_file_marker() {
  bl64_dbg_lib_show_function "$@"
  local marker="$1"
  bl64_dbg_lib_show_info "check for file marker (${marker})"
  [[ -f "$marker" ]]
}

function _bl64_cnt_find_variable_marker() {
  bl64_dbg_lib_show_function "$@"
  local marker="$1"
  bl64_dbg_lib_show_info "check for variable marker (${marker})"

  eval "[[ -n \"\${${marker}}\" ]]"
}

#######################################
# Logins the container engine to a container registry. The password is stored in a regular file
#
# Arguments:
#   $1: user
#   $2: file
#   $3: registry
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_login_file() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local file="$2"
  local registry="$3"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'user' &&
    bl64_check_parameter 'file' &&
    bl64_check_parameter 'registry' &&
    bl64_check_file "$file" ||
    return $?

  "bl64_cnt_${BL64_CNT_DRIVER}_login" "$user" "$BL64_VAR_DEFAULT" "$file" "$registry"
}

#######################################
# Logins the container engine to a container. The password is passed as parameter
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

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'user' &&
    bl64_check_parameter 'password' &&
    bl64_check_parameter 'registry' ||
    return $?

  "bl64_cnt_${BL64_CNT_DRIVER}_login" "$user" "$password" "$BL64_VAR_DEFAULT" "$registry"
}

#######################################
# Open a container image using sh
#
# * Ignores entrypointt
#
# Arguments:
#   $1: container
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_run_sh() {
  bl64_dbg_lib_show_function "$@"
  local container="$1"

  bl64_check_parameter 'container' || return $?

  bl64_cnt_run_interactive --entrypoint 'sh' "$container"
}

#######################################
# Runs a container image using interactive settings
#
# * Allows signals
# * Attaches tty
#
# Arguments:
#   $@: arguments are passed as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_run_interactive() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CNT_MODULE' ||
    return $?

  "bl64_cnt_${BL64_CNT_DRIVER}_run_interactive" "$@"
}

#######################################
# Builds a container source
#
# Arguments:
#   $1: ui context. Format: full path
#   $2: dockerfile path. Format: relative to the build context
#   $3: tag to be applied to the resulting source. Format: docker tag
#   $@: arguments are passed as-is to the command
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

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'context' &&
    bl64_check_directory "$context" &&
    bl64_check_file "${context}/${file}" ||
    return $?

  # Remove used parameters
  shift
  shift
  shift

  # shellcheck disable=SC2164
  cd "${context}"

  "bl64_cnt_${BL64_CNT_DRIVER}_build" "$file" "$tag" "$@"
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

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' ||
    return $?

  "bl64_cnt_${BL64_CNT_DRIVER}_push" "$source" "$destination"
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

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'source' ||
    return $?

  "bl64_cnt_${BL64_CNT_DRIVER}_pull" "$source"
}

function _bl64_cnt_login_put_password() {
  local password="$1"
  local file="$2"

  if [[ "$password" != "$BL64_VAR_DEFAULT" ]]; then
    printf '%s\n' "$password"
  elif [[ "$file" != "$BL64_VAR_DEFAULT" ]]; then
    "$BL64_OS_CMD_CAT" "$file"
  fi

}

#######################################
# Assigns a new name to an existing image
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' ||
    return $?

  "bl64_cnt_${BL64_CNT_DRIVER}_tag" "$source" "$target"
}

#######################################
# Runs a container image
#
# Arguments:
#   $@: arguments are passed as-is
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_cnt_run() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_CNT_MODULE' ||
    return $?

  "bl64_cnt_${BL64_CNT_DRIVER}_run" "$@"
}

#
# Docker
#

#######################################
# Command wrapper: docker login
#
# Arguments:
#   $1: user
#   $2: password
#   $3: file
#   $4: registry
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
  local file="$3"
  local registry="$4"

  _bl64_cnt_login_put_password "$password" "$file" |
    bl64_cnt_run_docker \
      login \
      --username "$user" \
      --password-stdin \
      "$registry"
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

  bl64_check_parameters_none "$#" || return $?

  bl64_cnt_run_docker \
    run \
    --rm \
    --interactive \
    --tty \
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
  local debug=' '

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_command "$BL64_CNT_CMD_DOCKER" ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose='debug'
    debug='--debug'
  fi
  bl64_dbg_runtime_show_paths

  bl64_dbg_lib_trace_start
  "$BL64_CNT_CMD_DOCKER" \
    --log-level "$verbose" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper: docker build
#
# Arguments:
#   $1: file
#   $2: tag
#   $@: arguments are passed as-is to the command
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

  # Remove used parameters
  shift
  shift

  bl64_cnt_run_docker \
    build \
    --no-cache \
    --rm \
    --tag "$tag" \
    --file "$file" \
    "$@" .
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
    tag \
    "$source" \
    "$destination"

  bl64_cnt_run_docker \
    push \
    "$destination"
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
# Command wrapper: docker tag
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_docker_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_cnt_run_docker \
    tag \
    "$source" \
    "$target"
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

function bl64_cnt_docker_run() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_docker \
    run \
    --rm \
    "$@"

}

#
# Podman
#

#######################################
# Command wrapper: podman login
#
# Arguments:
#   $1: user
#   $2: password
#   $3: file
#   $4: registry
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
  local file="$3"
  local registry="$4"

  _bl64_cnt_login_put_password "$password" "$file" |
    bl64_cnt_run_podman \
      login \
      --username "$user" \
      --password-stdin \
      "$registry"
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

  bl64_check_parameters_none "$#" || return $?

  bl64_cnt_run_podman \
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

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_CNT_MODULE' &&
    bl64_check_command "$BL64_CNT_CMD_PODMAN" ||
    return $?

  bl64_dbg_lib_command_enabled && verbose='debug'
  bl64_dbg_runtime_show_paths

  bl64_dbg_lib_trace_start
  "$BL64_CNT_CMD_PODMAN" \
    --log-level "$verbose" \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper: podman build
#
# Arguments:
#   $1: file
#   $2: tag
#   $@: arguments are passed as-is to the command
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

  # Remove used parameters
  shift
  shift

  bl64_cnt_run_podman \
    build \
    --no-cache \
    --rm \
    --tag "$tag" \
    --file "$file" \
    "$@" .
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
    "$destination"
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

#######################################
# Command wrapper: podman tag
#
# Arguments:
#   $1: source. Format: image[:tag]
#   $2: target. Format: image[:tag]
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################

function bl64_cnt_podman_tag() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local target="$2"

  bl64_cnt_run_podman \
    tag \
    "$source" \
    "$target"
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

function bl64_cnt_podman_run() {
  bl64_dbg_lib_show_function "$@"

  bl64_cnt_run_podman \
    run \
    --rm \
    "$@"
}
