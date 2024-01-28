@test "bl64_aws_run_aws: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_run_aws
  assert_failure
}