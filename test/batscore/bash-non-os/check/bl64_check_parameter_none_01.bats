@test "bl64_check_parameters_none: function parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_parameters_none
  assert_failure

}
