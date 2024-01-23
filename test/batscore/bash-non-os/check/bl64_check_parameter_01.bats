@test "bl64_check_parameter: function parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_parameter
  assert_failure

}
