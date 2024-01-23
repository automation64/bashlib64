@test "bl64_rnd_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rnd_setup
  assert_success
}
