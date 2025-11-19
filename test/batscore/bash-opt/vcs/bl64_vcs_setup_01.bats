@test "bl64_vcs_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_setup
  assert_success
}
