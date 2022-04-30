setup() {
  . "$DEVBL_TEST_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_merge_dir: copy dir + file names with spaces + subdirs" {
  source="$DEVBL_SAMPLES/dir_04"
  target="$TEST_SANDBOX/target"
  mkdir "$target"
  run bl64_fs_merge_dir "$source" "$target"
  assert_success
  assert_dir_exist "${target}/dir with spaces/"
  assert_file_exist "${target}/dir with spaces/random_04_01.txt"
  assert_file_exist "${target}/file with spaces.txt"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
