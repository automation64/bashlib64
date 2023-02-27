setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ans_setup || skip 'no ansible cli found'
}

@test "bl64_ans_run_ansible_galaxy: both parameters are not present" {
  run bl64_ans_run_ansible_galaxy
  assert_failure
}

@test "bl64_ans_run_ansible_galaxy: subcommand parameter is not present" {
  run bl64_ans_run_ansible_galaxy '/dev/null'
  assert_failure
}
