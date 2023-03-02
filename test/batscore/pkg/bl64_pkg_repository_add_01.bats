setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup

}

@test "bl64_pkg_repository_add: parameters are not present" {
  run bl64_pkg_repository_add
  assert_failure
}

@test "bl64_pkg_repository_add: 2nd parameter is not present" {
  run bl64_pkg_repository_add '/dev/null'
  assert_failure
}