setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fs_find_files: find one file - found" {

  run bl64_fs_find_files "$DEVBL_SAMPLES" 'text_with_comments_01.txt'
  assert_success
  assert_output "${DEVBL_SAMPLES}/text_with_comments_01.txt"

}

@test "bl64_fs_find_files: find one file - not found" {

  run bl64_fs_find_files "$DEVBL_SAMPLES" 'fake_file'
  assert_success
  assert_output ''

}
