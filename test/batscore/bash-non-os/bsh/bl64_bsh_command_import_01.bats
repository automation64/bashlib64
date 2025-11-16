@test "bl64_bsh_command_import: no arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_import
  assert_failure
}
