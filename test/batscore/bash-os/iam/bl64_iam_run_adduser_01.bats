@test "bl64_iam_run_adduser: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_run_adduser
  assert_failure
}
