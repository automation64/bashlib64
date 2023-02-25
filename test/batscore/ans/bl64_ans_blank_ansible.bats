setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ans_setup || skip
}

@test "bl64_ans_blank_ansible: run ok" {
  run bl64_ans_blank_ansible
  assert_success
}
