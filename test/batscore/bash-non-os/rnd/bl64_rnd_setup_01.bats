setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_rnd_setup: module setup" {
  run bl64_rnd_setup
  assert_success
}
