@test "_bl64_rbac_set_options: common globals are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_rbac_setup
    assert_not_equal "$BL64_RBAC_SET_SUDO_QUIET" ''
    assert_not_equal "$BL64_RBAC_SET_SUDO_FILE" ''
    assert_not_equal "$BL64_RBAC_SET_SUDO_CHECK" ''
}
