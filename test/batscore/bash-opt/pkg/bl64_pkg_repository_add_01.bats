@test "bl64_pkg_repository_add: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup
  run bl64_pkg_repository_add
  assert_failure
}
