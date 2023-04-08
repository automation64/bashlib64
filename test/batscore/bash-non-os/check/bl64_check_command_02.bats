setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_command: command is present" {

  run bl64_check_command "$BL64_FS_CMD_CP"
  assert_success

}

@test "bl64_check_command: command is not present" {

  run bl64_check_command '/fake/command'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_FILE_NOT_FOUND

}

@test "bl64_check_command: command is not executable" {

  run bl64_check_command '/etc/hosts'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_FILE_NOT_EXECUTE

}

@test "bl64_check_command: parameter is not present" {

  run bl64_check_command
  assert_failure

}
