setup() {
  [[ -f /usr/bin/md5sum ]] || skip 'md5sum not installed'
}

@test "bl64_cryp_run_md5sum: run command" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cryp_setup
  run bl64_cryp_run_md5sum "$TESTMANSH_TEST_SAMPLES/text_03.txt"
  assert_success
}
