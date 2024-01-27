setup() {
  [[ -f /usr/bin/openssl ]] || skip 'gpg not installed'
}

@test "bl64_cryp_run_openssl: run command" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cryp_setup
  run bl64_cryp_run_openssl version
  assert_success
}
