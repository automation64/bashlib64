setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_merge_dir: copy dir + complex file names + no subdirs" {
  source="$DEVBL_SAMPLES/dir_03"
  target="$TEST_SANDBOX/target"
  mkdir "$target"
  run bl64_fs_merge_dir "$source" "$target"
  assert_success
  assert_dir_exist "${target}"
  assert_file_exist "${target}/...random_03_05.txt"
  assert_file_exist "${target}/*random_03_14.txt"
  assert_file_exist "${target}/#random_03_09.txt"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
