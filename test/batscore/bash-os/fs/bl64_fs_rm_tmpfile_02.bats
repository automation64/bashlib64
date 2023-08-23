setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export tempfile="$(bl64_fs_create_tmpfile)"
}

@test "bl64_fs_rm_tmpfile: command runs ok" {
  run bl64_fs_rm_tmpfile "$tempfile"
  assert_file_not_exist "$tempfile"
}

teardown() {
  if [[ -f "$tempfile" ]]; then
    rm -f "$tempfile"
  fi
}
