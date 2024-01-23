setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_py_pip_usr_install: install module - no venv" {
  bl64_py_setup
  bl64_py_pip_usr_prepare
  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  run bl64_py_pip_usr_install 'pip-install-test'
  set -u

  assert_success
}
