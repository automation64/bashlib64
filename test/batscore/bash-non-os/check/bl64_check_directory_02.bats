@test "bl64_check_directory: directory is present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_directory '/etc'
  assert_success

}

@test "bl64_check_directory: directory is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_directory '/fake/dir'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND

}
