@test "bl64_iam_user_get_current: run" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_get_current
  assert_success
}
