setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_SANDBOX="$(temp_make)"
  touch "${TEST_SANDBOX}/ansible" "${TEST_SANDBOX}/ansible-galaxy" "${TEST_SANDBOX}/ansible-playbook"
  chmod 755 "${TEST_SANDBOX}/ansible" "${TEST_SANDBOX}/ansible-galaxy" "${TEST_SANDBOX}/ansible-playbook"
  bl64_ans_setup "$TEST_SANDBOX"
}

@test "bl64_ans_set_options: common globals are set" {
  assert_not_equal "$BL64_ANS_SET_VERBOSE" ''
  assert_not_equal "$BL64_ANS_SET_DEBUG" ''
  assert_not_equal "$BL64_ANS_SET_DIFF" ''
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
