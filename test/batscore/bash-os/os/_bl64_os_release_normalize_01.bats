@test "_bl64_os_release_normalize: missing args 1" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_os_release_normalize
  assert_failure
}

@test "_bl64_os_release_normalize: missing args 2" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_os_release_normalize X
  assert_failure
}
