setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_lang_is_enabled: run function" {
  run bl64_lib_lang_is_enabled
  assert_success
}

@test "bl64_lib_mode_command_is_enabled: run function" {
  run bl64_lib_mode_command_is_enabled
  assert_failure
}

@test "bl64_lib_mode_compability_is_enabled: run function" {
  run bl64_lib_mode_compability_is_enabled
  assert_success
}

@test "bl64_lib_mode_strict_is_enabled: run function" {
  run bl64_lib_mode_strict_is_enabled
  assert_success
}

@test "bl64_lib_trap_is_enabled: run function" {
  run bl64_lib_trap_is_enabled
  # WARNING: this is disable by the test lib for batscore compatibility
  assert_failure
}
