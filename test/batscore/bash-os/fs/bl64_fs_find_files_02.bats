@test "bl64_fs_find_files: find one file - found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fs_find_files "$TESTMANSH_TEST_SAMPLES" 'text_with_comments_01.txt'
  assert_success
  assert_output "${TESTMANSH_TEST_SAMPLES}/text_with_comments_01.txt"

}
