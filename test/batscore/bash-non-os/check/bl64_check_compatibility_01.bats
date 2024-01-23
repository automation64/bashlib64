@test "bl64_check_compatibility_mode: enabled" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_LIB_COMPATIBILITY="$BL64_VAR_ON"
  run bl64_check_compatibility_mode
  assert_success
}

@test "bl64_check_compatibility_mode: disabled" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  BL64_LIB_COMPATIBILITY="$BL64_VAR_OFF"
  run bl64_check_compatibility_mode
  assert_failure
}
