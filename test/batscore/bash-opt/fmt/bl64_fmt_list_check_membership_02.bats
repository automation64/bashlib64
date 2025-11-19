@test "bl64_fmt_list_check_membership: value is ok, 1 value" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_list_check_membership "$BL64_VAR_DEFAULT" 'VALUE1' 'VALUE1'
  assert_success
}

@test "bl64_fmt_list_check_membership: value is ok, 3 values" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_list_check_membership "$BL64_VAR_DEFAULT" 'VALUE1' 'VALUE1' 'VALUE2' 'VALUE3'
  assert_success
}

@test "bl64_fmt_list_check_membership: value is not ok, 1 value" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_list_check_membership "$BL64_VAR_DEFAULT" 'X' 'VALUE1'
  assert_failure
}

@test "bl64_fmt_list_check_membership: value is not ok, 3 values" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_list_check_membership "$BL64_VAR_DEFAULT" 'X' 'VALUE1' 'VALUE2' 'VALUE3'
  assert_failure
}
