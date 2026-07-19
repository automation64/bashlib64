@test "bl64_lib_var_is_set: is not set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_var_is_set ''
  assert_failure
}

@test "bl64_lib_var_is_set: is null" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_var_is_set "$BL64_VAR_NULL"
  assert_failure
}

@test "bl64_lib_var_is_set: is default" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_var_is_set "$BL64_VAR_DEFAULT"
  assert_failure
}

@test "bl64_lib_var_is_set: is default legacy" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_var_is_set "$BL64_VAR_DEFAULT_LEGACY"
  assert_failure
}
