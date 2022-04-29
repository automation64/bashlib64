setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fs_env: public constants are set" {
  assert_equal $BL64_FS_ERROR_MISSING_PARAMETER 50
  assert_equal $BL64_FS_ERROR_MERGE_FILE 51
}
