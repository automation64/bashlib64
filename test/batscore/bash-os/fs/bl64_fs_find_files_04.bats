@test "bl64_fs_find_files: find all in path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fs_find_files "$TESTMANSH_TEST_SAMPLES/dir_01"
  assert_success
  assert_output --partial "${TESTMANSH_TEST_SAMPLES}/dir_01/"

}
