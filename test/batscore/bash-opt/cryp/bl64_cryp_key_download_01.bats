@test "bl64_cryp_key_download: missing args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cryp_key_download
  assert_failure
}
