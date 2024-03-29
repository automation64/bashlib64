@test "bl64_X_MODULE_X_X_TASK_X: X_TEST_DESCRIPTION_X" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  # optional # bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run bl64_X_MODULE_X_X_TASK_X
  assert_success
}
