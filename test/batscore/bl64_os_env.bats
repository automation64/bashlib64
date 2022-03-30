setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

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

@test "bl64_os_env: error constants are set" {
  assert_equal "$BL64_OS_ERROR_NO_OS_MATCH" 200
  assert_equal "$BL64_OS_ERROR_INVALID_OS_TAG" 201
}

