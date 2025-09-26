@test "bl64_fs_file_search: find all in path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fs_file_search "$TESTMANSH_TEST_SAMPLES/dir_01"
  assert_success
  assert_output --partial "${TESTMANSH_TEST_SAMPLES}/dir_01/"

}
