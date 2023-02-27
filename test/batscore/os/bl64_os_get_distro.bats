setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "_bl64_os_set_distro: identify platform" {
  assert_not_equal "$BL64_OS_DISTRO" 'UNKNOWN'
}
