setup() {
  . "$DEVBL_TEST_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_merge_files: defaults, merge ok" {
  run bl64_fs_merge_files \
    "$BL64_LIB_DEFAULT" \
    "$BL64_LIB_DEFAULT" \
    "$BL64_LIB_DEFAULT" \
    "$BL64_LIB_DEFAULT" \
    "${TEST_SANDBOX}/merge_result.txt" \
    "${DEVBL_SAMPLES}/merge_files_01/file1.txt" \
    "${DEVBL_SAMPLES}/merge_files_01/file2.txt" \
    "${DEVBL_SAMPLES}/merge_files_01/file3.txt"
  assert_success
  assert_file_exist "${TEST_SANDBOX}/merge_result.txt"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
