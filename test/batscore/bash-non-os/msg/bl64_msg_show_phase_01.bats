setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
}

@test "bl64_msg_show_phase: output" {
  local value='testing phase msg'

  run bl64_msg_show_phase "$value"
  assert_success
  assert_output --partial "$value"
}
