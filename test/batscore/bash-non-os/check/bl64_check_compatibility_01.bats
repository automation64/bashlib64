setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_compatibility: enabled" {

  BL64_LIB_COMPATIBILITY="$BL64_VAR_ON"
  run bl64_check_compatibility
  assert_success

}

@test "bl64_check_compatibility: disabled" {

  BL64_LIB_COMPATIBILITY="$BL64_VAR_OFF"
  run bl64_check_compatibility
  assert_failure

}
