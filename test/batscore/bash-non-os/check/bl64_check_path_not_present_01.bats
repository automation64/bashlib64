@test "bl64_check_path_not_present: parameter not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_not_present
  assert_failure

}
