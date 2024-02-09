@test "bl64_pkg_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_setup
  assert_success
}
