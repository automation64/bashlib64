#######################################
# BashLib64 / Manage archive files
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.3.0
#######################################

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
#   BL64_ARC_ERROR_MISSING_PARAMETER
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_open_tar() {
  local source="$1"
  local destination="$2"
  local status=0

  if [[ -z "$source" || -z "$destination" ]]; then
    bl64_msg_show_error "$_BL64_ARC_TXT_MISSING_PARAMETER (source,destination)"
    # shellcheck disable=SC2086
    return $BL64_ARC_ERROR_MISSING_PARAMETER
  fi

  if [[ ! -d "$destination" ]]; then
    bl64_msg_show_error "$_BL64_ARC_TXT_DST_NOT_DIRECTORY ($destination)"
    # shellcheck disable=SC2086
    return $BL64_ARC_ERROR_INVALID_DESTINATION
  fi

  cd "$destination" || return 1

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    "$BL64_OS_CMD_TAR" \
      --overwrite \
      --extract \
      --no-same-owner \
      --preserve-permissions \
      --no-acls \
      --force-local \
      --verbose \
      --auto-compress \
      --file="$source"
    status=$?
    ;;
  ${BL64_OS_ALP}-*)
    "$BL64_OS_CMD_TAR" \
      x \
      --overwrite \
      -f "$source" \
      -o \
      -v
    status=$?
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_OS_CMD_TAR" \
      --extract \
      --no-same-owner \
      --preserve-permissions \
      --no-acls \
      --verbose \
      --auto-compress \
      --file="$source"
    status=$?
    ;;
  esac

  ((status == 0)) && $BL64_OS_ALIAS_RM_FILE "$source"

  return $status
}
