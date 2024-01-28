setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  export tempdir="$(bl64_fs_create_tmpdir)"
}

@test "bl64_fs_rm_tmpdir: command runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_rm_tmpdir "$tempdir"
  assert_dir_not_exist "$tempdir"
}

teardown() {
  if [[ -d "$tempdir" ]]; then
    rmdir "$tempdir"
  fi
}
