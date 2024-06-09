setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_access_enable_token: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_access_enable_token
  assert_failure
}
