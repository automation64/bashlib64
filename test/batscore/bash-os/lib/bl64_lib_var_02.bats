@test "bl64_lib_env: public constants are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  # Logical values
  assert_equal "$BL64_VAR_TRUE" '0'
  assert_equal "$BL64_VAR_FALSE" '1'
  assert_equal "$BL64_VAR_ON" '1'
  assert_equal "$BL64_VAR_OFF" '0'
  assert_equal "$BL64_VAR_OK" '0'
  assert_equal "$BL64_VAR_NOTOK" '1'
  assert_equal "$BL64_VAR_YES" '1'
  assert_equal "$BL64_VAR_NO" '0'
}
