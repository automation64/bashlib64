@test "bl64_pkg_run_yum: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_yum
  assert_failure
}
