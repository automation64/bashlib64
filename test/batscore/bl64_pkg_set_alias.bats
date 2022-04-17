setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_pkg_set_alias: alias are set" {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* )
    assert_equal "$BL64_PKG_ALIAS_DNF_CACHE" "$BL64_PKG_CMD_DNF --color=never makecache"
    assert_equal "$BL64_PKG_ALIAS_DNF_INSTALL" "$BL64_PKG_CMD_DNF --color=never --nodocs --assumeyes install"
    assert_equal "$BL64_PKG_ALIAS_DNF_CLEAN" "$BL64_PKG_CMD_DNF clean all"
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    assert_equal "$BL64_PKG_ALIAS_DNF_CACHE" "$BL64_PKG_CMD_DNF --color=never makecache"
    assert_equal "$BL64_PKG_ALIAS_DNF_INSTALL" "$BL64_PKG_CMD_DNF --color=never --nodocs --assumeyes install"
    assert_equal "$BL64_PKG_ALIAS_DNF_CLEAN" "$BL64_PKG_CMD_DNF clean all"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    assert_equal "$BL64_PKG_ALIAS_YUM_CACHE" "$BL64_PKG_CMD_YUM --color=never makecache"
    assert_equal "$BL64_PKG_ALIAS_YUM_INSTALL" "$BL64_PKG_CMD_YUM --color=never --assumeyes install"
    assert_equal "$BL64_PKG_ALIAS_YUM_CLEAN" "$BL64_PKG_CMD_YUM clean all"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    assert_equal "$BL64_PKG_ALIAS_APT_UPDATE" "$BL64_PKG_CMD_APT update"
    assert_equal "$BL64_PKG_ALIAS_APT_INSTALL" "$BL64_PKG_CMD_APT --assume-yes install"
    assert_equal "$BL64_PKG_ALIAS_APT_CLEAN" "$BL64_PKG_CMD_APT clean"
    ;;
  ${BL64_OS_ALP}-*)
    assert_equal "$BL64_PKG_ALIAS_APK_INSTALL" "$BL64_PKG_CMD_APK add --verbose"
    assert_equal "$BL64_PKG_ALIAS_APK_UPDATE" "$BL64_PKG_CMD_APK update"
    ;;
  ${BL64_OS_MCOS}-*)
    assert_equal "$BL64_PKG_ALIAS_BRW_INSTALL" "$BL64_PKG_CMD_BRW install"
    assert_equal "$BL64_PKG_ALIAS_BRW_CLEAN" "$BL64_PKG_CMD_BRW cleanup --prune=all -s"
    ;;
  esac
}
