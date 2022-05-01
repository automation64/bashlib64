setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_os_env: public OS constants are set" {
  assert_equal "$BL64_OS_TAGS" 'ALM ALP AMZ CNT DEB FD MCOS OL RHEL UB'
  assert_equal "$BL64_OS_ALM" 'ALMALINUX'
  assert_equal "$BL64_OS_ALP" 'ALPINE'
  assert_equal "$BL64_OS_AMZ" 'AMZN'
  assert_equal "$BL64_OS_CNT" 'CENTOS'
  assert_equal "$BL64_OS_DEB" 'DEBIAN'
  assert_equal "$BL64_OS_FD" 'FEDORA'
  assert_equal "$BL64_OS_MCOS" 'DARWIN'
  assert_equal "$BL64_OS_OL" 'OL'
  assert_equal "$BL64_OS_RHEL" 'RHEL'
  assert_equal "$BL64_OS_UB" 'UBUNTU'
  assert_equal "$BL64_OS_UNK" 'UNKNOWN'
}
