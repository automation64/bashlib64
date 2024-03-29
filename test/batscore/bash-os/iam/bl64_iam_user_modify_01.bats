@test "bl64_iam_user_modify: function parameter missing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_modify
  assert_failure
}
