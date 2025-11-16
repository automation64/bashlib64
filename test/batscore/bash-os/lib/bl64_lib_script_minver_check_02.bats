@test "bl64_lib_script_minver_check: is less than - A" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='1.2.3'
  run bl64_lib_script_minver_check '1.2.4'
  assert_failure
}

@test "bl64_lib_script_minver_check: is less than - B" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='1.2.3'
  run bl64_lib_script_minver_check '1.3.4'
  assert_failure
}

@test "bl64_lib_script_minver_check: is less than - C" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='1.2.3'
  run bl64_lib_script_minver_check '2.3.4'
  assert_failure
}

@test "bl64_lib_script_minver_check: is less than - D" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='1.2.5'
  run bl64_lib_script_minver_check '2.3.4'
  assert_failure
}

@test "bl64_lib_script_minver_check: is less than - E" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_VERSION='1.4.5'
  run bl64_lib_script_minver_check '2.3.4'
  assert_failure
}
