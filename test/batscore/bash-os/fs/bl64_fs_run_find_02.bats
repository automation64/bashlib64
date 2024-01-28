setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_run_find: change file owner" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_find "${TEST_SANDBOX}" -type f
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

