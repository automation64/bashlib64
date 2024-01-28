@test "bl64_py_run_python: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  bl64_py_setup
  run bl64_py_run_python
  assert_failure
}