setup() {
  . "$DEVBL_TEST_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_SOURCE="$DEVBL_SAMPLES"
  TEST_FILE='text_01.txt'
}

@test "bl64_fs_cp_file: copy file" {
  run bl64_fs_cp_file "${TEST_SOURCE}/${TEST_FILE}" "$TEST_SANDBOX"
  assert_success
  assert_file_exist "${TEST_SANDBOX}/${TEST_FILE}"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
