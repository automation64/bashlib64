#######################################
# BashLib64 / Module / Functions / Manage archive files
#######################################

#
# Deprecation aliases
#
# * Aliases to deprecated functions
# * Needed to maintain compatibility up to N-2 versions
#

function bl64_arc_open_tar() {
  bl64_msg_show_deprecated 'bl64_arc_open_tar' 'bl64_arc_tar_open'
  bl64_arc_tar_open "$@"
}

function bl64_arc_open_zip() {
  bl64_msg_show_deprecated 'bl64_arc_open_zip' 'bl64_arc_zip_open'
  bl64_arc_zip_open "$@"
}

#
# Private functions
#

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
function _bl64_arc_harden_unzip() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset UNZIP
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_arc_harden_zip() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset ZIP
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_arc_harden_gzip() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset GZIP
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_arc_harden_bzip2() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset BZIP
  unset BZIP2
  bl64_dbg_lib_trace_stop

  return 0
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
function _bl64_arc_harden_unxz() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_trace_start
  unset XZ_DEFAULTS
  unset XZ_OPT
  bl64_dbg_lib_trace_stop

  return 0
}

#
# Public functions
#

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_unzip() {
  bl64_dbg_lib_show_function "$@"
  local verbose='-qq'

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_UNZIP" || return $?

  bl64_msg_app_run_is_enabled && verbose=' '

  _bl64_arc_harden_unzip

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_UNZIP" \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_zip() {
  bl64_dbg_lib_show_function "$@"
  local verbose=' '

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_ZIP" || return $?

  bl64_msg_app_run_is_enabled && verbose='--verbose'

  _bl64_arc_harden_zip

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_ZIP" \
    $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_7zz() {
  bl64_dbg_lib_show_function "$@"
  local verbose='-bso0 -bd'

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_7ZZ" || return $?

  bl64_msg_app_run_is_enabled &&
    verbose='-bso1'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_7ZZ" \
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
function bl64_arc_run_tar() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_command "$BL64_ARC_CMD_TAR" ||
    return $?

  bl64_msg_app_run_is_enabled && verbose="$BL64_ARC_SET_TAR_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_TAR" \
    "$@" $verbose
  bl64_dbg_lib_trace_stop
}

#######################################
# Open tar files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_tar_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local -i status=0

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open tar archive ($source)"

  bl64_bsh_run_pushd "$destination" ||
    return $?

  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_arc_run_tar \
        --overwrite \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --force-local \
        --auto-compress \
        --file="$source"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      bl64_arc_run_tar \
        --overwrite \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --force-local \
        --auto-compress \
        --file="$source"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_arc_run_tar \
        --overwrite \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --force-local \
        --auto-compress \
        --file="$source"
      ;;
    ${BL64_OS_ALP}-*)
      bl64_arc_run_tar \
        x \
        --overwrite \
        -f "$source" \
        -o
      ;;
    ${BL64_OS_ARC}-*)
      bl64_arc_run_tar \
        --overwrite \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --force-local \
        --auto-compress \
        --file="$source"
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_arc_run_tar \
        --extract \
        --no-same-owner \
        --preserve-permissions \
        --no-acls \
        --file="$source"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
  status=$?

  if ((status == 0)); then
    bl64_fs_file_remove "$source"
    bl64_bsh_run_popd
  fi
  return "$status"
}

#######################################
# Open zip files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_zip_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local -i status=0

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open zip archive ($source)"
  # shellcheck disable=SC2086
  bl64_arc_run_unzip \
    $BL64_ARC_SET_UNZIP_OVERWRITE \
    -d "$destination" \
    "$source"
  status=$?

  ((status == 0)) && bl64_fs_file_remove "$source"

  return "$status"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_unxz() {
  bl64_dbg_lib_show_function "$@"
  local verbose=' '

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_UNXZ" || return $?

  bl64_msg_app_run_is_enabled && verbose='-v'

  _bl64_arc_harden_unxz

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_UNXZ" \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_bunzip2() {
  bl64_dbg_lib_show_function "$@"
  local verbose='--quiet'

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_BUNZIP2" || return $?

  bl64_msg_app_detail_is_enabled && verbose='--verbose'

  _bl64_arc_harden_bzip2

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_BUNZIP2" \
    $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore env args
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
function bl64_arc_run_gunzip() {
  bl64_dbg_lib_show_function "$@"
  local verbose='--quiet'

  bl64_check_module 'BL64_ARC_MODULE' &&
    bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_GUNZIP" || return $?

  bl64_msg_app_run_is_enabled && verbose='--verbose'

  _bl64_arc_harden_gzip

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_GUNZIP" \
    $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Open gzip files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_gzip_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open gzip archive ($source)"
  # shellcheck disable=SC2086
  cd "$destination" &&
    bl64_arc_run_gunzip \
      --decompress \
      "$source"
}

#######################################
# Open 7z files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_7z_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open 7z archive ($source)"
  # shellcheck disable=SC2086
  bl64_arc_run_7zz \
    -aoa \
    -y \
    "-o${destination}" \
    x \
    "$source"
}

#######################################
# Open bzip2 files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_bzip2_open() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_file "$source" &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_subtask "open bzip2 archive ($source)"
  # shellcheck disable=SC2086
  cd "$destination" &&
    bl64_arc_run_bunzip2 \
      --decompress \
      --force \
      "$source"
}
