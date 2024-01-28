setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  export tempfile="$(bl64_fs_create_tmpfile)"
}

@test "bl64_fs_rm_tmpfile: command runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_rm_tmpfile "$tempfile"
  assert_file_not_exist "$tempfile"
}

teardown() {
  if [[ -f "$tempfile" ]]; then
    rm -f "$tempfile"
  fi
}
