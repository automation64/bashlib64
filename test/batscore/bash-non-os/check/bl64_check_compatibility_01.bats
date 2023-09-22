setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_compatibility_mode: enabled" {

  BL64_LIB_COMPATIBILITY="$BL64_VAR_ON"
  run bl64_check_compatibility_mode
  assert_success

}

@test "bl64_check_compatibility_mode: disabled" {

  BL64_LIB_COMPATIBILITY="$BL64_VAR_OFF"
  run bl64_check_compatibility_mode
  assert_failure

}
