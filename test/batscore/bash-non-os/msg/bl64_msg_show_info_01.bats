@test "bl64_msg_show_info: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing info msg'

  run bl64_msg_show_info "$value"
  assert_success
}
