setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_SANDBOX="$(temp_make)"
  touch "${TEST_SANDBOX}/ansible" "${TEST_SANDBOX}/ansible-galaxy" "${TEST_SANDBOX}/ansible-playbook"
  chmod 755 "${TEST_SANDBOX}/ansible" "${TEST_SANDBOX}/ansible-galaxy" "${TEST_SANDBOX}/ansible-playbook"
  bl64_ans_setup "$TEST_SANDBOX"
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

teardown() {
  temp_del "$TEST_SANDBOX"
}
