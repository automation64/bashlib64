setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
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
  assert_equal "$status" $BL64_CHECK_ERROR_PARAMETER_EMPTY

}

@test "bl64_check_parameter: parameter is not present + using default value" {

  TEST_PARAMETER="$BL64_LIB_VAR_TBD"
  run bl64_check_parameter 'TEST_PARAMETER'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_PARAMETER_EMPTY

}

@test "bl64_check_parameter: function parameter is not present" {

  run bl64_check_parameter
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_MISSING_PARAMETER

}
