@test "bl64_check_file: file parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_file
  assert_failure

}
