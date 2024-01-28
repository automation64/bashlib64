@test "bl64_xsv_run_jq: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_xsv_setup
  run bl64_xsv_run_jq
  assert_failure
}
