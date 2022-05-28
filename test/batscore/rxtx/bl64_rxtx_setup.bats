setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_rxtx_setup: module setup" {
  run bl64_rxtx_setup
  assert_success
}
