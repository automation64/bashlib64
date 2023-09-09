setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_dbg_setup: module setup" {
  run bl64_dbg_setup
  assert_success
}
