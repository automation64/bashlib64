setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@test "bl64_cnt_cli: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup
  run bl64_cnt_cli --version
  assert_success
}
