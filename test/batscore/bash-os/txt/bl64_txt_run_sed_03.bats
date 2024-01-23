@test "bl64_txt_run_sed: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_sed
  assert_failure
}
