@test "bl64_msg_show_separator: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
  local value='test1234'

  run bl64_msg_show_separator "$value" o 10
  assert_success
  assert_output --partial "$value"
}
