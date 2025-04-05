@test "bl64_os_check_flavor: no params" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_os_check_flavor
  assert_failure
}
