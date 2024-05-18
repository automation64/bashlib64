#
# Library Main
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

# Initialize optional modules that do not require setup parameters
[[ -n "${BL64_DBG_MODULE:-}" ]] && { bl64_dbg_setup || exit $?; }
[[ -n "${BL64_CHECK_MODULE:-}" ]] && { bl64_check_setup || exit $?; }
[[ -n "${BL64_MSG_MODULE:-}" ]] && { bl64_msg_setup || exit $?; }
[[ -n "${BL64_BSH_MODULE:-}" ]] && { bl64_bsh_setup || exit $?; }
[[ -n "${BL64_RND_MODULE:-}" ]] && { bl64_rnd_setup || exit $?; }
[[ -n "${BL64_UI_MODULE:-}" ]] && { bl64_ui_setup || exit $?; }
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
[[ -n "${BL64_UI_MODULE:-}" ]] && { bl64_ui_setup || exit $?; }

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

bl64_lib_script_set_identity

# Check OS compatibility
if [[ "${BL64_OS_MODULE:-}" == "$BL64_VAR_ON" ]]; then
  bl64_os_check_compatibility \
    "${BL64_OS_ALM}-8" "${BL64_OS_ALM}-9" \
    "${BL64_OS_ALP}-3" \
    "${BL64_OS_AMZ}-2023" \
    "${BL64_OS_CNT}-7" "${BL64_OS_CNT}-8" "${BL64_OS_CNT}-9" \
    "${BL64_OS_DEB}-9" "${BL64_OS_DEB}-10" "${BL64_OS_DEB}-11" "${BL64_OS_DEB}-12" \
    "${BL64_OS_FD}-33" "${BL64_OS_FD}-34" "${BL64_OS_FD}-35" "${BL64_OS_FD}-36" "${BL64_OS_FD}-37" "${BL64_OS_FD}-38" "${BL64_OS_FD}-39" "${BL64_OS_FD}-40" \
    "${BL64_OS_OL}-7" "${BL64_OS_OL}-8" "${BL64_OS_OL}-9" \
    "${BL64_OS_RCK}-8" "${BL64_OS_RCK}-9" \
    "${BL64_OS_RHEL}-8" "${BL64_OS_RHEL}-9" \
    "${BL64_OS_SLES}-15" \
    "${BL64_OS_UB}-18" "${BL64_OS_UB}-20" "${BL64_OS_UB}-21" "${BL64_OS_UB}-22" "${BL64_OS_UB}-23" "${BL64_OS_UB}-24" ||
    exit $?
fi

# Run as script or sourced library?
if bl64_lib_mode_command_is_enabled; then
  "$@"
else
  :
fi
