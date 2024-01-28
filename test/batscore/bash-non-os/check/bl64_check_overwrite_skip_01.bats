@test "bl64_check_overwrite_skip: exist, overwrite on" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_check_overwrite_skip /etc/hosts "$BL64_VAR_ON"
  assert_failure
}

@test "bl64_check_overwrite_skip: not exist, overwrite on" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_check_overwrite_skip /fake/file "$BL64_VAR_ON"
  assert_failure
}

@test "bl64_check_overwrite_skip: exist, overwrite off" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_check_overwrite_skip /etc/hosts "$BL64_VAR_OFF"
  assert_success
}

@test "bl64_check_overwrite_skip: not exist, overwrite off" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_check_overwrite_skip /fake/file "$BL64_VAR_OFF"
  assert_failure
}
