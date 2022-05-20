setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_pkg_set_options: common globals are set" {
    assert_not_equal "$BL64_PKG_SET_ASSUME_YES" ''
    assert_not_equal "$BL64_PKG_SET_QUIET" ''
    assert_not_equal "$BL64_PKG_SET_SLIM" ''
    assert_not_equal "$BL64_PKG_SET_VERBOSE" ''
}
