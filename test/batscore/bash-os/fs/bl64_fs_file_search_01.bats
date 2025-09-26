@test "bl64_fs_file_search: required parameters. not path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fs_file_search '/fate/path'
  assert_failure

}
