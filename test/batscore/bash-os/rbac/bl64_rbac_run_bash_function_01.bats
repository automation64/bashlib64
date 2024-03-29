@test "bl64_rbac_run_bash_function: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_run_bash_function
  assert_failure
}

@test "bl64_rbac_run_bash_function: 1 arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_run_bash_function "${TESTMANSH_TEST_SAMPLES}/libs/bash"
  assert_failure
}

@test "bl64_rbac_run_bash_function: 2 arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_run_bash_function "${TESTMANSH_TEST_SAMPLES}/libs/bash" 'root'
  assert_failure
}
