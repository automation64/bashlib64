@test "bl64_bsh_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_setup
  assert_success
}
