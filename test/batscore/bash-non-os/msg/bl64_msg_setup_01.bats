@test "bl64_msg_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_msg_setup
  assert_success
}
