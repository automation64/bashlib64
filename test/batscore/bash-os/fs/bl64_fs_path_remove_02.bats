setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
  TEST_FILE="${TEST_SANDBOX}/test_file"
  TEST_DIR="${TEST_SANDBOX}/test_dir"
  mkdir "${TEST_DIR}"
  touch "$TEST_FILE"
}

@test "bl64_fs_path_remove: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_remove "$TEST_DIR" "$TEST_FILE"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
