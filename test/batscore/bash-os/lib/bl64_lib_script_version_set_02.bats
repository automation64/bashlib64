@test "bl64_lib_script_version_set: set version" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_lib_script_version_set 2.3.4
  assert_success
}
