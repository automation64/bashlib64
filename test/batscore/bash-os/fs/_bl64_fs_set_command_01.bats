@test "_bl64_fs_set_command: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_fs_set_command
  assert_success
}
