@test "bl64_ans_run_ansible: parameters are present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ans_run_ansible
  assert_failure
}
