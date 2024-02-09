@test "_bl64_rxtx_set_alias: aliases are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_not_equal "$BL64_RXTX_ALIAS_CURL" ''
  assert_not_equal "$BL64_RXTX_ALIAS_WGET" ''

}
