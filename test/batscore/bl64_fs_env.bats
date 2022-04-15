setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_fs_env: public constants are set" {
  assert_equal $BL64_FS_ERROR_MISSING_PARAMETER 50
  assert_equal $BL64_FS_ERROR_MERGE_FILE 51
}
