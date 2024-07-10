@test "bl64_fs_dir_create: missing parameter: all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_dir_create
  assert_failure
}

@test "bl64_fs_dir_create: missing parameter: 2nd and remaining" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_dir_create '0700'
  assert_failure
}

@test "bl64_fs_dir_create: missing parameter: 3nd and remaining" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_dir_create '0700' 'test'
  assert_failure
}

@test "bl64_fs_dir_create: missing parameter: paths" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_dir_create '0700' 'test' 'test'
  assert_failure
}
