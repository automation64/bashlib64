setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
}

@test "bl64_py_pip_usr_install: install module - venv" {
  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  run bl64_py_pip_usr_cleanup

  assert_success
}
