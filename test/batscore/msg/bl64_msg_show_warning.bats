setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
}

@test "bl64_msg_show_warning: output" {
  local value='testing task msg'

  run bl64_msg_show_warning "$value"
  assert_success
  assert_output --partial "$value"
}
