setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_set_paths: defaults" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_aws_set_paths
  assert_success
}
