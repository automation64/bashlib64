@test "bl64_lib_var_is_default: is default" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_var_is_default "$BL64_VAR_DEFAULT"
  assert_success
}

@test "bl64_lib_var_is_default: is default legacy" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_var_is_default "$BL64_VAR_DEFAULT_LEGACY"
  assert_success
}
