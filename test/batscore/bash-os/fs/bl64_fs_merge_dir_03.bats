setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_merge_dir: copy dir + dot names + subdirs" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  source="$TESTMANSH_TEST_SAMPLES/dir_02"
  target="$TEST_SANDBOX/target"
  mkdir "$target"
  run bl64_fs_merge_dir "$source" "$target"
  assert_success
  assert_dir_exist "${target}/.dir_02_03"
  assert_file_exist "${target}/.dir_02_03/random_02_03_01.txt"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
