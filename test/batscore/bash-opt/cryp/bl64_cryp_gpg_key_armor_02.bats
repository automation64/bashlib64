setup() {
  [[ -f /usr/bin/gpg ]] || skip 'gpg not installed'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_cryp_gpg_key_armor: export ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cryp_setup
  run bl64_cryp_gpg_key_armor "${TESTMANSH_TEST_SAMPLES}/gpg_01/gpg_key_dearmored.gpg" "${TEST_SANDBOX}/armored.gpg"
  assert_success
}

teardown() {
  [[ -d "$TEST_SANDBOX" ]] && temp_del "$TEST_SANDBOX"
  :
}
