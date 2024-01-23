@test "_bl64_pkg_set_options: common globals are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup
  assert_not_equal "$BL64_PKG_SET_ASSUME_YES" ''
  assert_not_equal "$BL64_PKG_SET_QUIET" ''
  assert_not_equal "$BL64_PKG_SET_SLIM" ''
  assert_not_equal "$BL64_PKG_SET_VERBOSE" ''
}
