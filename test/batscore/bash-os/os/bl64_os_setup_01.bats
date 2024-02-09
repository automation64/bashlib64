@test "bl64_os_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_setup
  assert_success
}
