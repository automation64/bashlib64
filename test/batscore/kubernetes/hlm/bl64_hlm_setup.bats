setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_hlm_setup: CLI runs ok" {
  run bl64_hlm_setup
  assert_success
}
