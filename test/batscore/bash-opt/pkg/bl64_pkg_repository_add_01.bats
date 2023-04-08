setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup
}

@test "bl64_pkg_repository_add: root privilege" {
  run bl64_pkg_repository_add
  assert_failure
}
