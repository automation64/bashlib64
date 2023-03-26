setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_run_sort: parameters are not present" {
  run bl64_txt_run_sort
  assert_failure
}
