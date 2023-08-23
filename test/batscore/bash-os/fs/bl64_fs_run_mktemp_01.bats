setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_run_mktemp: command runs ok" {
  tempfile="$(bl64_fs_run_mktemp)"
  assert_file_exist "$tempfile"
}

teardown() {
  [[ -f "$tempfile" ]] && rm -f "$tempfile"
}
