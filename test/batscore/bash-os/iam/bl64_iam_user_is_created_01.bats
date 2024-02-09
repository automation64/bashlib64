@test "bl64_iam_user_is_created: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_is_created
  assert_failure
}
