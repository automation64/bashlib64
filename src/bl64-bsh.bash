#######################################
# BashLib64 / Module / Functions / Interact with Bash shell
#######################################

# DEPRECATED: to be removed in future releases
function bl64_bsh_script_set_id() {
  bl64_msg_show_deprecated 'bl64_bsh_script_set_id' 'bl64_lib_script_set_id'
  bl64_lib_script_set_id "$@"
}
function bl64_bsh_script_set_identity() {
  bl64_msg_show_deprecated 'bl64_bsh_script_set_identity' 'bl64_lib_script_set_identity'
  bl64_lib_script_set_identity "$@"
}

#######################################
# Get current script location
#
# Arguments:
#   None
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: full path
#   >0: command error
#######################################
function bl64_bsh_script_get_path() {
  bl64_dbg_lib_show_function
  local -i main=${#BASH_SOURCE[*]}
  local caller=''

  ((main > 0)) && main=$((main - 1))
  caller="${BASH_SOURCE[${main}]}"

  unset CDPATH &&
    [[ -n "$caller" ]] &&
    cd -- "${caller%/*}" >/dev/null &&
    pwd -P ||
    return $?
}

#######################################
# Get current script name
#
# Arguments:
#   None
# Outputs:
#   STDOUT: script name
#   STDERR: Error messages
# Returns:
#   0: name
#   >0: command error
#######################################
function bl64_bsh_script_get_name() {
  bl64_dbg_lib_show_function
  local -i main=${#BASH_SOURCE[*]}

  ((main > 0)) && main=$((main - 1))

  bl64_fmt_basename "${BASH_SOURCE[${main}]}"
}

#######################################
# Generate a string that can be used to populate shell.env files
#
# * Export format is bash compatible
#
# Arguments:
#   $1: variable name
#   $2: value
# Outputs:
#   STDOUT: export string
#   STDERR: Error messages
# Returns:
#   0: string created
#   >0: creation error
#######################################
function bl64_bsh_env_export_variable() {
  bl64_dbg_lib_show_function "$@"
  local variable="${1:-${BL64_VAR_NULL}}"
  local value="${2:-}"

  bl64_check_parameter 'variable' ||
    return $?

  printf "export %s='%s'\n" "$variable" "$value"
}

#######################################
# Import shell environment variables from YAML file
#
# * Conversion is done using YQ and Awk
# * YAML nested variables are flatten and converted to single shell variables:
#   * first.second: value -> FIRST_SECOND="value"
#   * first.second[2]: value -> FIRST_SECOND_2="value"
# * Shell variable names are created using uppercase and exported
# * Resulting variables are saved to a temporary file which is then sourced into the current script
#
# Arguments:
#   $1: path to the YAML file
# Outputs:
#   STDOUT: none
#   STDERR: conversion errors
# Returns:
#   0: converted and lodaded ok
#   >0: failed to convert
#######################################
function bl64_bsh_env_import_yaml() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local dynamic_env=''

  bl64_check_parameter 'source' &&
    bl64_check_file "$source" ||
    return $?

  # shellcheck disable=SC1090
  bl64_msg_show_subtask "convert and import shell variables from YAML file (${source})"
  # shellcheck disable=SC1090
  dynamic_env="$(bl64_fs_create_tmpfile)" &&
    bl64_xsv_run_yq \
      -o p \
      '.' \
      "$source" |
    bl64_txt_run_awk \
      -F ' = ' '
  {
      gsub( "[.]", "_", $1 )
      print "export " toupper( $1 ) "='"'"'" $2 "'"'"'"
  }' >"$dynamic_env" &&
    source "$dynamic_env" ||
    return $?

  bl64_fs_rm_tmpfile "$dynamic_env"
  return 0
}

#######################################
# Determine the full path of a command
#
# * valid for command type only (type -p)
# * if the command is already a path, nothing else is done
#
# Arguments:
#   $1: command name with/without path
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: full path detected
#   >0: unable to detect or error
#######################################
function bl64_bsh_command_get_path() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-}"
  local full_path=''

  bl64_check_parameter 'command' ||
    return $?

  full_path="$(type -p "${command}")"
  if [[ -n "$full_path" ]]; then
    echo "$full_path"
    return 0
  fi
  return $BL64_LIB_ERROR_TASK_FAILED
}

#######################################
# Check if the command is executable
#
# * command is first converted to full path
#
# Arguments:
#   $1: command name with/without path
# Outputs:
#   STDOUT: none
#   STDERR: Error messages
# Returns:
#   0: command is executable
#   >0: command is not present or not executable
#######################################
function bl64_bsh_command_is_executable() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-}"
  local full_path=''

  bl64_check_parameter 'command' ||
    return $?

  full_path="$(bl64_bsh_command_get_path "${command}")" ||
    return $?
  [[ ! -e "$full_path" ]] &&
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  [[ ! -x "$full_path" ]] &&
    return $BL64_LIB_ERROR_FILE_NOT_EXECUTE
  [[ -x "$full_path" ]] ||
    return $BL64_LIB_ERROR_TASK_FAILED
}

#######################################
# Create env file store
#
# * Use to store .env files that can later be automatically loaded by the shell profile
#
# Arguments:
#   $1: User home path. Default: HOME
#   $2: permissions. Default: 0750
#   $3: user name. Default: current
#   $4: group name. Default: current
# Outputs:
#   STDOUT: progress
#   STDERR: Error messages
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_env_store_create() {
  bl64_dbg_lib_show_function "$@"
  local home="${1:-$HOME}"
  local mode="${2:-$BL64_VAR_DEFAULT}"
  local user="${3:-$BL64_VAR_DEFAULT}"
  local group="${4:-$BL64_VAR_DEFAULT}"
  local mode='0750'

  [[ "$mode" == "$BL64_VAR_DEFAULT" ]] && mode='0750'
  bl64_fs_create_dir "$mode" "$user" "$group" \
    "${home}/${BL64_BSH_ENV_STORE}"
}

#######################################
# Determines if the env store is present
#
# * Check that the store is presend only (directory path)
# * No check is done to detect if the shell properly configured to auto-load on login from the store
#
# Arguments:
#   $1: User home path. Default: HOME
# Outputs:
#   STDOUT: None
#   STDERR: Error messages
# Returns:
#   0: store is present
#   >0: store is not present or error
#######################################
function bl64_bsh_env_store_is_present() {
  bl64_dbg_lib_show_function
  local home="${1:-$HOME}"

  [[ -d "${home}/${BL64_BSH_ENV_STORE}" ]]
}

#######################################
# Publish existing .env files to the store
#
# * The source file is sym-linked to the store
# * The source file must have permissions for the user to use it
#
# Arguments:
#   $1: Full path to the source .env file
#   $2: Load priority. Default: 64
#   $3: User home path. Default: HOME
# Outputs:
#   STDOUT: progress
#   STDERR: Error messages
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_env_store_publish() {
  bl64_dbg_lib_show_function "$@"
  local source_env="${1:-}"
  local priority="${2:-64}"
  local home="${3:-$HOME}"
  local target=''

  bl64_check_parameter 'source_env' &&
    bl64_check_file "$source_env" &&
    bl64_check_directory "${home}/${BL64_BSH_ENV_STORE}" ||
    return $?

  target="${home}/${BL64_BSH_ENV_STORE}/${priority}_$(bl64_fmt_basename "$source_env")" &&
    bl64_fs_create_symlink \
      "$source_env" \
      "$target" \
      "$BL64_VAR_ON"
}

#######################################
# Generate env file loader snippet
#
# * Use to generate bash snippet that can be added to user's profile
#
# Arguments:
#   None
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_env_store_generate() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2016
  printf '
# Load .env files from user store
if [[ -d "${HOME}/%s" ]]; then
  _module=""
  for _module in "${HOME}/%s"/*.env; do
    [[ -r "$_module" ]] &&
      source "$_module"
  done
  unset _module
fi\n
' "$BL64_BSH_ENV_STORE" "$BL64_BSH_ENV_STORE"
}

#######################################
# Generate bash rc snippet
#
# * Generic bashrc content to allow modular content
# * System PATH setting only
#
# Arguments:
#   None
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_profile_rc_generate() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2016
  printf '
# Set initial system path
export PATH="/bin:/usr/bin"

# Load global RC
[[ -f '/etc/bashrc' ]] &&
  source '/etc/bashrc'

# Load user RC
if [[ -d "${HOME}/.bashrc.d" ]]; then
  _module=""
  for _module in "${HOME}/.bashrc.d"/*.sh; do
    [[ -r "$_module" ]] &&
      source "$_module"
  done
  unset _module
fi\n
'
}

#######################################
# Generate bash profile snippet
#
# * Generic bash_profile content to allow modular content
#
# Arguments:
#   None
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_profile_bash_generate() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2016
  printf '
# Import BashRC content
if [[ -f "${HOME}/.bashrc" ]]; then
  source "${HOME}/.bashrc"
fi\n
'
}

#######################################
# Generate bash PATH snippet
#
# * Includes common search paths for:
# *  XDG
# *  NPM
#
# Arguments:
#   $1: insecure setting?: ON: user paths first. OFF: user paths last. Default: OFF
#   $2: include system paths?. Default: OFF
#   $3: extra paths, separated by :
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_profile_path_generate() {
  bl64_dbg_lib_show_function "$@"
  local insecure="${1:-$BL64_VAR_OFF}"
  local system="${2:-$BL64_VAR_OFF}"
  local paths_extra="${3:-}"
  local paths_base=''
  local paths_system=''
  local paths_user=''

  paths_base+='/bin:'
  paths_base+='/usr/bin:'
  paths_base+='/usr/local/bin'

  paths_system+='/sbin:'
  paths_system+='/usr/sbin:'
  paths_system+='/usr/local/sbin'

  # shellcheck disable=SC2016
  paths_user+='$HOME/bin:'
  # shellcheck disable=SC2016
  paths_user+='$HOME/.local/bin:'
  # shellcheck disable=SC2016
  paths_user+='$HOME/node_modules/.bin'

  bl64_lib_flag_is_enabled "$system" &&
    paths_base+=":${paths_system}"

  if bl64_lib_flag_is_enabled "$insecure"; then
    printf '\nPATH="%s"\n' "${paths_extra}${paths_extra:+:}${paths_user}:${paths_base}"
  else
    printf '\nPATH="%s"\n' "${paths_base}:${paths_user}${paths_extra:+:}${paths_extra}"
  fi
}

#######################################
# Simplified command wrapper
#
# Arguments:
#   $1: target path
# Outputs:
#   STDOUT: None
#   STDERR: Command error
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_bsh_run_pushd() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  # shellcheck disable=SC2164
  pushd "$path" >/dev/null
}

#######################################
# Simplified command wrapper
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Command error
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_bsh_run_popd() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2164
  popd >/dev/null
}

#######################################
# Search for the command in well known locations
#
# Arguments:
#   $1: command name
#   $@: (optional) list of additional paths where to look on
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: full path detected
#   >0: unable to detect or error
#######################################
function bl64_bsh_command_locate() {
  bl64_dbg_lib_show_function "$@"
  local command="${1:-}"
  local search_list=''
  local full_path=''
  local current_path=''

  shift
  bl64_check_parameter 'command' ||
    return $?

  search_list+=' /home/linuxbrew/.linuxbrew/bin'
  search_list+=' /opt/homebrew/bin'
  search_list+=' /usr/local/bin'
  search_list+=' /usr/bin'
  search_list+=' /bin'
  search_list+=' /usr/sbin'
  search_list+=' /sbin'

  for current_path in $search_list "${@:-}"; do
    bl64_dbg_lib_show_info "search in: ${current_path}/${command}"
    [[ ! -d "$current_path" ]] && continue
    if [[ -x "${current_path}/${command}" ]]; then
      echo "${current_path}/${command}"
      return 0
    fi
  done
  bl64_check_alert_resource_not_found "$command"
}
