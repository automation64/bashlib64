setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"

  source="$TESTMANSH_TEST_SAMPLES/dir_01"
  target="$TEST_SANDBOX/target"
  mkdir "$target"
}

@test "bl64_fs_path_merge: missing source" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_merge
  assert_failure
}

@test "bl64_fs_path_merge: missing target" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_merge
  assert_failure "$source"
}

@test "bl64_fs_path_merge: missing source directory" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_merge
  assert_failure "/fake/dir" "$target"
}

@test "bl64_fs_path_merge: missing target directory" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_merge
  assert_failure "$source" "/fake/dir"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
