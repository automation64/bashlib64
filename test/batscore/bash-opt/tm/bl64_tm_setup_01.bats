setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_tm_setup: module setup" {
  run bl64_tm_setup
  assert_success
}
