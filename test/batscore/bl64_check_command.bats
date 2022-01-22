setup() {
  BL64_LIB_STRICT=0
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_check_command: command is present" {

  run bl64_check_command "$BL64_OS_CMD_CP"
  assert_success

}

@test "bl64_check_command: command is not present" {

  run bl64_check_command '/fake/command'
  assert_equal "$status" $BL64_CHECK_ERROR_FILE_NOT_FOUND ]] && \
  assert_output --partial "${_BL64_CHECK_TXT_COMMAND_NOT_FOUND}"

}

@test "bl64_check_command: command is not executable" {

  run bl64_check_command '/etc/hosts'
  assert_equal "$status" $BL64_CHECK_ERROR_FILE_NOT_EXECUTE ]] && \
  assert_output --partial "${_BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE}"

}

@test "bl64_check_command: command parameter is not present" {

  run bl64_check_command
  assert_equal "$status" $BL64_CHECK_ERROR_MISSING_PARAMETER ]] && \
  assert_output --partial "${_BL64_CHECK_TXT_MISSING_PARAMETER}"

}
