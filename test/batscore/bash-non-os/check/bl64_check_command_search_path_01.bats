@test "bl64_check_command_search_path: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_command_search_path
  assert_failure

}
