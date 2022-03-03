setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_pkg_env: commands are set" {
  assert_equal "$BL64_PKG_CMD_APT" '/usr/bin/apt-get'
  assert_equal "$BL64_PKG_CMD_DNF" '/usr/bin/dnf'
  assert_equal "$BL64_PKG_CMD_YUM" '/usr/bin/yum'
  assert_equal "$BL64_PKG_CMD_APK" '/sbin/apk'
}

@test "bl64_pkg_env: alias are set" {
  assert_equal "$BL64_PKG_ALIAS_APT_UPDATE" "$BL64_PKG_CMD_APT update"
  assert_equal "$BL64_PKG_ALIAS_APT_INSTALL" "$BL64_PKG_CMD_APT --assume-yes install"
  assert_equal "$BL64_PKG_ALIAS_APT_CLEAN" "$BL64_PKG_CMD_APT clean"
  assert_equal "$BL64_PKG_ALIAS_DNF_CACHE" "$BL64_PKG_CMD_DNF --color=never makecache"
  assert_equal "$BL64_PKG_ALIAS_DNF_INSTALL" "$BL64_PKG_CMD_DNF --color=never --nodocs --assumeyes install"
  assert_equal "$BL64_PKG_ALIAS_DNF_CLEAN" "$BL64_PKG_CMD_DNF clean all"
  assert_equal "$BL64_PKG_ALIAS_APK_INSTALL" "$BL64_PKG_CMD_APK add --verbose"
  assert_equal "$BL64_PKG_ALIAS_APK_UPDATE" "$BL64_PKG_CMD_APK update"
}
