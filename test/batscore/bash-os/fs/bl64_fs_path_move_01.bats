@test "bl64_fs_path_move: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_move
  assert_failure
}
