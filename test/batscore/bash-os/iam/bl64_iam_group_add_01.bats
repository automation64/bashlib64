@test "bl64_iam_group_add: function parameter missing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_group_add
  assert_failure
}
