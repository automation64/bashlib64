setup() {
  export TEST_SANDBOX

  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"

}

@test "bl64_py_pip_usr_install: install module - venv" {
  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  bl64_py_setup "${TEST_SANDBOX}/venv" &&
    bl64_py_pip_usr_prepare

  run bl64_py_pip_usr_install 'pip-install-test'
  set -u

  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
