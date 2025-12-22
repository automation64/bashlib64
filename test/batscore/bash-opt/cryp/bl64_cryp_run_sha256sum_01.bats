setup() {
  [[ -f /usr/bin/sha256sum ]] || skip 'sha256sum not installed'
}

@test "bl64_cryp_run_sha256sum: run command" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cryp_setup
  run bl64_cryp_run_sha256sum --version
  assert_success
}
