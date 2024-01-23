setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_xsv_run_jq: parameters are not present" {
  bl64_xsv_setup
  run bl64_xsv_run_jq
  assert_failure
}
