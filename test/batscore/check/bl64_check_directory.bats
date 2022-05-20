setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_directory: directory is present" {

  run bl64_check_directory '/etc'
  assert_success

}

@test "bl64_check_directory: directory is not present" {

  run bl64_check_directory '/fake/dir'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND

}

@test "bl64_check_directory: directory parameter is not present" {

  run bl64_check_directory
  assert_failure

}
