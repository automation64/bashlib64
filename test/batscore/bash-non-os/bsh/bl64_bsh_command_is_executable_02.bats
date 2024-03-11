@test "bl64_bsh_command_is_executable: relative path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_is_executable 'ls'
  assert_success
}

@test "bl64_bsh_command_is_executable: full path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_is_executable '/bin/bash'
  assert_success
}
