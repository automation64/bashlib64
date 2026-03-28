@test "bl64_msg_show_doc: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing doc msg'

  run bl64_msg_show_doc "$value"
  assert_success
}
