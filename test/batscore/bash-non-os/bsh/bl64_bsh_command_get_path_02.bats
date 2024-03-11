@test "bl64_bsh_command_get_path: ok, relative" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_get_path 'ls'
  assert_success
}

@test "bl64_bsh_command_get_path: ok, full path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_get_path '/bin/bash'
  assert_success
}
