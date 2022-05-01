setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_pkg_set_command: commands are set" {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* )
    assert_equal "$BL64_PKG_CMD_DNF" '/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    assert_equal "$BL64_PKG_CMD_DNF" '/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    assert_equal "$BL64_PKG_CMD_YUM" '/usr/bin/yum'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    assert_equal "$BL64_PKG_CMD_APT" '/usr/bin/apt-get'
    ;;
  ${BL64_OS_ALP}-*)
    assert_equal "$BL64_PKG_CMD_APK" '/sbin/apk'
    ;;
  ${BL64_OS_MCOS}-*)
    assert_equal "$BL64_PKG_CMD_BRW" '/opt/homebrew/bin/brew'
    ;;
  esac
}
