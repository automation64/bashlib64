@test "bl64_py_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_py_setup
  assert_success
}
