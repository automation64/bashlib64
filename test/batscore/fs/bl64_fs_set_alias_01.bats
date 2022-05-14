setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fs_set_alias: run function" {
  run bl64_fs_set_alias
  assert_success
}
