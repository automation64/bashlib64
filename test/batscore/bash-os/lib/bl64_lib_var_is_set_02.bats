@test "bl64_lib_var_is_set: is set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_var_is_set 'xxxxx'
  assert_success
}
