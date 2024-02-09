@test "bl64_fs_create_tmpdir: command runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export tempdir="$(bl64_fs_create_tmpdir)"
  assert_dir_exist "$tempdir"
}

teardown() {
  if [[ -d "$tempdir" ]]; then
    rmdir "$tempdir"
  fi
}
