@test "bl64_fs_file_search: find pattern - found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fs_file_search "$TESTMANSH_TEST_SAMPLES" 'text_lines*'
  assert_success
  assert_output --partial "${TESTMANSH_TEST_SAMPLES}/text_lines"

}

@test "bl64_fs_file_search: find pattern - not found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fs_file_search "$TESTMANSH_TEST_SAMPLES" 'fake_files*'
  assert_success
  assert_output ''

}
