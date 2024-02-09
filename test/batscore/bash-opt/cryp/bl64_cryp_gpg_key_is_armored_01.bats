@test "bl64_cryp_gpg_key_is_armored: missing args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cryp_gpg_key_is_armored
  assert_failure
}
