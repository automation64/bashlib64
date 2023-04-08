setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_SANDBOX="$(temp_make)"
  TEST_SOURCE="$TESTMANSH_TEST_SAMPLES"
  TEST_FILE='text_01.txt'
}

@test "bl64_fs_run_cp: copy a file to another dir" {
  run bl64_fs_run_cp "${TEST_SOURCE}/${TEST_FILE}" "$TEST_SANDBOX"
  assert_success
  assert_file_exist "${TEST_SANDBOX}/${TEST_FILE}"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}