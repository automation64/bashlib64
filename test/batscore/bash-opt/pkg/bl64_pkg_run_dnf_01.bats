@test "bl64_pkg_run_dnf: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_dnf
  assert_failure
}
