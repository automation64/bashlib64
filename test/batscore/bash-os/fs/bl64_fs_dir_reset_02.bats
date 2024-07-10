setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
  TEST_DIR="${TEST_SANDBOX}/test_dir"
}

@test "bl64_fs_dir_reset: recreate dir" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  mkdir "${TEST_DIR}"
  run bl64_fs_dir_reset '0777' "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "${TEST_DIR}"
  assert_success
  assert_dir_exist "${TEST_DIR}"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
