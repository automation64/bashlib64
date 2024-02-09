setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_blank_aws: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_blank_aws
  assert_success
}
