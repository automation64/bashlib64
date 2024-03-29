@test "bl64_iam_run_sysadminctl: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_run_sysadminctl
  assert_failure
}
