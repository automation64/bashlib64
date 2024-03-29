@test "bl64_check_parameter: parameter is present + numeric" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  test_parameter=1
  run bl64_check_parameter 'test_parameter' 'test_parameter'
  assert_success

}

@test "bl64_check_parameter: parameter is present + string" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  test_parameter='string with spaces'
  run bl64_check_parameter 'test_parameter' 'test_parameter'
  assert_success

}

@test "bl64_check_parameter: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_parameter 'fake_parameter'
  assert_failure

}

@test "bl64_check_parameter: parameter is default" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_PARAMETER="$BL64_VAR_DEFAULT"
  run bl64_check_parameter 'TEST_PARAMETER'
  assert_failure

}

@test "bl64_check_parameter: parameter is null" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_PARAMETER="$BL64_VAR_NULL"
  run bl64_check_parameter 'TEST_PARAMETER'
  assert_failure

}
