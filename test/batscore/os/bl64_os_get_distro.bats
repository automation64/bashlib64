setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_os_get_distro: identify platform" {
  assert_not_equal "$BL64_OS_DISTRO" 'UNKNOWN'
}
