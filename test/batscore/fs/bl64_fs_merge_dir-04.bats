setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"

  source="$DEVBL_SAMPLES/dir_01"
  target="$TEST_SANDBOX/target"
  mkdir "$target"
}

@test "bl64_fs_merge_dir: missing source" {
  run bl64_fs_merge_dir
  assert_failure
}

@test "bl64_fs_merge_dir: missing target" {
  run bl64_fs_merge_dir
  assert_failure "$source"
}

@test "bl64_fs_merge_dir: missing source directory" {
  run bl64_fs_merge_dir
  assert_failure "/fake/dir" "$target"
}

@test "bl64_fs_merge_dir: missing target directory" {
  run bl64_fs_merge_dir
  assert_failure "$source" "/fake/dir"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
