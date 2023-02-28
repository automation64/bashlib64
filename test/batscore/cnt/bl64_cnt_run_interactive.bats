setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_run_interactive && skip 'not applicable to container mode'
  bl64_cnt_setup
}

@test "bl64_cnt_run_interactive: run ok" {
  run bl64_cnt_run_interactive
  assert_success
}
