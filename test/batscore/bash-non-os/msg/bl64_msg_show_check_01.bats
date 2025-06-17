@test "bl64_msg_show_check: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
  local value='testing task msg'

  run bl64_msg_show_check "$value"
  assert_success
  assert_output --partial "$value"
}
