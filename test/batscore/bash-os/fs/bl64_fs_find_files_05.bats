@test "bl64_fs_find_files: find content - found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fs_find_files "$TESTMANSH_TEST_SAMPLES" '*.txt' 'PATTERN_FOR_SINGLE_LINE_MATCH'
  assert_success
  assert_output '--partial' "${TESTMANSH_TEST_SAMPLES}/text_03.txt"

}

@test "bl64_fs_find_files: find pattern - not found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fs_find_files "$TESTMANSH_TEST_SAMPLES" '*.txt' 'NOT TO BE FOUND'
  assert_success
  assert_output ''

}
