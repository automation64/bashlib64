setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_rbac_set_alias: common globals are set" {

  assert_not_equal "$BL64_RBAC_ALIAS_SUDO_ENV" ''

}
