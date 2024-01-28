setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_sts_get_caller_arn: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup
  run bl64_aws_sts_get_caller_arn
  assert_failure
}
