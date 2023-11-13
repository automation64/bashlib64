setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_bsh_setup: module setup" {
  run bl64_bsh_setup
  assert_success
}
