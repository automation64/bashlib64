setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_overwrite: exist, overwrite on" {
  run bl64_check_overwrite /etc/hosts "$BL64_VAR_ON"
  assert_success
}

@test "bl64_check_overwrite: not exist, overwrite on" {
  run bl64_check_overwrite /fake/file "$BL64_VAR_ON"
  assert_success
}

@test "bl64_check_overwrite: exist, overwrite off" {
  run bl64_check_overwrite /etc/hosts "$BL64_VAR_OFF"
  assert_failure
}

@test "bl64_check_overwrite: not exist, overwrite off" {
  run bl64_check_overwrite /fake/file "$BL64_VAR_OFF"
  assert_success
}
