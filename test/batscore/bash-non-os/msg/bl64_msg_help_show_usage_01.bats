@test "bl64_msg_help_show_usage: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_msg_help_usage_set 'bl64_msg_help_show_usage'

  run bl64_msg_help_show_usage
  assert_success
}
