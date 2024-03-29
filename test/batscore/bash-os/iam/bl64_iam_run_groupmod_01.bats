@test "bl64_iam_run_groupmod: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_run_groupmod
  assert_failure
}
