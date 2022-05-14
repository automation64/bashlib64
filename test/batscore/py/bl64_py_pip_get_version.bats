setup() {
  . "$DEVBL_TEST_SETUP"
  bl64_py_setup
}

@test "bl64_py_pip_get_version: get version" {

  run bl64_py_pip_get_version

  assert_success
  assert_not_equal "$output" ''
}
