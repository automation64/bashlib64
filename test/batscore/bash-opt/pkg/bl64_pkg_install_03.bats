@test "bl64_pkg_install: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup
  run bl64_pkg_install
  assert_failure
}