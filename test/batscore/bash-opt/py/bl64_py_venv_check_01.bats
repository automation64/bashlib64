setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export TEST_SANDBOX

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_py_venv_check: no arg" {
  bl64_py_setup

  run bl64_py_venv_check
  assert_failure

}


@test "bl64_py_venv_check: check not existing" {

  run bl64_py_venv_check "/not/a/valid/path"
  assert_failure

}

@test "bl64_py_venv_check: check invalid venv" {

  run bl64_py_venv_check "$TEST_SANDBOX"
  assert_failure

}

teardown() {
  temp_del "$TEST_SANDBOX"
}
