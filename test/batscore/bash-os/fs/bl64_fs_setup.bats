setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_setup: module setup" {
  run bl64_fs_setup
  assert_success
}
