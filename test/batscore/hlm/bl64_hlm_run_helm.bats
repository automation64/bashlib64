setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_hlm_run_helm: CLI runs ok" {
  bl64_hlm_setup || skip
  run bl64_hlm_run_helm --help
  assert_success
}
