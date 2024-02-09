@test "bl64_check_module: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_module
  assert_failure

}

