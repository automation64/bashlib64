setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ans_setup || skip
}

@test "bl64_ans_run_ansible_playbook: parameters are present" {
  run bl64_ans_run_ansible_playbook
  assert_failure
}
