setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_set_home: run default" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_set_home
  assert_success
  assert_dir_exist "$HOME/.aws"
}

@test "bl64_aws_set_home: run alternate home" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_set_home "$HOME/test-aws-cli-home"
  assert_success
  assert_dir_exist "$HOME/test-aws-cli-home"
}
