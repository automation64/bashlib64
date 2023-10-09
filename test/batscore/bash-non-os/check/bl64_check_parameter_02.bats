setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_parameter: parameter is present + numeric" {

  test_parameter=1
  run bl64_check_parameter 'test_parameter' 'test_parameter'
  assert_success

}

@test "bl64_check_parameter: parameter is present + string" {

  test_parameter='string with spaces'
  run bl64_check_parameter 'test_parameter' 'test_parameter'
  assert_success

}

@test "bl64_check_parameter: parameter is not present" {

  run bl64_check_parameter 'fake_parameter'
  assert_failure

}

@test "bl64_check_parameter: parameter is default" {

  TEST_PARAMETER="$BL64_VAR_DEFAULT"
  run bl64_check_parameter 'TEST_PARAMETER'
  assert_failure

}

@test "bl64_check_parameter: parameter is null" {

  TEST_PARAMETER="$BL64_VAR_NULL"
  run bl64_check_parameter 'TEST_PARAMETER'
  assert_failure

}
