@test "bl64_log_setup: target ok, single" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_log_setup /tmp 'single'
  assert_success

}

@test "bl64_log_setup: target ok, multiple" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_log_setup '/tmp' 'multiple' "$BL64_LOG_TYPE_MULTIPLE"
  assert_success

}
