@test "bl64_check_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_check_setup
  assert_success
}
