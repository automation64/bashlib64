setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_os_set_alias: common globals are set" {

  assert_not_equal "$BL64_OS_ALIAS_AWK" ''
  assert_not_equal "$BL64_OS_ALIAS_ID_USER" ''

}
