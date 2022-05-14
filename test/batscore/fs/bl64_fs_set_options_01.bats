setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fs_set_options: run function" {
  run bl64_fs_set_options
  assert_success
}
