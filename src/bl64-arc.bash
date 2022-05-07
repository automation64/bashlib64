#######################################
# BashLib64 / Module / Functions / Manage archive files
#
# Version: 1.6.0
#######################################

#######################################
# Tar wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_arc_run_tar() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_command "$BL64_ARC_CMD_TAR" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_ARC_SET_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_TAR" \
    $verbose \
    "$@"
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
function bl64_arc_open_tar() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local -i status=0

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_directory "$destination" ||
    return $?

  cd "$destination" || return 1

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
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
  ${BL64_OS_MCOS}-*)
    bl64_arc_run_tar \
      --extract \
      --no-same-owner \
      --preserve-permissions \
      --no-acls \
      --auto-compress \
      --file="$source"
    ;;
  *) bl64_check_show_unsupported ;;
  esac
  status=$?

  ((status == 0)) && bl64_fs_rm_file "$source"

  return $status
}
