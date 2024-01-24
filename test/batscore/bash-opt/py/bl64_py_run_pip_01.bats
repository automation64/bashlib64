@test "bl64_py_run_pip: run pip" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  bl64_py_setup

  run bl64_py_run_pip
  set -u

  assert_success
}
