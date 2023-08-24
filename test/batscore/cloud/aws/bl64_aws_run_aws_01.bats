setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_run_aws: CLI runs ok" {
  run bl64_aws_run_aws help
  assert_success
}

@test "bl64_aws_run_aws: parameters are not present" {
  run bl64_aws_run_aws
  assert_failure
}