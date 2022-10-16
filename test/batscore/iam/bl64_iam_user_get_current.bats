setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
}

@test "bl64_iam_user_get_current: run" {
  run bl64_iam_user_get_current
  assert_success
}
