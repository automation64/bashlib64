setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_aws_run_aws: CLI runs ok" {
  bl64_aws_setup || skip
  run bl64_aws_run_aws --help
  assert_success
}
