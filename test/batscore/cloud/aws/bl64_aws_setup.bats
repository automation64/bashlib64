setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_aws_setup: module setup ok" {
  run bl64_aws_setup
  assert_success
}
