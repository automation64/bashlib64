setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_rbac_check_sudoers: no parameters" {
  run bl64_rbac_check_sudoers
  assert_failure
}
