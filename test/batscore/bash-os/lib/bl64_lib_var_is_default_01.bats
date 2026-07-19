@test "bl64_lib_var_is_default: is not default" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_var_is_default 'ANYOTHERVALUE'
  assert_failure
}
