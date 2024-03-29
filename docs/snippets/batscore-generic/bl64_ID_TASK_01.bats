@test "bl64_X_MODULE_X_X_TASK_X: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_X_MODULE_X_X_TASK_X
  assert_failure
}
