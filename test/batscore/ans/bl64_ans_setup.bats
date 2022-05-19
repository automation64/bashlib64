setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_ans_setup: module setup - fail" {
  run bl64_ans_setup '/no/ansible'
  assert_failure
}

@test "bl64_ans_setup: module setup - ok" {
  run bl64_ans_setup "$BL64_OS_CMD_TRUE"
  assert_success
}
