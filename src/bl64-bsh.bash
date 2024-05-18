#######################################
# BashLib64 / Module / Functions / Interact with Bash shell
#######################################

# DEPRECATED: to be removed in future releases
function bl64_bsh_script_set_id() { bl64_lib_script_set_id "$@"; }
# DEPRECATED: to be removed in future releases
function bl64_bsh_script_set_identity() { bl64_lib_script_set_identity "$@"; }

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
  bl64_msg_show_subtask "${_BL64_BSH_TXT_IMPORT_YAML} (${source})"
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
#   $2: env files store directory name. Default: BL64_BSH_ENV_STORE
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
  local store="${2:-$BL64_BSH_ENV_STORE}"

  bl64_fs_create_dir "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "${home}/${store}"
}

#######################################
# Generate env file loader snippet
#
# * Use to generate bash snippet that can be added to user's profile
#
# Arguments:
#   $1: env files store directory name. Default: BL64_BSH_ENV_STORE
# Outputs:
#   STDOUT: snippet
#   STDERR: none
# Returns:
#   0: task executed ok
#   >0: failed to execute task
#######################################
function bl64_bsh_env_store_generate() {
  bl64_dbg_lib_show_function "$@"
  local store="${1:-$BL64_BSH_ENV_STORE}"

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
' "$store" "$store"
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
# Arguments:
#   $1: insecure setting?: ON: user paths first. OFF: user paths last. Default: OFF
#   $2: include system paths?. Default: OFF
#   $3: extra paths
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
  local paths_base='/bin:/usr/bin:/usr/local/bin'
  local paths_system='/sbin:/usr/sbin:/usr/local/sbin'
  local paths_user='$HOME/bin:$HOME/.local/bin'

  bl64_lib_flag_is_enabled "$system" &&
    paths_base+=":${paths_system}"

  if bl64_lib_flag_is_enabled "$insecure"; then
    echo "${paths_extra}${paths_extra:+:}${paths_user}:${paths_base}"
  else
    echo "${paths_base}:${paths_user}${paths_extra:+:}${paths_extra}"
  fi
}
