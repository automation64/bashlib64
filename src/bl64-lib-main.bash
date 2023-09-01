#
# Main
#

# Normalize locales to C until a better locale is found in bl64_os_setup
if bl64_lib_lang_is_enabled; then
  LANG='C'
  LC_ALL='C'
  LANGUAGE='C'
fi

# Set strict mode for enhanced security
if bl64_lib_mode_strict_is_enabled; then
  set -o 'nounset'
  set -o 'privileged'
fi

# Initialize OS independant modules
bl64_dbg_setup &&
  bl64_check_setup &&
  bl64_msg_setup &&
  bl64_bsh_setup &&
  bl64_rnd_setup &&
  bl64_ui_setup ||
  return $?

# Initialize OS dependant modules
bl64_os_setup &&
  bl64_txt_setup &&
  bl64_fmt_setup &&
  bl64_fs_setup &&
  bl64_iam_setup &&
  bl64_rbac_setup &&
  bl64_rxtx_setup &&
  bl64_api_setup &&
  bl64_vcs_setup ||
  return $?

# Set signal handlers
# shellcheck disable=SC2064
if bl64_lib_trap_is_enabled; then
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
if bl64_lib_mode_command_is_enabled; then
  bl64_dbg_lib_show_info 'run bashlib64 in command mode'
  "$@"
else
  bl64_dbg_lib_show_info 'run bashlib64 in source mode'
  :
fi
