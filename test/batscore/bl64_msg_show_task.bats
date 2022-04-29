setup() {
  . "$DEVBL_TEST_SETUP"

  bl64_msg_setup "$BL64_MSG_FORMAT_FULL"
}

@test "bl64_msg_show_task: output" {
  local value='testing task msg'

  run bl64_msg_show_task "$value"
  assert_success

  assert_output --partial "${BL64_SCRIPT_NAME}"
  assert_output --partial "${HOSTNAME}"
  assert_output --partial "${_BL64_MSG_TXT_TASK}"
  assert_output --partial "${value}"
}
