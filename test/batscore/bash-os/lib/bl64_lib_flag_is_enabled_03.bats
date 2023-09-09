setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_flag_is_enabled: flag missing" {
  run bl64_lib_flag_is_enabled
  assert_failure
}
