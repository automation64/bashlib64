setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fs_find_files: find pattern - found" {

  run bl64_fs_find_files "$DEVBL_SAMPLES" 'text_lines*'
  assert_success
  assert_output --partial "${DEVBL_SAMPLES}/text_lines"

}

@test "bl64_fs_find_files: find pattern - not found" {

  run bl64_fs_find_files "$DEVBL_SAMPLES" 'fake_files*'
  assert_success
  assert_output ''

}
