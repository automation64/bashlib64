setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_create_dir: missing parameter: all" {
  run bl64_fs_create_dir
  assert_failure
}

@test "bl64_fs_create_dir: missing parameter: 2nd and remaining" {
  run bl64_fs_create_dir '0700'
  assert_failure
}

@test "bl64_fs_create_dir: missing parameter: 3nd and remaining" {
  run bl64_fs_create_dir '0700' 'test'
  assert_failure
}

@test "bl64_fs_create_dir: missing parameter: paths" {
  run bl64_fs_create_dir '0700' 'test' 'test'
  assert_failure
}
