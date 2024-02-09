setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_run_ls: ls dir" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_ls "$TEST_SANDBOX"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
