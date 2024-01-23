@test "bl64_lib_flag_is_enabled: flag BL64_VAR_OFF" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_flag_is_enabled "$BL64_VAR_OFF"
  assert_failure
}
@test "bl64_lib_flag_is_enabled: flag OFF" {
  run bl64_lib_flag_is_enabled 'OFF'
  assert_failure
}
@test "bl64_lib_flag_is_enabled: flag NO" {
  run bl64_lib_flag_is_enabled 'NO'
  assert_failure
}
@test "bl64_lib_flag_is_enabled: flag 0" {
  run bl64_lib_flag_is_enabled '0'
  assert_failure
}
@test "bl64_lib_flag_is_enabled: flag ANYOTHERVALUE" {
  run bl64_lib_flag_is_enabled 'ANYOTHERVALUE'
  assert_failure
}

