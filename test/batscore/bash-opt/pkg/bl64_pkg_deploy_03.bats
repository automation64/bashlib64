setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_pkg_deploy: parameters are not present" {
  bl64_pkg_setup
  run bl64_pkg_deploy
  assert_failure
}
