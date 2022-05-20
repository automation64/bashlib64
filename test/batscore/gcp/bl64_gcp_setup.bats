setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_gcp_setup: module setup" {
  run bl64_gcp_setup
  assert_success
}
