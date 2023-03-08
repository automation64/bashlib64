setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_run_ls: ls dir" {
  run bl64_fs_run_ls "$TEST_SANDBOX"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
