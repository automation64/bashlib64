@test "_bl64_arc_set_options: common globals are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_arc_setup
  assert_not_equal "$BL64_ARC_SET_TAR_VERBOSE" ''

  assert_not_equal "$BL64_ARC_SET_UNZIP_OVERWRITE" ''
}
