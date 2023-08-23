setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export tempdir="$(bl64_fs_create_tmpdir)"
}

@test "bl64_fs_rm_tmpdir: command runs ok" {
  run bl64_fs_rm_tmpdir "$tempdir"
  assert_dir_not_exist "$tempdir"
}

teardown() {
  if [[ -d "$tempdir" ]]; then
    rmdir "$tempdir"
  fi
}
