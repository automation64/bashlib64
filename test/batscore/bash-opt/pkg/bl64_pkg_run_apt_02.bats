@test "bl64_pkg_run_apt: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_apt
  assert_failure
}
