@test "bl64_rbac_add_root: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_add_root
  assert_failure
}
