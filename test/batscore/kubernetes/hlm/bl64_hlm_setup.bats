setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_hlm_setup || skip 'helm cli not found'
}

@test "bl64_hlm_setup: module setup ok" {
  run bl64_hlm_setup
  assert_success
}

@test "bl64_hlm_setup: invalid location" {
  run bl64_hlm_setup '/invalid/path'
  assert_failure
}
