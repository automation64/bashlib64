setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup

}

@test "bl64_pkg_run_apt: parameters are not present" {
  run bl64_pkg_run_apt
  assert_failure
}
