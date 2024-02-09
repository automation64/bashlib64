@test "bl64_msg_show_text: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing text msg'

  run bl64_msg_show_text "$value"
  assert_success
  assert_output "$value"
}
