@test "bl64_api_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_api_setup
  assert_success
}
