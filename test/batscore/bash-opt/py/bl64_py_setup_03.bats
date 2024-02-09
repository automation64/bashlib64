setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export TEST_SANDBOX

  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_VENV="${TEST_SANDBOX}/new"
}

@test "bl64_py_setup: enable venv" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
  bl64_py_venv_create "$TEST_VENV"

  run bl64_py_setup "$TEST_VENV"

  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
