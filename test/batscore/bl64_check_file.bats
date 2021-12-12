setup() {
  BL64_LIB_STRICT=0
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "bl64_check_file: file is present" {

  run bl64_check_file "$BL64_OS_CMD_CP"
  [[ "$status" == 0 ]]

}

@test "bl64_check_file: file is not present" {

  run bl64_check_file '/fake/file'
  [[ "$status" == $BL64_CHECK_ERROR_FILE_NOT_FOUND ]]
  [[ "$output" == *${_BL64_CHECK_TXT_file_NOT_FOUND}* ]]

}

@test "bl64_check_file: file is not readable" {

  run bl64_check_file '/etc/shadow'
  [[ "$status" == $BL64_CHECK_ERROR_FILE_NOT_READ ]]
  [[ "$output" == *${_BL64_CHECK_TXT_file_NOT_EXECUTABLE}* ]]

}

@test "bl64_check_file: file parameter is not present" {

  run bl64_check_file
  [[ "$status" == $BL64_CHECK_ERROR_MISSING_PARAMETER ]]
  [[ "$output" == *${_BL64_CHECK_TXT_MISSING_PARAMETER}* ]]

}
