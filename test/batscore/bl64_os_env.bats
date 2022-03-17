setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_sudo_env: public constants are set" {
  assert_equal "$BL64_OS_UB" 'UBUNTU'
  assert_equal "$BL64_OS_DEB" 'DEBIAN'
  assert_equal "$BL64_OS_FD" 'FEDORA'
  assert_equal "$BL64_OS_CNT" 'CENTOS'
  assert_equal "$BL64_OS_OL" 'OL'
  assert_equal "$BL64_OS_ALP" 'ALPINE'
}
