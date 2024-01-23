setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_py_venv_check: no arg" {
  run bl64_py_venv_check
  assert_failure
}
