setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_rbac_add_root: root privilege" {
  run bl64_rbac_add_root
  assert_failure
}
