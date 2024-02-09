@test "bl64_fs_check_new_file: file not present, ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_check_new_file '/tmp/new_file'
  assert_success
}

@test "bl64_fs_check_new_file: file not present, not ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_check_new_file '/tmp'
  assert_failure
}

@test "bl64_fs_check_new_file: file present, ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_check_new_file '/etc/hosts'
  assert_success
}

@test "bl64_fs_check_new_file: file present, not ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_check_new_file '/etc'
  assert_failure
}
