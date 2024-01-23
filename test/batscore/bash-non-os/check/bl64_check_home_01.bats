@test "bl64_check_home: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_check_home
  assert_success
}

@test "bl64_check_home: run not ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset HOME
  run bl64_check_home
  assert_failure
}
