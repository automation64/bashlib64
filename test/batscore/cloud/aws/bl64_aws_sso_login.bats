setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_sso_login: parameter is not present" {
  run bl64_aws_sso_login
  assert_failure
}
