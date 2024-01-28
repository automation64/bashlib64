@test "bl64_cryp_gpg_key_dearmor: missing args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cryp_gpg_key_dearmor
  assert_failure
}
