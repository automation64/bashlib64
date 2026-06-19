@test "bl64_lib_script_version_set: missing args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_lib_script_version_set
  assert_failure
}
