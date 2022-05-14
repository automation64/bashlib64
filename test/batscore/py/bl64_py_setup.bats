setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_py_setup: module setup" {
  run bl64_py_setup
  assert_success
}
