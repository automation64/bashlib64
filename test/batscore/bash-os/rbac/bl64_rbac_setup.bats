@test "bl64_rbac_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rbac_setup
  assert_success
}
