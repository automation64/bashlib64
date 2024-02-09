@test "bl64_fmt_check_value_in_list: value is ok, 1 value" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_check_value_in_list "$BL64_VAR_DEFAULT" 'VALUE1' 'VALUE1'
  assert_success
}

@test "bl64_fmt_check_value_in_list: value is ok, 3 values" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_check_value_in_list "$BL64_VAR_DEFAULT" 'VALUE1' 'VALUE1' 'VALUE2' 'VALUE3'
  assert_success
}

@test "bl64_fmt_check_value_in_list: value is not ok, 1 value" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_check_value_in_list "$BL64_VAR_DEFAULT" 'X' 'VALUE1'
  assert_failure
}

@test "bl64_fmt_check_value_in_list: value is not ok, 3 values" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_check_value_in_list "$BL64_VAR_DEFAULT" 'X' 'VALUE1' 'VALUE2' 'VALUE3'
  assert_failure
}
