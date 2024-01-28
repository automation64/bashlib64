@test "bl64_msg_show_task: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
  local value='testing batch msg'

  run bl64_msg_show_batch_start "$value"

  assert_success
}
