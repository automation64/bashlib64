setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fs_find_files: find all in path" {

  run bl64_fs_find_files "$DEVBL_SAMPLES/dir_01"
  assert_success
  assert_output --partial "${DEVBL_SAMPLES}/dir_01/"

}
