@test "bl64_xsv_run_yq: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_xsv_setup
  run bl64_xsv_run_yq
  assert_failure
}
