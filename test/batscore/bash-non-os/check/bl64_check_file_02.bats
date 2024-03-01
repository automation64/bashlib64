@test "bl64_check_file: file is present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_file "$BL64_FS_CMD_CP"
  assert_success

}

@test "bl64_check_file: file is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_file '/fake/file'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_FILE_NOT_FOUND

}

@test "bl64_check_file: file is not readable" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local test_file=''
  if bl64_os_is_distro 'MCOS'; then
    test_file='/etc/master.passwd'
  else
    test_file='/etc/shadow'
  fi
  run bl64_check_file "$test_file"
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_FILE_NOT_READ

}
