setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_rbac_add_root: no parameters" {
  run bl64_rbac_add_root
  assert_failure
}
