@test "bl64_fs_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_setup
  assert_success
}
