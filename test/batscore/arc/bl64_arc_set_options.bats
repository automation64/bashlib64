setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_arc_set_options: common globals are set" {
  assert_not_equal "$BL64_ARC_SET_VERBOSE" ''
}
