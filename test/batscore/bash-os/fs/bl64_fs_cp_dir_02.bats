setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_cp_dir: copy dir" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  source="${TEST_SANDBOX}/source"
  dest="${TEST_SANDBOX}/dest"
  mkdir "$source" &&
  mkdir "$dest" &&
  ls /etc > "$source/file"
  run bl64_fs_cp_dir "$source" "$dest"
  assert_success
  assert_dir_exist "${dest}/source"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
