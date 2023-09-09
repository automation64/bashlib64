setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_env: public constants are set" {
  # Default value for parameters
  assert_equal "$BL64_VAR_DEFAULT" '_'

  # Flag for incompatible command or task
  assert_equal "$BL64_VAR_INCOMPATIBLE" '_INC_'

  # Flag for unavailable command or task
  assert_equal "$BL64_VAR_UNAVAILABLE" '_UNV_'

  # Pseudo null value
  assert_equal "$BL64_VAR_NULL" '_NULL_'

  # Logical values
  assert_equal "$BL64_VAR_TRUE" '0'
  assert_equal "$BL64_VAR_FALSE" '1'
  assert_equal "$BL64_VAR_ON" '1'
  assert_equal "$BL64_VAR_OFF" '0'
  assert_equal "$BL64_VAR_OK" '0'
  assert_equal "$BL64_VAR_NONE" '0'
  assert_equal "$BL64_VAR_ALL" '1'
}
