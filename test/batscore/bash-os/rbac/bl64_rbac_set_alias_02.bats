@test "_bl64_rbac_set_alias: common globals are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_not_equal "$BL64_RBAC_ALIAS_SUDO_ENV" ''

}
