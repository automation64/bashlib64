setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
}

@test "bl64_msg_show_text: output" {
  local value='testing text msg'

  run bl64_msg_show_text "$value"
  assert_success
  assert_output "$value"
}
