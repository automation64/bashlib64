@test "bl64_cryp_gpg_key_is_armored: is armored" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cryp_gpg_key_is_armored "${TESTMANSH_TEST_SAMPLES}/gpg_01/gpg_key_armored.gpg.asc"
  assert_success
}

@test "bl64_cryp_gpg_key_is_armored: is not armored" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cryp_gpg_key_is_armored "${TESTMANSH_TEST_SAMPLES}/gpg_01/gpg_key_dearmored.gpg"
  assert_failure
}
