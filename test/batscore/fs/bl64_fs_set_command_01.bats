setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fs_set_command: run function" {
  run bl64_fs_set_command
  assert_success
}
