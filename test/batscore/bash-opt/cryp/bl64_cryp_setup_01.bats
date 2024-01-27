@test "bl64_cryp_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cryp_setup
  assert_success
}
