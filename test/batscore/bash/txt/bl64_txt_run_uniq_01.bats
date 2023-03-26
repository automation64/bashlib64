setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_run_uniq: parameters are not present" {
  run bl64_txt_run_uniq
  assert_failure
}
