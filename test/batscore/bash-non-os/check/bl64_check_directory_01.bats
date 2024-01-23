@test "bl64_check_directory: directory parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_directory
  assert_failure

}
