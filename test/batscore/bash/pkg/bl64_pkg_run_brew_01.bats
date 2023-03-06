setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup
}

@test "bl64_pkg_run_brew: parameters are not present" {
  run bl64_pkg_run_brew
  assert_failure
}
