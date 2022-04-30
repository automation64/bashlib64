setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_os_set_options: common sets are defined" {

  assert_not_equal "$BL64_OS_SET_MKDIR_VERBOSE" ''
  assert_not_equal "$BL64_OS_SET_CHOWN_VERBOSE" ''
  assert_not_equal "$BL64_OS_SET_CHOWN_RECURSIVE" ''
  assert_not_equal "$BL64_OS_SET_CP_VERBOSE" ''
  assert_not_equal "$BL64_OS_SET_CP_RECURSIVE" ''
  assert_not_equal "$BL64_OS_SET_CP_FORCE" ''
  assert_not_equal "$BL64_OS_SET_CHMOD_VERBOSE" ''
  assert_not_equal "$BL64_OS_SET_CHMOD_RECURSIVE" ''
  assert_not_equal "$BL64_OS_SET_MV_VERBOSE" ''
  assert_not_equal "$BL64_OS_SET_MV_FORCE" ''
  assert_not_equal "$BL64_OS_SET_RM_VERBOSE" ''
  assert_not_equal "$BL64_OS_SET_RM_FORCE" ''
  assert_not_equal "$BL64_OS_SET_RM_RECURSIVE" ''

}
