@test "bl64_check_rise_task_failed: rise error" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_rise_task_failed
  assert_failure
}
