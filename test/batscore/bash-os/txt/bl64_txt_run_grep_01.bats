@test "bl64_txt_run_grep: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_grep
  assert_failure
}
