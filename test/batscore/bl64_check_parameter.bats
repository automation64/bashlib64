setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_check_parameter: parameter is present" {

  test_parameter=1
  run bl64_check_parameter 'test_parameter' 'test_parameter'
  assert_success

}

@test "bl64_check_parameter: parameter is not present" {

  run bl64_check_parameter 'fake_parameter'
  assert_equal "$status" $BL64_CHECK_ERROR_PARAMETER_EMPTY
  assert_output --partial "${_BL64_CHECK_TXT_MISSING_PARAMETER}"

}

@test "bl64_check_parameter: function parameter is not present" {

  run bl64_check_parameter
  assert_equal "$status" $BL64_CHECK_ERROR_MISSING_PARAMETER
  assert_output --partial "${_BL64_CHECK_TXT_MISSING_PARAMETER}"

}
