@test "bl64_iam_run_groupadd: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_run_groupadd
  assert_failure
}
