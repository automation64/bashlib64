#######################################
# BashLib64 / Module / Setup / OS / Identify OS attributes and provide command aliases
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_os_setup() {
  [[ -z "$BL64_VERSION" ]] &&
    echo 'Error: bashlib64-module-core.bash should the last module to be sourced' &&
    return 21

  [[ "${BASH_VERSINFO[0]}" != '4' && "${BASH_VERSINFO[0]}" != '5' ]] &&
    bl64_msg_show_error "BashLib64 is not supported in the current Bash version (${BASH_VERSINFO[0]})" &&
    return $BL64_LIB_ERROR_OS_BASH_VERSION

  bl64_lib_module_imported 'BL64_CHECK_MODULE' &&
    bl64_lib_module_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    bl64_lib_module_imported 'BL64_MSG_MODULE' &&
    _bl64_os_set_distro &&
    _bl64_os_set_runtime &&
    _bl64_os_set_command &&
    _bl64_os_set_options &&
    BL64_OS_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'os'
}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_os_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_OS_CMD_BASH='/bin/bash'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TEE='/usr/bin/tee'
    BL64_OS_CMD_TRUE='/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_OS_CMD_BASH='/bin/bash'
    BL64_OS_CMD_CAT='/usr/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/usr/bin/false'
    BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TEE='/usr/bin/tee'
    BL64_OS_CMD_TRUE='/usr/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_OS_CMD_BASH='/usr/bin/bash'
    BL64_OS_CMD_CAT='/usr/bin/cat'
    BL64_OS_CMD_DATE='/usr/bin/date'
    BL64_OS_CMD_FALSE='/usr/bin/false'
    BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TEE='/usr/bin/tee'
    BL64_OS_CMD_TRUE='/usr/bin/true'
    BL64_OS_CMD_UNAME='/usr/bin/uname'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_OS_CMD_BASH='/bin/bash'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TEE='/usr/bin/tee'
    BL64_OS_CMD_TRUE='/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_MCOS}-*)
    # Homebrew used when no native option available
    BL64_OS_CMD_BASH='/opt/homebre/bin/bash'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/usr/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TEE='/usr/bin/tee'
    BL64_OS_CMD_TRUE='/usr/bin/true'
    BL64_OS_CMD_UNAME='/usr/bin/uname'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_os_set_options() {
  bl64_dbg_lib_show_function

  BL64_OS_SET_LOCALE_ALL='--all-locales'
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_os_set_runtime() {
  bl64_dbg_lib_show_function

  # Reset language to modern specification of C locale
  if bl64_lib_lang_is_enabled; then
    # shellcheck disable=SC2034
    case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
      bl64_os_set_lang 'C.UTF-8'
      ;;
    ${BL64_OS_FD}-*)
      bl64_os_set_lang 'C.UTF-8'
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_dbg_lib_show_comments 'UTF locale not installed by default, skipping'
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-8.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RCK}-*)
      bl64_os_set_lang 'C.UTF-8'
      ;;
    ${BL64_OS_SLES}-*)
      bl64_os_set_lang 'C.UTF-8'
      ;;
    ${BL64_OS_ALP}-*)
      bl64_dbg_lib_show_comments 'UTF locale not installed by default, skipping'
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_dbg_lib_show_comments 'UTF locale not installed by default, skipping'
      ;;
    *)
      bl64_check_alert_unsupported
      return $?
      ;;
    esac
  fi

  return 0
}

#######################################
# Set locale related shell variables
#
# * Locale variables are set as is, no extra validation on the locale availability
#
# Arguments:
#   $1: locale name
# Outputs:
#   STDOUT: None
#   STDERR: Validation errors
# Returns:
#   0: set ok
#   >0: set error
#######################################
function bl64_os_set_lang() {
  bl64_dbg_lib_show_function "$@"
  local locale="$1"

  bl64_check_parameter 'locale' || return $?

  LANG="$locale"
  LC_ALL="$locale"
  LANGUAGE="$locale"
  bl64_dbg_lib_show_vars 'LANG' 'LC_ALL' 'LANGUAGE'

  return 0
}
