@test "bl64_rxtx_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rxtx_setup
  assert_success
}
