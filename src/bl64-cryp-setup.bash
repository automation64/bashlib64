#######################################
# BashLib64 / Module / Setup / Cryptography tools
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Channels:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_cryp_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MOD_SETUP' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MOD_SETUP' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MOD_SETUP' &&
    _bl64_lib_module_is_imported 'BL64_TXT_MOD_SETUP' &&
    _bl64_lib_module_is_imported 'BL64_FS_MOD_SETUP' &&
    _bl64_lib_module_is_imported 'BL64_RXTX_MOD_SETUP' &&
    _bl64_cryp_set_command &&
    BL64_CRYP_MOD_SETUP="$BL64_VAR_ON"
  bl64_check_rise_module_setup 'cryp'
}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Channels:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_cryp_set_command() {
  bl64_dbg_lib_show_function
  BL64_CRYP_CMD_MD5SUM="$(bl64_bsh_command_locate 'md5sum')"
  BL64_CRYP_CMD_SHA256SUM="$(bl64_bsh_command_locate 'sha256sum')"
  BL64_CRYP_CMD_GPG="$(bl64_bsh_command_locate 'gpg')"
  BL64_CRYP_CMD_OPENSSL="$(bl64_bsh_command_locate 'openssl')"
  return 0
}
