#######################################
# BashLib64 / OS / Identify OS attributes and provide command aliases
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.8.0
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

  # shellcheck disable=SC2086
  for item in "$@"; do
    case "$item" in
    'ALM' | ALM-*) _bl64_os_match "$BL64_OS_ALM" "$item" && return ;;
    'ALP' | ALP-*) _bl64_os_match "$BL64_OS_ALP" "$item" && return ;;
    'CNT' | CNT-*) _bl64_os_match "$BL64_OS_CNT" "$item" && return ;;
    'DEB' | DEB-*) _bl64_os_match "$BL64_OS_DEB" "$item" && return ;;
    'FD' | FD-*) _bl64_os_match "$BL64_OS_FD" "$item" && return ;;
    'OL' | OL-*) _bl64_os_match "$BL64_OS_OL" "$item" && return ;;
    'RHEL' | RHEL-*) _bl64_os_match "$BL64_OS_RHEL" "$item" && return ;;
    'UB' | UB-*) _bl64_os_match "$BL64_OS_UB" "$item" && return ;;
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
# * OS tags:
#   * ALM   -> AlmaLinux
#   * ALP   -> Alpine Linux
#   * AMZ   -> Amazon Linux
#   * CNT   -> CentOS
#   * DEB   -> Debian
#   * FD    -> Fedora
#   * OL    -> OracleLinux
#   * RHEL  -> RedHat Enterprise Linux
#   * UB    -> Ubuntu
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: ok
#   BL64_OS_ERROR_UNKNOWN_OS: os not supported
#######################################
function bl64_os_get_distro() {

  if [[ -r '/etc/os-release' ]]; then
    # shellcheck disable=SC1091
    source '/etc/os-release'
    if [[ -n "$ID" && -n "$VERSION_ID" ]]; then
      BL64_OS_DISTRO="${ID^^}-${VERSION_ID}"
    fi
  fi

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_ALM}-8*) : ;;
  ${BL64_OS_ALP}-3*) : ;;
  ${BL64_OS_CNT}-8*) : ;;
  ${BL64_OS_DEB}-10*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-10" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-10.0"
    ;;
  ${BL64_OS_DEB}-11*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-11" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-11.0"
    ;;
  ${BL64_OS_FD}-33* | ${BL64_OS_FD}-35*) : ;;
  ${BL64_OS_OL}-8*) : ;;
  ${BL64_OS_RHEL}-8*) : ;;
  ${BL64_OS_UB}-20* | ${BL64_OS_UB}-21*) : ;;
  *)
    BL64_OS_DISTRO='UNKNOWN'
    # shellcheck disable=SC2086
    return $BL64_OS_ERROR_UNKNOWN_OS
    ;;
  esac
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
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    BL64_OS_CMD_AWK='/usr/bin/awk'
    BL64_OS_CMD_CAT='/usr/bin/cat'
    BL64_OS_CMD_CHMOD='/usr/bin/chmod'
    BL64_OS_CMD_CHOWN='/usr/bin/chown'
    BL64_OS_CMD_CP='/usr/bin/cp'
    BL64_OS_CMD_DATE="/usr/bin/date"
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
    ;;
  ${BL64_OS_ALP}-*)
    BL64_OS_CMD_AWK='/usr/bin/awk'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_CHMOD='/bin/chmod'
    BL64_OS_CMD_CHOWN='/bin/chown'
    BL64_OS_CMD_CP='/bin/cp'
    BL64_OS_CMD_DATE="/bin/date"
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
    ;;
  esac
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
function bl64_os_set_alias() {
  local cmd_mawk='/usr/bin/mawk'

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    if [[ -x "$cmd_mawk" ]]; then
      BL64_OS_ALIAS_AWK="$cmd_mawk"
    else
      BL64_OS_ALIAS_AWK="$BL64_OS_CMD_GAWK --traditional"
    fi
    BL64_OS_ALIAS_CHOWN_DIR="$BL64_OS_CMD_CHOWN --verbose --recursive"
    BL64_OS_ALIAS_CP_DIR="$BL64_OS_CMD_CP --verbose --force --recursive"
    BL64_OS_ALIAS_CP_FILE="$BL64_OS_CMD_CP --verbose --force"
    BL64_OS_ALIAS_ID_USER="$BL64_OS_CMD_ID -u -n"
    BL64_OS_ALIAS_LN_SYMBOLIC="$BL64_OS_CMD_LN --verbose --symbolic"
    BL64_OS_ALIAS_LS_FILES="$BL64_OS_CMD_LS --color=never"
    BL64_OS_ALIAS_MKDIR_FULL="$BL64_OS_CMD_MKDIR --parents --verbose"
    BL64_OS_ALIAS_MKTEMP_DIR="$BL64_OS_CMD_MKTEMP -d"
    BL64_OS_ALIAS_MKTEMP_FILE="$BL64_OS_CMD_MKTEMP"
    BL64_OS_ALIAS_MV="$BL64_OS_CMD_MV --force --verbose"
    BL64_OS_ALIAS_RM_FILE="$BL64_OS_CMD_RM --verbose --force --one-file-system"
    BL64_OS_ALIAS_RM_FULL="$BL64_OS_CMD_RM --verbose --force --one-file-system --recursive"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_OS_ALIAS_AWK="$BL64_OS_CMD_GAWK --traditional"
    BL64_OS_ALIAS_CHOWN_DIR="$BL64_OS_CMD_CHOWN -v -R"
    BL64_OS_ALIAS_CP_DIR="$BL64_OS_CMD_CP -v -f -R"
    BL64_OS_ALIAS_CP_FILE="$BL64_OS_CMD_CP -v -f"
    BL64_OS_ALIAS_ID_USER="$BL64_OS_CMD_ID -u -n"
    BL64_OS_ALIAS_LN_SYMBOLIC="$BL64_OS_CMD_LN -v -s"
    BL64_OS_ALIAS_LS_FILES="$BL64_OS_CMD_LS --color=never"
    BL64_OS_ALIAS_MKDIR_FULL="$BL64_OS_CMD_MKDIR -p"
    BL64_OS_ALIAS_MKTEMP_DIR="$BL64_OS_CMD_MKTEMP -d"
    BL64_OS_ALIAS_MKTEMP_FILE="$BL64_OS_CMD_MKTEMP"
    BL64_OS_ALIAS_MV="$BL64_OS_CMD_MV -f"
    BL64_OS_ALIAS_RM_FILE="$BL64_OS_CMD_RM -f"
    BL64_OS_ALIAS_RM_FULL="$BL64_OS_CMD_RM -f -R"
    ;;
  esac
}

#######################################
# Change directory ownership with verbose and recursive flags
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
function bl64_os_chown_dir() {
  $BL64_OS_ALIAS_CHOWN_DIR "$@"
}

#######################################
# Copy files with verbose and force flags
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
function bl64_os_cp_file() {
  $BL64_OS_ALIAS_CP_FILE "$@"
}

#######################################
# Copy directory recursively with verbose and force flags
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
function bl64_os_cp_dir() {
  $BL64_OS_ALIAS_CP_DIR "$@"
}

#######################################
# Merge contents from source directory to target
#
# Arguments:
#   $1: source path
#   $2: target path
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   bl64_check_parameter
#   bl64_check_directory
#   command exit status
#######################################
function bl64_os_merge_dir() {
  local source="${1:-${BL64_LIB_VAR_TBD}}"
  local target="${2:-${BL64_LIB_VAR_TBD}}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' &&
    bl64_check_directory "$source" &&
    bl64_check_directory "$target" ||
    return 1

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    $BL64_OS_ALIAS_CP_DIR --no-target-directory "$source" "$target"
    ;;
  ${BL64_OS_ALP}-*)
    $BL64_OS_ALIAS_CP_DIR "$source" -t "$target"
    ;;
  esac

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

#######################################
# Create a symbolic link with verbose flag
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
function bl64_os_ln_symbolic() {
  $BL64_OS_ALIAS_LN_SYMBOLIC "$@"
}

#######################################
# List files with nocolor flag
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
function bl64_os_ls_files() {
  $BL64_OS_ALIAS_LS_FILES "$@"
}

#######################################
# Create full path including parents. Uses verbose flag
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
function bl64_os_mkdir_full() {
  $BL64_OS_ALIAS_MKDIR_FULL "$@"
}

#######################################
# Move files using the verbose and force flags
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
function bl64_os_mv() {
  $BL64_OS_ALIAS_MV "$@"
}

#######################################
# Remove files using the verbose and force flags. Limited to current filesystem
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
function bl64_os_rm_file() {
  $BL64_OS_ALIAS_RM_FILE "$@"
}

#######################################
# Remove directories using the verbose and force flags. Limited to current filesystem
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
function bl64_os_rm_full() {
  $BL64_OS_ALIAS_RM_FULL "$@"
}

#######################################
# Remove content from OS temporary repositories
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_os_cleanup_tmps() {
  $BL64_OS_ALIAS_RM_FULL -- /tmp/[[:alnum:]]*
  $BL64_OS_ALIAS_RM_FULL -- /var/tmp/[[:alnum:]]*
  return 0
}

#######################################
# Remove or reset logs from standard locations
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_os_cleanup_logs() {
  local target='/var/log'

  if [[ -d "$target" ]]; then
    $BL64_OS_ALIAS_RM_FULL ${target}/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Remove or reset OS caches from standard locations
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_os_cleanup_caches() {
  local target='/var/cache/man'

  if [[ -d "$target" ]]; then
    $BL64_OS_ALIAS_RM_FULL ${target}/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Performs a complete cleanup of the OS temporary content
#
# * Removes temporary files
# * Cleans caches
# * Removes logs
#
# Arguments:
#   None
# Outputs:
#   STDOUT: output from clean functions
#   STDERR: output from clean functions
# Returns:
#   0: always ok
#######################################
function bl64_os_cleanup_full() {
  bl64_pkg_cleanup
  bl64_os_cleanup_tmps
  bl64_os_cleanup_logs
  bl64_os_cleanup_caches

  return 0
}
