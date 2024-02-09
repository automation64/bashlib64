@test "bl64_check_overwrite: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_overwrite
  assert_failure

}
