@test "bl64_bsh_command_locate_user: no arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate_user
  assert_failure
}
