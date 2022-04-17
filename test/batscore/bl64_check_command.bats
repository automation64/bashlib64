setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_check_command: command is present" {

  run bl64_check_command "$BL64_OS_CMD_CP"
  assert_success

}

@test "bl64_check_command: command is not present" {

  run bl64_check_command '/fake/command'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_FILE_NOT_FOUND

}

@test "bl64_check_command: command is not executable" {

  run bl64_check_command '/etc/hosts'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_FILE_NOT_EXECUTE

}

@test "bl64_check_command: command parameter is not present" {

  run bl64_check_command
  assert_failure

}
