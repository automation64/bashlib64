@test "bl64_py_venv_check: no arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_py_venv_check
  assert_failure
}
