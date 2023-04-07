setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_SANDBOX="$(temp_make)"
  TEST_FILE="${TEST_SANDBOX}/test_file"
}

@test "bl64_fs_run_chmod: change file owner" {
  touch "${TEST_FILE}"
  run bl64_fs_run_chmod '700' "${TEST_FILE}"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

