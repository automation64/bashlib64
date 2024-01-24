setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ans_setup || skip 'no ansible cli found'
}

@test "bl64_ans_run_ansible_playbook: parameters are present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ans_run_ansible_playbook
  assert_failure
}
