@test "bl64_msg_show_separator: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
  local value=': oooo[test]oooooooooo'

  run bl64_msg_show_separator "oooo[test]" o 10
  assert_success
  assert_output --partial "$value"
}
