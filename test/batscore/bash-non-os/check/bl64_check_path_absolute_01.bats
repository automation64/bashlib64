@test "bl64_check_path_absolute: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_absolute
  assert_failure

}

