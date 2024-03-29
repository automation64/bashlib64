@test "bl64_iam_run_addgroup: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_run_addgroup
  assert_failure
}
