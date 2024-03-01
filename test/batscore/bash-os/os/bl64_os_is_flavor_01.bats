@test "bl64_os_is_flavor: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_is_flavor
  assert_failure
}
