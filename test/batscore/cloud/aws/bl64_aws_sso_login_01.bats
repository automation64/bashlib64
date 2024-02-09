@test "bl64_aws_sso_login: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_sso_login
  assert_failure
}
