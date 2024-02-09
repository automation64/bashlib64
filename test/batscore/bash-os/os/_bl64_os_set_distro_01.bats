@test "_bl64_os_set_distro: identify platform" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_os_set_distro
  assert_success
}
