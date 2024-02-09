setup() {
  [[ -f /usr/bin/gpg ]] || skip 'gpg not installed'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_cryp_key_download: download ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cryp_gpg_setup
  run bl64_cryp_key_download "$DEV_TEST_VALUE_CRYP_GPG_URL" "${TEST_SANDBOX}/key.gpg"
  assert_success
}

teardown() {
  [[ -d "$TEST_SANDBOX" ]] && temp_del "$TEST_SANDBOX"
  :
}
