setup() {
  BL64_LIB_STRICT=0
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "command is present" {

  run bl64_check_command "$BL64_OS_CMD_CP"
  [[ "$status" == 0 ]]

}

@test "command is not present" {

  run bl64_check_command '/fake/command'
  [[ "$status" == $BL64_CHECK_ERROR_FILE_NOT_FOUND ]]
  [[ "$output" == *${_BL64_CHECK_TXT_COMMAND_NOT_FOUND}* ]]

}

@test "command is not executable" {

  run bl64_check_command '/etc/hosts'
  [[ "$status" == $BL64_CHECK_ERROR_FILE_NOT_EXECUTE ]]
  [[ "$output" == *${_BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE}* ]]

}

@test "command parameter is not present" {

  run bl64_check_command
  [[ "$status" == $BL64_CHECK_ERROR_MISSING_PARAMETER ]]
  [[ "$output" == *${_BL64_CHECK_TXT_MISSING_PARAMETER}* ]]

}
