setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_rbac_setup: module setup" {
  run bl64_rbac_setup
  assert_success
}
