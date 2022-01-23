setup() {
  BL64_LIB_STRICT=0
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_check_file: file is present" {

  run bl64_check_file "$BL64_OS_CMD_CP"
  assert_success

}

@test "bl64_check_file: file is not present" {

  run bl64_check_file '/fake/file'
  assert_equal "$status" $BL64_CHECK_ERROR_FILE_NOT_FOUND && \
  [[ "$output" == *${_BL64_CHECK_TXT_FILE_NOT_FOUND}* ]]

}

@test "bl64_check_file: file is not readable" {

  run bl64_check_file '/etc/shadow'
  assert_equal "$status" $BL64_CHECK_ERROR_FILE_NOT_READ && \
  [[ "$output" == *${_BL64_CHECK_TXT_FILE_NOT_EXECUTABLE}* ]]

}

@test "bl64_check_file: file parameter is not present" {

  run bl64_check_file
  assert_equal "$status" $BL64_CHECK_ERROR_MISSING_PARAMETER && \
  [[ "$output" == *${_BL64_CHECK_TXT_MISSING_PARAMETER}* ]]

}
