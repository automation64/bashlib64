@test "bl64_fmt_list_check_membership: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_list_check_membership
  assert_failure
}

@test "bl64_fmt_list_check_membership: default, parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_list_check_membership "$BL64_VAR_DEFAULT"
  assert_failure
}

@test "bl64_fmt_list_check_membership: list is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export TEST='XX'
  run bl64_fmt_list_check_membership "$BL64_VAR_DEFAULT" 'TEST'
  assert_failure
}
