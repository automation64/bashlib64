setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_check_file: file is present" {

  run bl64_check_file "$BL64_OS_CMD_CP"
  assert_success

}

@test "bl64_check_file: file is not present" {

  run bl64_check_file '/fake/file'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_FILE_NOT_FOUND

}

@test "bl64_check_file: file is not readable" {
  local test_file=''
  if bl64_os_match 'MCOS'; then
    test_file='/etc/master.passwd'
  else
    test_file='/etc/shadow'
  fi
  run bl64_check_file "$test_file"
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_FILE_NOT_READ

}

@test "bl64_check_file: file parameter is not present" {

  run bl64_check_file
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_MISSING_PARAMETER

}
