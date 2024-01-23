@test "bl64_lib_flag_is_enabled: flag BL64_VAR_ON" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_flag_is_enabled "$BL64_VAR_ON"
  assert_success
}
@test "bl64_lib_flag_is_enabled: flag ON" {
  run bl64_lib_flag_is_enabled 'ON'
  assert_success
}
@test "bl64_lib_flag_is_enabled: flag On" {
  run bl64_lib_flag_is_enabled 'On'
  assert_success
}
@test "bl64_lib_flag_is_enabled: flag YES" {
  run bl64_lib_flag_is_enabled 'YES'
  assert_success
}
@test "bl64_lib_flag_is_enabled: flag Yes" {
  run bl64_lib_flag_is_enabled 'Yes'
  assert_success
}
@test "bl64_lib_flag_is_enabled: flag 1" {
  run bl64_lib_flag_is_enabled 'YES'
  assert_success
}
