setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_rxtx_set_options: run function" {
  run bl64_rxtx_set_options
  assert_success
}
