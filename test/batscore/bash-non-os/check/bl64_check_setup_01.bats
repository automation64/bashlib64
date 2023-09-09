setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_setup: module setup" {
  run bl64_check_setup
  assert_success
}
