@test "bl64_log_setup: no repo" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_log_setup
  assert_failure

}

@test "bl64_log_setup: invalid repo" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_log_setup '/dev/null'
  assert_failure

}
