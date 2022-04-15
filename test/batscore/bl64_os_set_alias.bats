setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_os_set_alias: common globals are set" {

  assert_not_equal "$BL64_OS_ALIAS_AWK" ''
  assert_not_equal "$BL64_OS_ALIAS_CHOWN_DIR" ''
  assert_not_equal "$BL64_OS_ALIAS_CP_DIR" ''
  assert_not_equal "$BL64_OS_ALIAS_CP_FILE" ''
  assert_not_equal "$BL64_OS_ALIAS_ID_USER" ''
  assert_not_equal "$BL64_OS_ALIAS_LN_SYMBOLIC" ''
  assert_not_equal "$BL64_OS_ALIAS_LS_FILES" ''
  assert_not_equal "$BL64_OS_ALIAS_MKDIR_FULL" ''
  assert_not_equal "$BL64_OS_ALIAS_MKTEMP_DIR" ''
  assert_not_equal "$BL64_OS_ALIAS_MKTEMP_FILE" ''
  assert_not_equal "$BL64_OS_ALIAS_MV" ''
  assert_not_equal "$BL64_OS_ALIAS_RM_FILE" ''
  assert_not_equal "$BL64_OS_ALIAS_RM_FULL" ''

}

@test "bl64_os_set_alias: common sets are defined" {

  assert_not_equal "$BL64_OS_SET_MKDIR_VERBOSE" ''

}
