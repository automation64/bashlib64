setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_api_setup: module setup" {
  run bl64_api_setup
  assert_success
}
