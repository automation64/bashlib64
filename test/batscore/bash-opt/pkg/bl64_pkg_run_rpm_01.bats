@test "bl64_pkg_run_rpm: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_rpm
  assert_failure
}
