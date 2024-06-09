setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_access_enable_sso: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_access_enable_sso
  assert_failure
}
