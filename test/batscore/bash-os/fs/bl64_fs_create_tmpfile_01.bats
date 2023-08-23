setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_create_tmpfile: command runs ok" {
  export tempfile="$(bl64_fs_create_tmpfile)"
  assert_file_exist "$tempfile"
}

teardown() {
  if [[ -f "$tempfile" ]]; then
    rm -f "$tempfile"
  fi
}
