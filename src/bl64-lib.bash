#######################################
# BashLib64 / Module / Functions / Setup script run-time environment
#
# Version: 3.1.0
#######################################

#
# Main
#

# Normalize locales to C
if [[ "$BL64_LIB_LANG" == '1' ]]; then
  LANG='C'
  LC_ALL='C'
  LANGUAGE='C'
fi

# Set strict mode for enhanced security
if [[ "$BL64_LIB_STRICT" == '1' ]]; then
  set -o 'nounset'
  set -o 'privileged'
fi

# Initialize mandatory modules
bl64_dbg_setup &&
  bl64_msg_setup &&
  bl64_bsh_setup &&
  bl64_os_setup &&
  bl64_txt_setup &&
  bl64_fs_setup &&
  bl64_arc_setup &&
  bl64_iam_setup &&
  bl64_pkg_setup &&
  bl64_rbac_setup &&
  bl64_ui_setup &&
  bl64_vcs_setup &&
  bl64_rxtx_setup ||
  return $?

# Set signal handlers
# shellcheck disable=SC2064
if [[ "$BL64_LIB_TRAPS" == "$BL64_LIB_VAR_ON" ]]; then
  bl64_dbg_lib_show_info 'enable traps'
  trap "$BL64_LIB_SIGNAL_HUP" 'SIGHUP'
  trap "$BL64_LIB_SIGNAL_STOP" 'SIGINT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGTERM'
  trap "$BL64_LIB_SIGNAL_DEBUG" 'DEBUG'
  trap "$BL64_LIB_SIGNAL_EXIT" 'EXIT'
  trap "$BL64_LIB_SIGNAL_ERR" 'ERR'
fi

# Set default umask
bl64_fs_set_umask

# Set script identity
bl64_bsh_script_set_identity

# Enable command mode: the library can be used as a stand-alone script to run embeded functions
if [[ "$BL64_LIB_CMD" == "$BL64_LIB_VAR_ON" ]]; then
  bl64_dbg_lib_show_info 'run bashlib64 in command mode'
  "$@"
else
  bl64_dbg_lib_show_info 'run bashlib64 in source mode'
  :
fi
