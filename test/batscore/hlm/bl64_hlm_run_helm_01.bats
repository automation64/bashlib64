setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_hlm_run_helm: both parameters are not present" {
  run bl64_hlm_run_helm
  assert_failure
}
