setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
  bl64_msg_all_enable_verbose
}

@test "bl64_msg_show_lib_task: output" {
  local value='testing task msg'

  run bl64_msg_show_lib_task "$value"
  assert_success
  assert_output --partial "$value"
}
