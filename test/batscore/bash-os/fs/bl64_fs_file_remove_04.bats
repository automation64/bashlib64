setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_file_remove: wrong file type - dir" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_remove "${TEST_SANDBOX}"
  assert_failure
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

