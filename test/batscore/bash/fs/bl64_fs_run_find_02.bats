setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_run_find: change file owner" {
  run bl64_fs_run_find "${TEST_SANDBOX}" -type f
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

