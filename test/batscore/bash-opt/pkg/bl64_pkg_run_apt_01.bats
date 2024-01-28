@test "bl64_pkg_run_apt: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_apt
  assert_failure
}
