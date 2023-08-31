setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_home: run ok" {
  run bl64_check_home
  assert_success
}

@test "bl64_check_home: run not ok" {
  unset HOME
  run bl64_check_home
  assert_failure
}
