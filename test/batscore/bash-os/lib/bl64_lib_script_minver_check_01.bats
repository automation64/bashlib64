@test "bl64_lib_script_minver_check: missing 1 arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_lib_script_minver_check
  assert_failure
}
