@test "bl64_lib_lang_is_enabled: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_lang_is_enabled
  assert_success
}

@test "bl64_lib_mode_command_is_enabled: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_mode_command_is_enabled
  assert_failure
}

@test "bl64_lib_mode_compability_is_enabled: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_mode_compability_is_enabled
  # WARNING: this is disabled at the test lib
  assert_failure
}

@test "bl64_lib_mode_strict_is_enabled: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_mode_strict_is_enabled
  assert_success
}

@test "bl64_lib_trap_is_enabled: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_trap_is_enabled
  # WARNING: this is disabled at the test lib
  assert_failure
}
