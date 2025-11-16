@test "bl64_lib_script_minver_check: are equal" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='1.2.4'
  run bl64_lib_script_minver_check '1.2.4'
  assert_success
}
