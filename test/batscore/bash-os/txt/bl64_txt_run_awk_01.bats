@test "bl64_txt_run_awk: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_awk
  assert_failure
}
