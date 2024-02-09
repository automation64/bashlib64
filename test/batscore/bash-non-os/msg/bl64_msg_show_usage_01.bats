@test "bl64_msg_show_usage: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_msg_show_usage
  assert_failure
}