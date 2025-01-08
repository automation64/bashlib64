setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
  TEST_FILE="${TEST_SANDBOX}/test_file"
}

@test "bl64_fs_file_remove: delete file - existing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  touch "${TEST_FILE}"
  run bl64_fs_file_remove "${TEST_FILE}"
  assert_success
  assert_file_not_exist "${TEST_FILE}"
}

@test "bl64_fs_file_remove: delete file - not existing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  touch "${TEST_FILE}"
  run bl64_fs_file_remove "${TEST_FILE}"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

