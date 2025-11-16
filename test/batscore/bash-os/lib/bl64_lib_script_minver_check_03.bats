@test "bl64_lib_script_minver_check: is not less than - A" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='1.2.4'
  run bl64_lib_script_minver_check '1.2.3'
  assert_success
}

@test "bl64_lib_script_minver_check: is not less than - B" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='1.3.3'
  run bl64_lib_script_minver_check '1.2.3'
  assert_success
}

@test "bl64_lib_script_minver_check: is not less than - C" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='2.2.3'
  run bl64_lib_script_minver_check '1.2.3'
  assert_success
}

@test "bl64_lib_script_minver_check: is not less than - D" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='3.4.5'
  run bl64_lib_script_minver_check '2.3.4'
  assert_success
}