@test "bl64_check_path: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path
  assert_failure

}

