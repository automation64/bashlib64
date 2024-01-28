@test "bl64_txt_run_sort: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_sort
  assert_failure
}
