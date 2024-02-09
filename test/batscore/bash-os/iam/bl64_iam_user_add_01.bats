@test "bl64_iam_user_add: function parameter missing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_add
  assert_failure
}
