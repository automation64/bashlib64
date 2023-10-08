setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_parameter_value_list: parameter is not present" {
  run bl64_check_parameter_value_list
  assert_failure
}

@test "bl64_check_parameter_value_list: list is not present" {
  export TEST='XX'
  run bl64_check_parameter_value_list 'TEST'
  assert_failure
}
