@test "bl64_rbac_run_command: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_run_command
  assert_failure
}

@test "bl64_rbac_run_command: 1 arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_run_command 'root'
  assert_failure
}
