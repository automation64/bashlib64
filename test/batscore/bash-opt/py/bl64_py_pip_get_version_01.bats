setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_py_pip_get_version: get version" {
  bl64_py_setup

  run bl64_py_pip_get_version

  assert_success
  assert_not_equal "$output" ''
}
