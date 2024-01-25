setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_hlm_setup || skip 'helm cli not found'
}

@test "bl64_hlm_run_helm: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_hlm_run_helm --help
  assert_success
}
