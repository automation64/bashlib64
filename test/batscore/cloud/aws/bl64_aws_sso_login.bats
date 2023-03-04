setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_sso_login: run ok" {
  run bl64_aws_sso_login
  assert_success
}
