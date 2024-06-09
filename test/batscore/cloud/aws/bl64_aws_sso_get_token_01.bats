setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_sso_get_token: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_sso_get_token
  assert_failure
}
