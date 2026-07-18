#
# Library Main
#

_bl64_lib_harden_shopt &&
  _bl64_lib_harden_options ||
  exit $?

# Normalize terminal settings
TERM="${TERM:-vt100}"

# Normalize paths
TMPDIR='/tmp'

# Normalize interactive prompts
PS1="${PS1:-BL64 \u@\H:\w$ }"
PS2="${PS2:-BL64 > }"

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

# Set signal handlers
# shellcheck disable=SC2064
if bl64_lib_trap_is_enabled; then
  trap "$BL64_LIB_SIGNAL_HUP" 'SIGHUP'
  trap "$BL64_LIB_SIGNAL_STOP" 'SIGINT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGTERM'
  trap "$BL64_LIB_SIGNAL_DEBUG" 'DEBUG'
  trap "$BL64_LIB_SIGNAL_EXIT" 'EXIT'
  trap "$BL64_LIB_SIGNAL_ERR" 'ERR'
fi

# Set default umask
umask -S 'u=rwx,g=,o=' >/dev/null

# Initialize modules that do not require setup parameters. Not OS bound
[[ -n "${BL64_DBG_MODULE:-}" ]] && { bl64_dbg_setup || exit $?; }
[[ -n "${BL64_CHECK_MODULE:-}" ]] && { bl64_check_setup || exit $?; }
[[ -n "${BL64_MSG_MODULE:-}" ]] && { bl64_msg_setup || exit $?; }
[[ -n "${BL64_BSH_MODULE:-}" ]] && { bl64_bsh_setup || exit $?; }
[[ -n "${BL64_RND_MODULE:-}" ]] && { bl64_rnd_setup || exit $?; }
# Initialize modules that do not require setup parameters. OS bound
[[ -n "${BL64_OS_MODULE:-}" ]] && { bl64_os_setup || exit $?; }
[[ -n "${BL64_TXT_MODULE:-}" ]] && { bl64_txt_setup || exit $?; }
[[ -n "${BL64_FMT_MODULE:-}" ]] && { bl64_fmt_setup || exit $?; }
[[ -n "${BL64_FS_MODULE:-}" ]] && { bl64_fs_setup || exit $?; }
[[ -n "${BL64_IAM_MODULE:-}" ]] && { bl64_iam_setup || exit $?; }
[[ -n "${BL64_RBAC_MODULE:-}" ]] && { bl64_rbac_setup || exit $?; }
[[ -n "${BL64_RXTX_MODULE:-}" ]] && { bl64_rxtx_setup || exit $?; }
[[ -n "${BL64_API_MODULE:-}" ]] && { bl64_api_setup || exit $?; }
[[ -n "${BL64_VCS_MODULE:-}" ]] && { bl64_vcs_setup || exit $?; }
[[ -n "${BL64_ARC_MODULE:-}" ]] && { bl64_arc_setup || exit $?; }
[[ -n "${BL64_PKG_MODULE:-}" ]] && { bl64_pkg_setup || exit $?; }
[[ -n "${BL64_RND_MODULE:-}" ]] && { bl64_rnd_setup || exit $?; }
[[ -n "${BL64_TM_MODULE:-}" ]] && { bl64_tm_setup || exit $?; }

[[ $(type -t _bl64_dbg_runtime_show) == 'function' ]] && _bl64_dbg_runtime_show

_bl64_lib_script_set_identity &&
  _bl64_lib_check_os_compabitility ||
  exit $?

# Normalize user identity
LOGNAME="${LOGNAME:-$(_bl64_lib_helper_id)}"
USER="${USER:-$LOGNAME}"

# Run as script or sourced library
if bl64_lib_mode_command_is_enabled; then
  "$@"
else
  :
fi
