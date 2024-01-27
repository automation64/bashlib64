setup() {
  [[ -f /usr/bin/gpg ]] || skip 'gpg not installed'
}

@test "bl64_cryp_run_gpg: run command" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cryp_setup
  run bl64_cryp_run_gpg --version
  assert_success
}
