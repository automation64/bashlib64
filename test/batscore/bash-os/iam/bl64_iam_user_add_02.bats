@test "bl64_iam_user_add: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_add
  assert_failure
}
