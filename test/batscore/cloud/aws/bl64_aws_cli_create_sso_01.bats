setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_cli_create_sso: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_cli_create_sso
  assert_failure
}

@test "bl64_aws_cli_create_sso: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_cli_create_sso '/dev/null'
  assert_failure
}

@test "bl64_aws_cli_create_sso: 3nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_cli_create_sso '/dev/null' 'test'
  assert_failure
}

@test "bl64_aws_cli_create_sso: 4th parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_cli_create_sso '/dev/null' 'test' 'test'
  assert_failure
}

@test "bl64_aws_cli_create_sso: 5th parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_cli_create_sso '/dev/null' 'test' 'test' 'test'
  assert_failure
}