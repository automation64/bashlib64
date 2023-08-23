setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_command_search_path: command is present, using full path" {

  run bl64_check_command_search_path "$BL64_FS_CMD_CP"
  assert_success

}

@test "bl64_check_command_search_path: command is not present, using full path" {

  run bl64_check_command_search_path '/fake/command'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_FILE_NOT_FOUND

}

@test "bl64_check_command_search_path: command is not present, no full path" {

  run bl64_check_command_search_path 'fake_command'
  assert_failure

}

@test "bl64_check_command_search_path: command is present, no full path" {

  run bl64_check_command_search_path 'cp'
  assert_success

}
