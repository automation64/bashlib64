setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fs_copy_files: missing parameter: all" {
  run bl64_fs_copy_files
  assert_failure
}

@test "bl64_fs_copy_files: missing parameter: 2nd and remaining" {
  run bl64_fs_copy_files '0700'
  assert_failure
}

@test "bl64_fs_copy_files: missing parameter: 3nd and remaining" {
  run bl64_fs_copy_files '0700' 'test'
  assert_failure
}

@test "bl64_fs_copy_files: missing parameter: 4nd and remaining" {
  run bl64_fs_copy_files '0700' 'test' 'test'
  assert_failure
}

@test "bl64_fs_copy_files: missing parameter: paths" {
  run bl64_fs_copy_files '0700' 'test' 'test' 'target'
  assert_failure
}
