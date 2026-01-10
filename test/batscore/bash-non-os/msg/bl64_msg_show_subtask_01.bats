@test "bl64_msg_show_subtask: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing subtask msg'

  run bl64_msg_show_subtask "$value"
  assert_success
}
