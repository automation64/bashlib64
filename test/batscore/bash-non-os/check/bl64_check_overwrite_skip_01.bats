setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_overwrite_skip: exist, overwrite on" {
  run bl64_check_overwrite_skip /etc/hosts "$BL64_VAR_ON"
  assert_failure
}

@test "bl64_check_overwrite_skip: not exist, overwrite on" {
  run bl64_check_overwrite_skip /fake/file "$BL64_VAR_ON"
  assert_failure
}

@test "bl64_check_overwrite_skip: exist, overwrite off" {
  run bl64_check_overwrite_skip /etc/hosts "$BL64_VAR_OFF"
  assert_success
}

@test "bl64_check_overwrite_skip: not exist, overwrite off" {
  run bl64_check_overwrite_skip /fake/file "$BL64_VAR_OFF"
  assert_failure
}
