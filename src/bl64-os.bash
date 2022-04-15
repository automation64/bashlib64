#######################################
# BashLib64 / OS / Identify OS attributes and provide command aliases
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.12.0
#######################################

function _bl64_os_match() {

  local os="$1"
  local item="$2"
  local version="${item##*-}"

  # Pattern: OOO-V.V
  if [[ "$item" == +([[:alpha:]])-+([[:digit:]]).+([[:digit:]]) ]]; then
    [[ "$BL64_OS_DISTRO" == "${os}-${version}" ]]
  # Pattern: OOO-V
  elif [[ "$item" == +([[:alpha:]])-+([[:digit:]]) ]]; then
    [[ "$BL64_OS_DISTRO" == ${os}-${version}.+([[:digit:]]) ]]
  # Pattern: OOO
  else
    [[ "$BL64_OS_DISTRO" == ${os}-+([[:digit:]]).+([[:digit:]]) ]]
  fi
}

function _bl64_os_get_distro_from_uname() {
  local os_type=''
  local os_version=''
  local cmd_sw_vers='/usr/bin/sw_vers'

  os_type="$(uname)"
  case "$os_type" in
  'Darwin')
    os_version="$("$cmd_sw_vers" -productVersion)"
    BL64_OS_DISTRO="DARWIN-${os_version}"
    ;;
  *) BL64_OS_DISTRO='UNKNOWN' ;;
  esac

  return 0
}

function _bl64_os_get_distro_from_os_release() {
  # shellcheck disable=SC1091
  source '/etc/os-release'
  if [[ -n "$ID" && -n "$VERSION_ID" ]]; then
    BL64_OS_DISTRO="${ID^^}-${VERSION_ID}"
  fi

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_ALM}-8*) : ;;
  ${BL64_OS_ALP}-3*) : ;;
  ${BL64_OS_CNT}-7* | ${BL64_OS_CNT}-8* | ${BL64_OS_CNT}-9*) : ;;
  ${BL64_OS_DEB}-9*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-9" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-9.0"
    ;;
  ${BL64_OS_DEB}-10*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-10" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-10.0"
    ;;
  ${BL64_OS_DEB}-11*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-11" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-11.0"
    ;;
  ${BL64_OS_FD}-33* | ${BL64_OS_FD}-34* | ${BL64_OS_FD}-35*) : ;;
  ${BL64_OS_OL}-7* | ${BL64_OS_OL}-8*) : ;;
  ${BL64_OS_RHEL}-8*) : ;;
  ${BL64_OS_UB}-20* | ${BL64_OS_UB}-21*) : ;;
  *) BL64_OS_DISTRO='UNKNOWN' ;;
  esac

  return 0
}

#######################################
# Check if the current OS matches the target list
#
# Arguments:
#   $@: list of normalized OS names. Formats: as defined by bl64_os_get_distro
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   BL64_OS_ERROR_NO_OS_MATCH
#   BL64_OS_ERROR_INVALID_OS_TAG
#######################################

function bl64_os_match() {
  local item=''

  bl64_dbg_lib_show_info "[OSList=${*}}] / [BL64_OS_DISTRO=${BL64_OS_DISTRO}]"
  # shellcheck disable=SC2086
  for item in "$@"; do
    case "$item" in
    'ALM' | ALM-*) _bl64_os_match "$BL64_OS_ALM" "$item" && return 0 ;;
    'ALP' | ALP-*) _bl64_os_match "$BL64_OS_ALP" "$item" && return 0 ;;
    'CNT' | CNT-*) _bl64_os_match "$BL64_OS_CNT" "$item" && return 0 ;;
    'DEB' | DEB-*) _bl64_os_match "$BL64_OS_DEB" "$item" && return 0 ;;
    'FD' | FD-*) _bl64_os_match "$BL64_OS_FD" "$item" && return 0 ;;
    'MCOS' | MCOS-*) _bl64_os_match "$BL64_OS_MCOS" "$item" && return 0 ;;
    'OL' | OL-*) _bl64_os_match "$BL64_OS_OL" "$item" && return 0 ;;
    'RHEL' | RHEL-*) _bl64_os_match "$BL64_OS_RHEL" "$item" && return 0 ;;
    'UB' | UB-*) _bl64_os_match "$BL64_OS_UB" "$item" && return 0 ;;
    *) return $BL64_OS_ERROR_INVALID_OS_TAG ;;
    esac
  done

  # shellcheck disable=SC2086
  return $BL64_OS_ERROR_NO_OS_MATCH
}

#######################################
# Identify and normalize Linux OS distribution name and version
#
# * Target format: OOO-V.V
#   * OOO: OS short name (tag)
#   * V.V: Version (Major, Minor)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
function bl64_os_get_distro() {
  if [[ -r '/etc/os-release' ]]; then
    _bl64_os_get_distro_from_os_release
  else
    _bl64_os_get_distro_from_uname
  fi

  # Do not use return as this function gets sourced
}

#######################################
# Identify and normalize common *nix OS commands
# Commands are exported as variables with full path
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
function bl64_os_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_OS_CMD_AWK='/usr/bin/awk'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_CHMOD='/bin/chmod'
    BL64_OS_CMD_CHOWN='/bin/chown'
    BL64_OS_CMD_CP='/bin/cp'
    BL64_OS_CMD_DATE="/bin/date"
    BL64_OS_CMD_FALSE="/bin/false"
    BL64_OS_CMD_GAWK='/usr/bin/gawk'
    BL64_OS_CMD_GREP='/bin/grep'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_ID='/usr/bin/id'
    BL64_OS_CMD_LN='/bin/ln'
    BL64_OS_CMD_LS='/bin/ls'
    BL64_OS_CMD_MKDIR='/bin/mkdir'
    BL64_OS_CMD_MKTEMP='/bin/mktemp'
    BL64_OS_CMD_MV='/bin/mv'
    BL64_OS_CMD_RM='/bin/rm'
    BL64_OS_CMD_TAR='/bin/tar'
    BL64_OS_CMD_TRUE="/bin/true"
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    BL64_OS_CMD_AWK='/usr/bin/awk'
    BL64_OS_CMD_CAT='/usr/bin/cat'
    BL64_OS_CMD_CHMOD='/usr/bin/chmod'
    BL64_OS_CMD_CHOWN='/usr/bin/chown'
    BL64_OS_CMD_CP='/usr/bin/cp'
    BL64_OS_CMD_DATE="/usr/bin/date"
    BL64_OS_CMD_FALSE="/usr/bin/false"
    BL64_OS_CMD_GAWK='/usr/bin/gawk'
    BL64_OS_CMD_GREP='/usr/bin/grep'
    BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
    BL64_OS_CMD_ID='/usr/bin/id'
    BL64_OS_CMD_LN='/bin/ln'
    BL64_OS_CMD_LS='/usr/bin/ls'
    BL64_OS_CMD_MKDIR='/usr/bin/mkdir'
    BL64_OS_CMD_MKTEMP='/usr/bin/mktemp'
    BL64_OS_CMD_MV='/usr/bin/mv'
    BL64_OS_CMD_RM='/usr/bin/rm'
    BL64_OS_CMD_TAR='/bin/tar'
    BL64_OS_CMD_TRUE="/usr/bin/true"
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_OS_CMD_AWK='/usr/bin/awk'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_CHMOD='/bin/chmod'
    BL64_OS_CMD_CHOWN='/bin/chown'
    BL64_OS_CMD_CP='/bin/cp'
    BL64_OS_CMD_DATE="/bin/date"
    BL64_OS_CMD_FALSE="/bin/false"
    BL64_OS_CMD_GAWK='/usr/bin/gawk'
    BL64_OS_CMD_GREP='/bin/grep'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_ID='/usr/bin/id'
    BL64_OS_CMD_LN='/bin/ln'
    BL64_OS_CMD_LS='/bin/ls'
    BL64_OS_CMD_MKDIR='/bin/mkdir'
    BL64_OS_CMD_MKTEMP='/bin/mktemp'
    BL64_OS_CMD_MV='/bin/mv'
    BL64_OS_CMD_RM='/bin/rm'
    BL64_OS_CMD_TAR='/bin/tar'
    BL64_OS_CMD_TRUE="/bin/true"
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_OS_CMD_AWK='/usr/bin/awk'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_CHMOD='/bin/chmod'
    BL64_OS_CMD_CHOWN='/usr/sbin/chown'
    BL64_OS_CMD_CP='/bin/cp'
    BL64_OS_CMD_DATE="/bin/date"
    BL64_OS_CMD_FALSE="/usr/bin/false"
    BL64_OS_CMD_GAWK='/usr/bin/gawk'
    BL64_OS_CMD_GREP='/usr/bin/grep'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_ID='/usr/bin/id'
    BL64_OS_CMD_LN='/bin/ln'
    BL64_OS_CMD_LS='/bin/ls'
    BL64_OS_CMD_MKDIR='/bin/mkdir'
    BL64_OS_CMD_MKTEMP='/usr/bin/mktemp'
    BL64_OS_CMD_MV='/bin/mv'
    BL64_OS_CMD_RM='/bin/rm'
    BL64_OS_CMD_TAR='/usr/bin/tar'
    BL64_OS_CMD_TRUE="/usr/bin/true"
    BL64_OS_CMD_UNAME='/usr/bin/uname'
    ;;
  esac

  # Do not use return as this function gets sourced
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2034
function bl64_os_set_alias() {
  local cmd_mawk='/usr/bin/mawk'

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    BL64_OS_SET_MKDIR_VERBOSE='--verbose'
    BL64_OS_SET_CHOWN_VERBOSE='--verbose'
    BL64_OS_SET_CHOWN_RECURSIVE='--recursive'
    BL64_OS_SET_CP_VERBOSE='--verbose'
    BL64_OS_SET_CP_RECURSIVE='--recursive'
    BL64_OS_SET_CP_FORCE='--force'
    BL64_OS_SET_CHMOD_VERBOSE='--verbose'
    BL64_OS_SET_CHMOD_RECURSIVE='--recursive'

    if [[ -x "$cmd_mawk" ]]; then
      BL64_OS_ALIAS_AWK="$cmd_mawk"
    else
      BL64_OS_ALIAS_AWK="$BL64_OS_CMD_GAWK --traditional"
    fi
    BL64_OS_ALIAS_ID_USER="${BL64_OS_CMD_ID} -u -n"
    BL64_OS_ALIAS_LN_SYMBOLIC="${BL64_OS_CMD_LN} --verbose --symbolic"
    BL64_OS_ALIAS_LS_FILES="${BL64_OS_CMD_LS} --color=never"
    BL64_OS_ALIAS_MKDIR_FULL="${BL64_OS_CMD_MKDIR} ${BL64_OS_SET_MKDIR_VERBOSE} --parents"
    BL64_OS_ALIAS_MKTEMP_DIR="${BL64_OS_CMD_MKTEMP} -d"
    BL64_OS_ALIAS_MKTEMP_FILE="${BL64_OS_CMD_MKTEMP}"
    BL64_OS_ALIAS_MV="${BL64_OS_CMD_MV} --force --verbose"
    BL64_OS_ALIAS_RM_FILE="${BL64_OS_CMD_RM} --verbose --force --one-file-system"
    BL64_OS_ALIAS_RM_FULL="${BL64_OS_CMD_RM} --verbose --force --one-file-system --recursive"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_OS_SET_MKDIR_VERBOSE=' '
    BL64_OS_SET_CHOWN_VERBOSE='-v'
    BL64_OS_SET_CHOWN_RECURSIVE='-R'
    BL64_OS_SET_CP_VERBOSE='-v'
    BL64_OS_SET_CP_RECURSIVE='-R'
    BL64_OS_SET_CP_FORCE='-f'
    BL64_OS_SET_CHMOD_VERBOSE='-v'
    BL64_OS_SET_CHMOD_RECURSIVE='-R'

    BL64_OS_ALIAS_AWK="$BL64_OS_CMD_GAWK --traditional"
    BL64_OS_ALIAS_ID_USER="${BL64_OS_CMD_ID} -u -n"
    BL64_OS_ALIAS_LN_SYMBOLIC="${BL64_OS_CMD_LN} -v -s"
    BL64_OS_ALIAS_LS_FILES="${BL64_OS_CMD_LS} --color=never"
    BL64_OS_ALIAS_MKDIR_FULL="${BL64_OS_CMD_MKDIR} -p"
    BL64_OS_ALIAS_MKTEMP_DIR="${BL64_OS_CMD_MKTEMP} -d"
    BL64_OS_ALIAS_MKTEMP_FILE="${BL64_OS_CMD_MKTEMP}"
    BL64_OS_ALIAS_MV="${BL64_OS_CMD_MV} -f"
    BL64_OS_ALIAS_RM_FILE="${BL64_OS_CMD_RM} -f"
    BL64_OS_ALIAS_RM_FULL="${BL64_OS_CMD_RM} -f -R"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_OS_SET_MKDIR_VERBOSE='-v'
    BL64_OS_SET_CHOWN_VERBOSE='-v'
    BL64_OS_SET_CHOWN_RECURSIVE='-R'
    BL64_OS_SET_CP_VERBOSE='-v'
    BL64_OS_SET_CP_RECURSIVE='-R'
    BL64_OS_SET_CP_FORCE='-f'
    BL64_OS_SET_CHMOD_VERBOSE='-v'
    BL64_OS_SET_CHMOD_RECURSIVE='-R'

    BL64_OS_ALIAS_AWK="$BL64_OS_CMD_AWK"
    BL64_OS_ALIAS_ID_USER="${BL64_OS_CMD_ID} -u -n"
    BL64_OS_ALIAS_LN_SYMBOLIC="${BL64_OS_CMD_LN} -v -s"
    BL64_OS_ALIAS_LS_FILES="${BL64_OS_CMD_LS} --color=never"
    BL64_OS_ALIAS_MKDIR_FULL="${BL64_OS_CMD_MKDIR} ${BL64_OS_SET_MKDIR_VERBOSE} -p"
    BL64_OS_ALIAS_MKTEMP_DIR="${BL64_OS_CMD_MKTEMP} -d"
    BL64_OS_ALIAS_MKTEMP_FILE="${BL64_OS_CMD_MKTEMP}"
    BL64_OS_ALIAS_MV="${BL64_OS_CMD_MV} -v -f"
    BL64_OS_ALIAS_RM_FILE="${BL64_OS_CMD_RM} -v -f"
    BL64_OS_ALIAS_RM_FULL="${BL64_OS_CMD_RM} -v -f -R"
    ;;
  esac

  BL64_OS_ALIAS_CHOWN_DIR="${BL64_OS_CMD_CHOWN} ${BL64_OS_SET_CHOWN_VERBOSE} ${BL64_OS_SET_CHOWN_RECURSIVE}"
  BL64_OS_ALIAS_CP_DIR="${BL64_OS_CMD_CP} ${BL64_OS_SET_CP_VERBOSE} ${BL64_OS_SET_CP_FORCE} ${BL64_OS_SET_CP_RECURSIVE}"
  BL64_OS_ALIAS_CP_FILE="${BL64_OS_CMD_CP} ${BL64_OS_SET_CP_VERBOSE} ${BL64_OS_SET_CP_FORCE}"

  # Do not use return as this function gets sourced
}

#######################################
# Show current user name
#
# * Based on the BLD_OS_ALIAS_* variables and provided for cases where variables as command can not be used
#
# Arguments:
#   $@: arguments are passed as is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_os_id_user() {
  $BL64_OS_ALIAS_ID_USER "$@"
}
