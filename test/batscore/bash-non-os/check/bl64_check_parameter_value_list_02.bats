setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_parameter_value_list: value is ok, 1 value" {
  export TEST='VALUE1'
  run bl64_check_parameter_value_list 'TEST' 'VALUE1'
  assert_success
}

@test "bl64_check_parameter_value_list: value is ok, 3 values" {
  export TEST='VALUE1'
  run bl64_check_parameter_value_list 'TEST' 'VALUE1' 'VALUE2' 'VALUE3'
  assert_success
}

@test "bl64_check_parameter_value_list: value is not ok, 1 value" {
  export TEST='VALUEX'
  run bl64_check_parameter_value_list 'TEST' 'VALUE1'
  assert_failure
}

@test "bl64_check_parameter_value_list: value is not ok, 3 values" {
  export TEST='VALUEX'
  run bl64_check_parameter_value_list 'TEST' 'VALUE1' 'VALUE2' 'VALUE3'
  assert_failure
}
