@test "bl64_fmt_check_value_in_list: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_check_value_in_list
  assert_failure
}

@test "bl64_fmt_check_value_in_list: default, parameter is not present" {
  run bl64_fmt_check_value_in_list "$BL64_VAR_DEFAULT"
  assert_failure
}

@test "bl64_fmt_check_value_in_list: list is not present" {
  export TEST='XX'
  run bl64_fmt_check_value_in_list "$BL64_VAR_DEFAULT" 'TEST'
  assert_failure
}
