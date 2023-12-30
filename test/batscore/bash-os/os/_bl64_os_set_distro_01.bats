setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "_bl64_os_set_distro: identify platform" {
  run _bl64_os_set_distro
  assert_success
}
