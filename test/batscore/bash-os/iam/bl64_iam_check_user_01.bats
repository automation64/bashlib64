@test "bl64_iam_check_user: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_iam_check_user
  assert_failure

}

