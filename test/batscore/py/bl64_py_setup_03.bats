setup() {
  export TEST_SANDBOX

  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_VENV="${TEST_SANDBOX}/new"
  bl64_py_setup
  bl64_py_venv_create "$TEST_VENV"

}

@test "bl64_py_setup: enable venv" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'

  run bl64_py_setup "$TEST_VENV"

  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
