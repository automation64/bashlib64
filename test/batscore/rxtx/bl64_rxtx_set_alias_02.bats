setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_rxtx_set_alias: aliases are set" {

  assert_not_equal "$BL64_RXTX_ALIAS_CURL" ''
  assert_not_equal "$BL64_RXTX_ALIAS_WGET" ''

}
