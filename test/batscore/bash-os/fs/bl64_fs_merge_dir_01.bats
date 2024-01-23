setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_merge_dir: copy dir + simple file names content + no subdirs" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  source="$TESTMANSH_TEST_SAMPLES/dir_01"
  target="$TEST_SANDBOX/target"
  mkdir "$target"
  run bl64_fs_merge_dir "$source" "$target"
  assert_success
  assert_dir_exist "${target}"
  assert_file_exist "${target}/random_01_02.txt"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
