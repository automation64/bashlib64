@test "bl64_lib_env: public constants are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  # Default value for parameters
  assert_equal "$BL64_VAR_DEFAULT" 'DEFAULT'
  assert_equal "$BL64_VAR_DEFAULT_LEGACY" '_'

  # Flag for incompatible command or task
  assert_equal "$BL64_VAR_INCOMPATIBLE" '_INC_'

  # Flag for unavailable command or task
  assert_equal "$BL64_VAR_UNAVAILABLE" '_UNV_'

  # Pseudo null value
  assert_equal "$BL64_VAR_NULL" '_NULL_'
  assert_equal "$BL64_VAR_NONE" '_NONE_'
  assert_equal "$BL64_VAR_ALL" '_ALL_'
}
