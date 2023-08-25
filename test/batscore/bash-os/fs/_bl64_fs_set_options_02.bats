setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "_bl64_fs_set_options: common sets are defined" {

    assert_not_equal "$BL64_FS_SET_CHMOD_RECURSIVE" ''
    assert_not_equal "$BL64_FS_SET_CHMOD_VERBOSE" ''
    assert_not_equal "$BL64_FS_SET_CHOWN_RECURSIVE" ''
    assert_not_equal "$BL64_FS_SET_CHOWN_VERBOSE" ''
    assert_not_equal "$BL64_FS_SET_CP_FORCE" ''
    assert_not_equal "$BL64_FS_SET_CP_RECURSIVE" ''
    assert_not_equal "$BL64_FS_SET_CP_VERBOSE" ''
    assert_not_equal "$BL64_FS_SET_FIND_NAME" ''
    assert_not_equal "$BL64_FS_SET_FIND_PRINT" ''
    assert_not_equal "$BL64_FS_SET_FIND_RUN" ''
    assert_not_equal "$BL64_FS_SET_FIND_STAY" ''
    assert_not_equal "$BL64_FS_SET_FIND_TYPE_DIR" ''
    assert_not_equal "$BL64_FS_SET_FIND_TYPE_FILE" ''
    assert_not_equal "$BL64_FS_SET_LN_SYMBOLIC" ''
    assert_not_equal "$BL64_FS_SET_LN_VERBOSE" ''
    assert_not_equal "$BL64_FS_SET_MKDIR_PARENTS" ''
    assert_not_equal "$BL64_FS_SET_MKDIR_VERBOSE" ''
    assert_not_equal "$BL64_FS_SET_MV_FORCE" ''
    assert_not_equal "$BL64_FS_SET_MV_VERBOSE" ''
    assert_not_equal "$BL64_FS_SET_RM_FORCE" ''
    assert_not_equal "$BL64_FS_SET_RM_RECURSIVE" ''
    assert_not_equal "$BL64_FS_SET_RM_VERBOSE" ''

}
