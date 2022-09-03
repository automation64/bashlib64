setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_ans_setup || skip
}

@test "bl64_ans_set_command: commands are set" {
  assert_not_equal "$BL64_ANS_CMD_ANSIBLE" ''
  assert_not_equal "$BL64_ANS_CMD_ANSIBLE_PLAYBOOK" ''
  assert_not_equal "$BL64_ANS_CMD_ANSIBLE_GALAXY" ''
}

@test "bl64_ans_set_command: paths are set" {
  assert_not_equal "$BL64_ANS_PATH_USR_ANSIBLE" ''
  assert_not_equal "$BL64_ANS_PATH_USR_COLLECTIONS" ''
}
