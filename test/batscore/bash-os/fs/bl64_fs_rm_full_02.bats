setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_SANDBOX="$(temp_make)"
  TEST_DIR="${TEST_SANDBOX}/test_dir"
}

@test "bl64_fs_rm_full: delete dir" {
  mkdir "${TEST_DIR}"
  run bl64_fs_rm_full "${TEST_DIR}"
  assert_success
  assert_dir_not_exist "${TEST_DIR}"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
