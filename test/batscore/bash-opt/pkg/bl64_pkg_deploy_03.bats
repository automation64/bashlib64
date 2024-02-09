@test "bl64_pkg_deploy: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup
  run bl64_pkg_deploy
  assert_failure
}
