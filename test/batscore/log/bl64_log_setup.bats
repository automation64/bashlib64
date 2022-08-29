setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_log_setup: no repo" {

  run bl64_log_setup
  assert_failure

}

@test "bl64_log_setup: invalid repo" {

  run bl64_log_setup '/dev/null'
  assert_failure

}
