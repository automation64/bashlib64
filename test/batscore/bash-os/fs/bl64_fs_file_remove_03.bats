setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
  TEST_FILE="${TEST_SANDBOX}/test_file"
}

@test "bl64_fs_file_remove: delete file - link" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  touch "${TEST_FILE}"
  ln -s "${TEST_FILE}" "${TEST_FILE}-link"
  run bl64_fs_file_remove "${TEST_FILE}-link"
  assert_success
  assert_file_not_exist "${TEST_FILE}-link"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

