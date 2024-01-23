@test "bl64_dbg_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_dbg_setup
  assert_success
}
