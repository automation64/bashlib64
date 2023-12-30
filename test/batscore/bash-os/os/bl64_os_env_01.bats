setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_os_env: public OS constants are set" {
  assert_equal "$BL64_OS_ALM" 'ALMALINUX'
  assert_equal "$BL64_OS_ALP" 'ALPINE'
  assert_equal "$BL64_OS_AMZ" 'AMAZONLINUX'
  assert_equal "$BL64_OS_CNT" 'CENTOS'
  assert_equal "$BL64_OS_DEB" 'DEBIAN'
  assert_equal "$BL64_OS_FD" 'FEDORA'
  assert_equal "$BL64_OS_MCOS" 'DARWIN'
  assert_equal "$BL64_OS_OL" 'ORACLELINUX'
  assert_equal "$BL64_OS_RCK" 'ROCKYLINUX'
  assert_equal "$BL64_OS_RHEL" 'RHEL'
  assert_equal "$BL64_OS_SLES" 'SLES'
  assert_equal "$BL64_OS_UB" 'UBUNTU'
  assert_equal "$BL64_OS_UNK" 'UNKNOWN'
}
