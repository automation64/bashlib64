setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_ans_run_ansible: CLI runs ok" {
  bl64_ans_setup || skip
  run bl64_ans_run_ansible --help
  assert_success
}
