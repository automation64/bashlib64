@test "bl64_lib_flag_is_enabled: flag missing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_flag_is_enabled
  assert_failure
}
