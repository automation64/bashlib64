setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_aws_setup || skip 'no aws cli found'
}

@test "bl64_aws_run_aws_profile: file parameter not existing" {
  run bl64_aws_run_aws_profile '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
