@test "bl64_bsh_profile_rc_generate: generate" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_profile_rc_generate
  assert_success
}
