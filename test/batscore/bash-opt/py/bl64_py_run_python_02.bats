@test "bl64_py_run_python: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  bl64_py_setup

  run bl64_py_run_python --version
  assert_success
}
