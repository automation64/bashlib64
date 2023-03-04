setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_run_cut: parameters are not present" {
  run bl64_txt_run_cut
  assert_failure
}
