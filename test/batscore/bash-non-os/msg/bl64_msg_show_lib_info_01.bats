@test "bl64_msg_show_lib_info: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing info msg'
  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
  bl64_msg_all_enable_verbose

  run bl64_msg_show_lib_info "$value"
  assert_success
  assert_output --partial "$value"
}
