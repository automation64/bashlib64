@test "bl64_tm_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_tm_setup
  assert_success
}
