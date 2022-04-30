setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_pkg_set_alias: alias are set" {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    assert_equal "$BL64_PKG_ALIAS_DNF_CACHE" "$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} makecache"
    assert_equal "$BL64_PKG_ALIAS_DNF_INSTALL" "$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_SLIM} ${BL64_PKG_SET_ASSUME_YES} install"
    assert_equal "$BL64_PKG_ALIAS_DNF_CLEAN" "$BL64_PKG_CMD_DNF clean all"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    assert_equal "$BL64_PKG_ALIAS_YUM_CACHE" "$BL64_PKG_CMD_YUM ${BL64_PKG_SET_VERBOSE} makecache"
    assert_equal "$BL64_PKG_ALIAS_YUM_INSTALL" "$BL64_PKG_CMD_YUM ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_ASSUME_YES} install"
    assert_equal "$BL64_PKG_ALIAS_YUM_CLEAN" "$BL64_PKG_CMD_YUM clean all"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    assert_equal "$BL64_PKG_ALIAS_APT_CACHE" "$BL64_PKG_CMD_APT update ${BL64_PKG_SET_VERBOSE}"
    assert_equal "$BL64_PKG_ALIAS_APT_INSTALL" "$BL64_PKG_CMD_APT install ${BL64_PKG_SET_ASSUME_YES} ${BL64_PKG_SET_VERBOSE}"
    assert_equal "$BL64_PKG_ALIAS_APT_CLEAN" "$BL64_PKG_CMD_APT clean"
    ;;
  ${BL64_OS_ALP}-*)
    assert_equal "$BL64_PKG_ALIAS_APK_CACHE" "$BL64_PKG_CMD_APK update ${BL64_PKG_SET_VERBOSE}"
    assert_equal "$BL64_PKG_ALIAS_APK_INSTALL" "$BL64_PKG_CMD_APK add ${BL64_PKG_SET_VERBOSE}"
    assert_equal "$BL64_PKG_ALIAS_APK_CLEAN" "$BL64_PKG_CMD_APK cache clean ${BL64_PKG_SET_VERBOSE}"
    ;;
  ${BL64_OS_MCOS}-*)
    assert_equal "$BL64_PKG_ALIAS_BRW_CACHE" "$BL64_PKG_CMD_BRW update ${BL64_PKG_SET_VERBOSE}"
    assert_equal "$BL64_PKG_ALIAS_BRW_INSTALL" "$BL64_PKG_CMD_BRW install ${BL64_PKG_SET_VERBOSE}"
    assert_equal "$BL64_PKG_ALIAS_BRW_CLEAN" "$BL64_PKG_CMD_BRW cleanup ${BL64_PKG_SET_VERBOSE} --prune=all -s"
    ;;
  esac
}
