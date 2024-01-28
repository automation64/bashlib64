@test "bl64_cryp_gpg_key_armor: missing args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cryp_gpg_key_armor
  assert_failure
}
