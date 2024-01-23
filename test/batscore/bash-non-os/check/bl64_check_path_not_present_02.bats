@test "bl64_check_path_not_present: file is present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_not_present "$BL64_FS_CMD_CP"
  assert_failure

}

@test "bl64_check_path_not_present: file is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_not_present '/fake/file'
  assert_success

}
