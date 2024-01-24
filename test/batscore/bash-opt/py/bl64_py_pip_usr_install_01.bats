@test "bl64_py_pip_usr_install: install module - no venv" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  bl64_py_setup
  bl64_py_pip_usr_prepare

  run bl64_py_pip_usr_install 'pip-install-test'
  set -u

  assert_success
}
