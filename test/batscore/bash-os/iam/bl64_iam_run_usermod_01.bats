@test "bl64_iam_run_usermod: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_run_usermod
  assert_failure
}
