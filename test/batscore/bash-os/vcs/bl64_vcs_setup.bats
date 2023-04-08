setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_vcs_setup: module setup" {
  run bl64_vcs_setup
  assert_success
}
