setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_pkg_repository_add: no args" {
  run bl64_pkg_repository_add
  assert_failure
}
