@test "bl64_pkg_run_dnf: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_dnf
  assert_failure
}
