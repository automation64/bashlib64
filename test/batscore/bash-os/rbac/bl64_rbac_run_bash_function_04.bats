@test "bl64_rbac_run_bash_function: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_run_bash_function
  assert_failure
}

@test "bl64_rbac_run_bash_function: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_run_bash_function '/dev/null'
  assert_failure
}