setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
  TEST_FILE="${TEST_SANDBOX}/test_file"
  TEST_NEW_FILE="${TEST_SANDBOX}/test_new_file"
}

@test "bl64_fs_path_move: move a file to another dir" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  touch "${TEST_FILE}"
  run bl64_fs_path_move "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "${TEST_FILE}" "$TEST_NEW_FILE"
  assert_success
  assert_file_exist "$TEST_NEW_FILE"
  assert_file_not_exist "$TEST_FILE"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
