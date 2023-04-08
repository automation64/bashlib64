setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_parameters_none: function parameter is not present" {

  run bl64_check_parameters_none
  assert_failure

}
