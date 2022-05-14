setup() {
  . "$DEVBL_TEST_SETUP"
  bl64_ans_setup
}

@test "bl64_ans_set_command: commands are set" {
  assert_not_equal "$BL64_ANS_CMD_ANSIBLE" ''
  assert_not_equal "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" ''
  assert_not_equal "$BL64_ANS_CMD_ANSIBLE_GALAXY" ''
}
