@test "bl64_rbac_check_sudoers: no parameters" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_check_sudoers
  assert_failure
}
