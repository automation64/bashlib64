@test "bl64_fs_file_copy: missing parameter: all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_copy
  assert_failure
}

@test "bl64_fs_file_copy: missing parameter: 2nd and remaining" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_copy '0700'
  assert_failure
}

@test "bl64_fs_file_copy: missing parameter: 3nd and remaining" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_copy '0700' 'test'
  assert_failure
}

@test "bl64_fs_file_copy: missing parameter: 4nd and remaining" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_copy '0700' 'test' 'test'
  assert_failure
}

@test "bl64_fs_file_copy: missing parameter: paths" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_copy '0700' 'test' 'test' '/tmp'
  assert_success
}
