@test "bl64_pkg_run_brew: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_brew
  assert_failure
}
