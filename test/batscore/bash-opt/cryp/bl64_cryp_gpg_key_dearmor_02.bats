setup() {
  [[ -f /usr/bin/gpg ]] || skip 'gpg not installed'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_cryp_gpg_key_dearmor: export ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cryp_gpg_setup
  run bl64_cryp_gpg_key_dearmor "${TESTMANSH_TEST_SAMPLES}/gpg_01/gpg_key_armored.gpg.asc" "${TEST_SANDBOX}/dearmored.gpg"
  assert_success
}

teardown() {
  [[ -d "$TEST_SANDBOX" ]] && temp_del "$TEST_SANDBOX"
  :
}
