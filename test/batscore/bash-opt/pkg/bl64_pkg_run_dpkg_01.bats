@test "bl64_pkg_run_dpkg: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_dpkg
  assert_failure
}
