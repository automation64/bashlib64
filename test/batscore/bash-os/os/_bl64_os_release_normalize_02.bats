@test "_bl64_os_release_normalize: rollling no version" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_os_release_normalize 'manjaro' "$BL64_VAR_NONE"
  assert_success
}

@test "_bl64_os_release_normalize: rolling version" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_os_release_normalize 'cachyos' '20251019.0.436919'
  assert_success
}

@test "_bl64_os_release_normalize: version-id major" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_os_release_normalize 'fedora' '43'
  assert_success
}
