@test "bl64_rbac_run_bash_function: function with no args + root usr" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run bl64_rbac_run_bash_function "${TESTMANSH_TEST_SAMPLES}/libs/bash" 'root' 'bash_test'
  assert_success
  assert_output 'testing'
}

@test "bl64_rbac_run_bash_function: function with args + root usr" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run bl64_rbac_run_bash_function "${TESTMANSH_TEST_SAMPLES}/libs/bash" 'root' 'bash_test2' 'args'
  assert_success
  assert_output 'testing args'
}
