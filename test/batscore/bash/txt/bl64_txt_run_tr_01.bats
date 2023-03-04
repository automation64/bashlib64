setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_run_tr: parameters are not present" {
  run bl64_txt_run_tr
  assert_failure
}
