@test "bl64_txt_run_cut: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_cut
  assert_failure
}
