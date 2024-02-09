@test "bl64_txt_run_tr: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_tr
  assert_failure
}
