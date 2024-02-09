@test "bl64_msg_show_lib_subtask: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing subtask msg'
  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
  bl64_msg_all_enable_verbose

  run bl64_msg_show_lib_subtask "$value"
  assert_success
  assert_output --partial "$value"
}
