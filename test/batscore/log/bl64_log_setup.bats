setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_log_setup: type format" {

  run bl64_log_setup '/dev/null' '1' 'INVALID_TYPE'
  assert_failure

}

@test "bl64_log_setup: set type" {

  run bl64_log_setup '/dev/null' '1' "$BL64_LOG_TYPE_FILE"
  assert_success

}
