#######################################
# BashLib64 / OS / Identify OS attributes and provide command aliases
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.3.0
#######################################

#######################################
# Identify and normalize Linux OS distribution name and version
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: ok: always ok, even when unable to identify the platform
#######################################
function bl64_os_get_distro() {

  BL64_OS_DISTRO='UNKNOWN'

  if [[ -r '/etc/os-release' ]]; then

    # shellcheck disable=SC1091
    source '/etc/os-release'

    if [[ -n "$ID" && -n "$VERSION_ID" ]]; then
      BL64_OS_DISTRO="${ID^^}-${VERSION_ID}"
    fi

  fi

  return 0
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
  if [[ "$BL64_OS_DISTRO" =~ (UBUNTU-.*|FEDORA-.*|CENTOS-.*|OL-.*|DEBIAN-.*) ]]; then
    BL64_OS_CMD_AWK='/usr/bin/awk'
    BL64_OS_CMD_ID='/usr/bin/id'
    BL64_OS_CMD_USERADD='/usr/sbin/useradd'
    BL64_OS_CMD_TAR='/bin/tar'
    BL64_OS_CMD_LN='/bin/ln'
  fi
  if [[ "$BL64_OS_DISTRO" =~ (UBUNTU-.*|DEBIAN-.*) ]]; then
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_CHMOD='/bin/chmod'
    BL64_OS_CMD_CHOWN='/bin/chown'
    BL64_OS_CMD_CP='/bin/cp'
    BL64_OS_CMD_DATE="/bin/date"
    BL64_OS_CMD_GREP='/bin/grep'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_LS='/bin/ls'
    BL64_OS_CMD_MKDIR='/bin/mkdir'
    BL64_OS_CMD_MKTEMP='/bin/mktemp'
    BL64_OS_CMD_MV='/bin/mv'
    BL64_OS_CMD_RM='/bin/rm'
  fi
  if [[ "$BL64_OS_DISTRO" =~ (FEDORA-.*|CENTOS-.*|OL-.*) ]]; then
    BL64_OS_CMD_CAT='/usr/bin/cat'
    BL64_OS_CMD_CHMOD='/usr/bin/chmod'
    BL64_OS_CMD_CHOWN='/usr/bin/chown'
    BL64_OS_CMD_CP='/usr/bin/cp'
    BL64_OS_CMD_DATE="/usr/bin/date"
    BL64_OS_CMD_GREP='/usr/bin/grep'
    BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
    BL64_OS_CMD_LS='/usr/bin/ls'
    BL64_OS_CMD_MKDIR='/usr/bin/mkdir'
    BL64_OS_CMD_MKTEMP='/usr/bin/mktemp'
    BL64_OS_CMD_MV='/usr/bin/mv'
    BL64_OS_CMD_RM='/usr/bin/rm'
  fi

  return 0
}

#######################################
# Create command aliases for common use cases
# Aliases are presented as regular shell variables for easy inclusion in SUDO
# Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
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

  BL64_OS_ALIAS_CHOWN_DIR="$BL64_OS_CMD_CHOWN --verbose --recursive"
  BL64_OS_ALIAS_CP_FILE="$BL64_OS_CMD_CP --verbose --force"
  BL64_OS_ALIAS_ID_USER="$BL64_OS_CMD_ID -u -n"
  BL64_OS_ALIAS_LN_SYMBOLIC="$BL64_OS_CMD_LN --verbose --symbolic"
  BL64_OS_ALIAS_LS_FILES="$BL64_OS_CMD_LS --color=never"
  BL64_OS_ALIAS_MKDIR_FULL="$BL64_OS_CMD_MKDIR --parents --verbose"
  BL64_OS_ALIAS_MV="$BL64_OS_CMD_MV --force --verbose"
  BL64_OS_ALIAS_RM_FILE="$BL64_OS_CMD_RM --verbose --force --one-file-system"
  BL64_OS_ALIAS_RM_FULL="$BL64_OS_CMD_RM --verbose --force --one-file-system --recursive"

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
#   n: command exit status
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
#   n: command exit status
#######################################
function bl64_os_cp_file() {
  $BL64_OS_ALIAS_CP_FILE "$@"
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
#   n: command exit status
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
#   n: command exit status
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
#   n: command exit status
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
#   n: command exit status
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
#   n: command exit status
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
#   n: command exit status
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
#   n: command exit status
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
  :

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

  if [[ -d /var/log ]]; then
    $BL64_OS_ALIAS_RM_FULL /var/log/[[:alpha:]]*
  fi
  :

}

#######################################
# Remove or reset caches from standard locations
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

  # Man cache
  if [[ -d /var/cache/man ]]; then
    $BL64_OS_ALIAS_RM_FULL /var/cache/man/[[:alpha:]]*
  fi
  :

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
  :

}
