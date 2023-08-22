setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_command_search_path: parameter is not present" {

  run bl64_check_command_search_path
  assert_failure

}
