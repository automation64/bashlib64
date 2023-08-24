setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /opt/aws/bin/aws ]] || skip 'no aws cli found'
}

@test "bl64_aws_setup: module setup ok" {
  run bl64_aws_setup
  assert_success
}

@test "bl64_aws_setup: invalid path" {
  run bl64_aws_setup '/1/2/3'
  assert_failure
}
