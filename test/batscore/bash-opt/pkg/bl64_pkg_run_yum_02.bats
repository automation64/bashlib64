@test "bl64_pkg_run_yum: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_yum
  assert_failure
}
