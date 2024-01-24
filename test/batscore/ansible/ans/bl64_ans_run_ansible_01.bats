setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ans_setup || skip 'no ansible cli found'
}

@test "bl64_ans_run_ansible: parameters are present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ans_run_ansible
  assert_failure
}

@test "bl64_ans_run_ansible: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ans_run_ansible --help
  assert_success
}
