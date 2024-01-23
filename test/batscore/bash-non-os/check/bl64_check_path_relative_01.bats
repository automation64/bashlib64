@test "bl64_check_path_relative: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_relative
  assert_failure

}
