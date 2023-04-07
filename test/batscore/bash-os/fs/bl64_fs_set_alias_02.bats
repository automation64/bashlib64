setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "_bl64_fs_set_alias: common globals are set" {

  assert_not_equal "$BL64_FS_ALIAS_CHOWN_DIR" ''
  assert_not_equal "$BL64_FS_ALIAS_CP_DIR" ''
  assert_not_equal "$BL64_FS_ALIAS_CP_FILE" ''
  assert_not_equal "$BL64_FS_ALIAS_LN_SYMBOLIC" ''
  assert_not_equal "$BL64_FS_ALIAS_LS_FILES" ''
  assert_not_equal "$BL64_FS_ALIAS_MKDIR_FULL" ''
  assert_not_equal "$BL64_FS_ALIAS_MKTEMP_DIR" ''
  assert_not_equal "$BL64_FS_ALIAS_MKTEMP_FILE" ''
  assert_not_equal "$BL64_FS_ALIAS_MV" ''
  assert_not_equal "$BL64_FS_ALIAS_RM_FILE" ''
  assert_not_equal "$BL64_FS_ALIAS_RM_FULL" ''

}
