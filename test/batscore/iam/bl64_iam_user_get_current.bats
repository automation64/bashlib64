setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_iam_user_get_current: run" {
  run bl64_iam_user_get_current
  assert_success
}
